use crate::util::service::{EnumValues, Model};
use async_graphql::SimpleObject;
use scylla::{FromRow, ValueList};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use super::graphql::CreateEpisodeInput;

// the tables enum
pub enum Tables {
    Episode,
    EpisodeBySeason,
    EpisodeByEpisode,
    EpisodeByYear,
    EpisodebyShowId,
}

// the enum values
impl EnumValues for Tables {
    fn as_str(&self) -> &'static str {
        match self {
            Tables::Episode => "episode",
            Tables::EpisodeBySeason => "episode_by_season",
            Tables::EpisodeByEpisode => "episode_by_episode",
            Tables::EpisodeByYear => "episode_by_year",
            Tables::EpisodebyShowId => "episode_by_show_id",
        }
    }
}

// the actual model itself
#[derive(Deserialize, Serialize, FromRow, ValueList, Debug, Clone, SimpleObject)]
pub struct Episode {
    pub id: Uuid,
    pub show_name: String,
    pub show_id: i32,
    pub title: String,
    pub season: i32,
    pub episode: i32,
    pub year: i32,
}

impl Model for Episode {
    type Tables = Tables;

    fn asterisk() -> &'static str {
        "id, show_name, show_id, title, season, episode, year"
    }

    fn values() -> &'static str {
        "?, ?, ?, ?, ?, ?, ?"
    }
}

// utils for creating books
impl From<CreateEpisodeInput> for Episode {
    fn from(input: CreateEpisodeInput) -> Self {
        Self {
            id: Uuid::new_v4(),
            show_name: input.show_name,
            show_id: input.show_id,
            title: input.title,
            season: input.season,
            episode: input.episode,
            year: input.year,
        }
    }
}
