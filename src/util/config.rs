use once_cell::sync::Lazy;
use serde::{Deserialize, Serialize};

static CONFIG: Lazy<Config> = Lazy::new(|| Config::new().expect("Unable to retrieve config"));

/// Application Config
#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Config {
    /// The environment
    pub env: String,
    /// The port to bind to
    pub port: u16,
    /// Scylla node
    pub scylla_node: String,
}

impl Config {
    /// Create a new `Config`
    pub fn new() -> anyhow::Result<Self> {
        let config = envy::from_env::<Self>()?;

        Ok(config)
    }

    pub fn is_dev(&self) -> bool {
        self.env == "development"
    }
}

/// Get the default static `Config`
pub fn get_config() -> &'static Config {
    &CONFIG
}
