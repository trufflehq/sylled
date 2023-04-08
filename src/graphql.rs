use anyhow::Result;
use async_graphql::{dataloader::DataLoader, EmptySubscription, MergedObject, Schema};
use std::sync::Arc;

use crate::{
    domains::episode::{
        graphql::{EpisodeMutations, EpisodeQueries},
        service::EpisodeLoader,
    },
    Context,
};

/// The GraphQL top-level Query type
#[derive(MergedObject, Default)]
pub struct Query(EpisodeQueries);

/// The GraphQL top-level Mutation type
#[derive(MergedObject, Default)]
pub struct Mutation(EpisodeMutations);

/// The application's top-level merged GraphQL schema
pub type GraphQLSchema = Schema<Query, Mutation, EmptySubscription>;

/// Initialize all necessary dependencies to create a `GraphQLSchema`. Very simple dependency
/// injection based on async-graphql's `.data()` calls.
pub fn create_schema(ctx: Arc<Context>) -> Result<GraphQLSchema> {
    // Instantiate loaders
    let episode_loader = EpisodeLoader::new(&ctx.episodes);

    // Inject the initialized services into the `Schema` instance.
    Ok(
        Schema::build(Query::default(), Mutation::default(), EmptySubscription)
            .data(ctx.config)
            .data(ctx.episodes.clone())
            .data(DataLoader::new(episode_loader, tokio::spawn))
            .finish(),
    )
}
