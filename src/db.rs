use std::sync::Arc;

use scylla::{Session, SessionBuilder};

pub async fn create_db() -> anyhow::Result<Arc<Session>> {
    let session = /*CachingSession::from(*/
        SessionBuilder::new()
            .known_node("127.0.0.1:9042")
            .build()
            .await?;
    // 1_000,
    // );

    // Use the keyspace
    session.use_keyspace("kune", false).await?;

    Ok(Arc::new(session))
}
