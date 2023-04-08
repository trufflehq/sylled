use std::{collections::HashMap, sync::Arc};

use crate::util::service::BaseService;
use anyhow::Result;
use async_graphql::{dataloader::Loader, FieldError};
use async_trait::async_trait;
use scylla::Session;

use super::model::{Episode, Tables};

#[async_trait]
pub trait BaseEpisodeService: Send + Sync {
    /// Fetches many `Episode`s by its author's surname
    async fn get_many_by_season(&self, season: i32) -> Result<Vec<Episode>>;

    /// Fetches many `Episode` by its year
    async fn get_many_by_episode(&self, year: i32) -> Result<Vec<Episode>>;

    /// Fetches many `Episode` by its year
    async fn get_many_by_year(&self, year: i32) -> Result<Vec<Episode>>;

    /// Fetches many `Episode` by show id
    async fn get_many_by_show_id(&self, show_id: i32) -> Result<Vec<Episode>>;

    /// Fetches many `Episode`s by ids
    async fn get_by_ids(&self, ids: Vec<uuid::Uuid>) -> Result<Vec<Episode>>;

    /// Creates a new `Episode`
    async fn create(&self, episode: Episode) -> Result<Episode>;
}

pub struct EpisodeService {
    base: BaseService<Episode>,
}

impl EpisodeService {
    pub fn new(db: &Arc<Session>) -> Self {
        Self {
            base: BaseService::new(db),
        }
    }
}

#[async_trait]
impl BaseEpisodeService for EpisodeService {
    async fn get_many_by_season(&self, season: i32) -> Result<Vec<Episode>> {
        self.base
            .get_many_by_key(Tables::EpisodeBySeason, "season", (season,))
            .await
    }

    async fn get_many_by_episode(&self, episode: i32) -> Result<Vec<Episode>> {
        self.base
            .get_many_by_key(Tables::EpisodeByEpisode, "episode", (episode,))
            .await
    }

    async fn get_many_by_year(&self, year: i32) -> Result<Vec<Episode>> {
        self.base
            .get_many_by_key(Tables::EpisodeByYear, "year", (year,))
            .await
    }

    async fn get_many_by_show_id(&self, show_id: i32) -> Result<Vec<Episode>> {
        self.base
            .get_many_by_key(Tables::EpisodebyShowId, "show_id", (show_id,))
            .await
    }

    async fn get_by_ids(&self, ids: Vec<uuid::Uuid>) -> Result<Vec<Episode>> {
        let values = ids.iter().map(|id| id.to_string()).collect::<Vec<String>>();

        self.base.get_many_by_keys(Tables::Episode, "id", values).await
    }

    async fn create(&self, episode: Episode) -> Result<Episode> {
        self.base.create(Tables::Episode, episode).await
    }
}

/// A dataloader for `Episode` instances
pub struct EpisodeLoader {
    /// The `EpisodeService` instance
    episodes: Arc<EpisodeService>,
}

/// The default implementation for `EpisodeLoader`
impl EpisodeLoader {
    /// Create a new `EpisodeLoader` instance
    pub fn new(episodes: &Arc<EpisodeService>) -> Self {
        Self {
            episodes: episodes.clone(),
        }
    }
}

#[async_trait]
impl Loader<uuid::Uuid> for EpisodeLoader {
    type Value = Episode;
    type Error = FieldError;

    async fn load(
        &self,
        keys: &[uuid::Uuid],
    ) -> Result<HashMap<uuid::Uuid, Self::Value>, Self::Error> {
        let xs = self.episodes.get_by_ids(keys.into()).await?;

        Ok(xs.into_iter().map(|x| (x.id, x)).collect())
    }
}
