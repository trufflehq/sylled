use std::sync::Arc;

use anyhow::Result;
use sylled::{run, util::config::get_config, Context};
use tracing_subscriber::prelude::*;

#[macro_use]
extern crate tracing;

#[tokio::main]
async fn main() -> Result<()> {
    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new(
            std::env::var("RUST_LOG").unwrap_or_else(|_| "info".into()),
        ))
        .with(tracing_subscriber::fmt::layer())
        .init();

    let config = get_config();
    let context = Arc::new(Context::init(config).await?);

    let server = run(context).await?;
    let addr = server.local_addr();

    if config.is_dev() {
        info!("Started at: http://localhost:{port}", port = addr.port());

        info!(
            "GraphQL at: http://localhost:{port}/graphql",
            port = addr.port()
        );
    } else {
        info!("Started on port: {port}", port = addr.port());
    };

    server.await?;

    Ok(())
}
