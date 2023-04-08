use super::{
    model::Episode,
    service::{BaseEpisodeService, EpisodeService},
};
use async_graphql::{Context, InputObject, Object, Result};
use std::sync::Arc;

#[derive(Default)]
pub struct EpisodeQueries;

#[derive(InputObject)]
struct EpisodeInput {
    season: Option<i32>,
    episode: Option<i32>,
    year: Option<i32>,
    show_id: Option<i32>,
}

#[Object]
impl EpisodeQueries {
    // TODO: pagination
    async fn episodes(&self, ctx: &Context<'_>, input: EpisodeInput) -> Result<Vec<Episode>> {
        let books = ctx.data_unchecked::<Arc<EpisodeService>>();

        if let Some(year) = input.year {
            return Ok(books.get_many_by_year(year).await?);
        } else if let Some(episode) = input.episode {
            return Ok(books.get_many_by_episode(episode).await?);
        } else if let Some(season) = input.season {
            return Ok(books.get_many_by_season(season).await?);
        } else if let Some(show_id) = input.show_id {
            return Ok(books.get_many_by_show_id(show_id).await?);
        }

        Ok(vec![])
    }
}

#[derive(InputObject)]
pub struct CreateEpisodeInput {
    pub show_name: String,
    pub show_id: i32,
    pub title: String,
    pub season: i32,
    pub episode: i32,
    pub year: i32,
}

#[derive(Default)]
pub struct EpisodeMutations;

#[Object]
impl EpisodeMutations {
    async fn create_episode(&self, ctx: &Context<'_>, input: CreateEpisodeInput) -> Result<Episode> {
        let episodes = ctx.data_unchecked::<Arc<EpisodeService>>();

        let res = episodes.create(input.into()).await;

        match res {
            Ok(org) => Ok(org),
            Err(e) => {
                println!("err: {:?}", e);

                Err(e.into())
            }
        }
    }
}
