use async_graphql::http::GraphiQLSource;
use async_graphql_axum::{GraphQLRequest, GraphQLResponse};
use axum::{
    extract::Extension,
    response::{Html, IntoResponse},
};
use serde_json::json;

use crate::graphql::GraphQLSchema;

/// Handle health check requests
pub async fn health_handler() -> impl IntoResponse {
    json!({
        "code": "200",
        "success": true,
    })
    .to_string()
}

/// Handle GraphiQL Requests
pub async fn graphiql() -> impl IntoResponse {
    Html(GraphiQLSource::build().endpoint("/graphql").finish())
}

/// Handle GraphQL Requests
pub async fn graphql_handler(
    Extension(schema): Extension<GraphQLSchema>,
    req: GraphQLRequest,
) -> GraphQLResponse {
    schema.execute(req.into_inner()).await.into()
}
