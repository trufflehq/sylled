use crate::util::config::Config;
use anyhow::Result;
use axum::{
    extract::Extension,
    routing::{get, IntoMakeService},
    Router, Server,
};
use db::create_db;
use domains::episode::service::EpisodeService;
use graphql::create_schema;
use hyper::server::conn::AddrIncoming;
use router::{graphiql, graphql_handler, health_handler};
use scylla::Session;
use std::sync::Arc;
use tower_http::trace::{self, TraceLayer};

mod db;
pub mod domains;
/// GraphQL Schema Creation
mod graphql;
mod router;
pub mod util;

/// Dependencies needed by the resolvers
pub struct Context {
    /// The app config
    pub config: &'static Config,

    /// The database connections
    pub db: Arc<Session>,

    /// The `Episode`s entity service
    pub episodes: Arc<EpisodeService>,
}

/// Intialize dependencies
impl Context {
    /// Create a new set of dependencies based on the given shared resources
    pub async fn init(config: &'static Config) -> Result<Self> {
        let db = create_db().await?;

        Ok(Self {
            config,
            episodes: Arc::new(EpisodeService::new(&db)),
            db,
        })
    }
}

/// Start the server and return the bound address and a `Future`.
pub async fn run(ctx: Arc<Context>) -> Result<Server<AddrIncoming, IntoMakeService<Router>>> {
    let port = ctx.config.port;
    let schema = create_schema(ctx.clone())?;

    let app = Router::new()
        .route("/health", get(health_handler))
        .route("/graphql", get(graphiql).post(graphql_handler))
        .layer(
            TraceLayer::new_for_http()
                .make_span_with(trace::DefaultMakeSpan::new().level(tracing::Level::INFO))
                .on_response(trace::DefaultOnResponse::new().level(tracing::Level::INFO)),
        )
        .layer(Extension(ctx))
        .layer(Extension(schema));

    let server = Server::bind(
        &format!("0.0.0.0:{}", port)
            .parse()
            .expect("Unable to parse bind address"),
    )
    .serve(app.into_make_service());

    Ok(server)
}
