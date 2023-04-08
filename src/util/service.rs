use std::marker::PhantomData;
use std::sync::Arc;

use anyhow::Result;
use async_trait::async_trait;
use scylla::{FromRow, Session, _macro_internal::ValueList};
use uuid::Uuid;

/// `Model` is a trait that defines the basic properties of a model.
/// It is used to define important properties of a model.
pub trait Model: Send + Sync + 'static {
    /// The table enum that defines the tables that the model is associated with.
    type Tables: EnumValues + Send;

    /// A comma separated list of all the columns in the table to replace the asterisk in a query.
    fn asterisk() -> &'static str;
    /// A comma separated list of question marks to replace the values in an insert query.
    fn values() -> &'static str;
}

/// `BaseService` is a trait that defines the basic properties of a service.
#[async_trait]
pub trait Service<T>: Send + Sync
where
    T: Model + FromRow + ValueList + Send + Sync + 'static,
{
    async fn get_by_id(&self, table: T::Tables, id: Uuid) -> Result<Option<T>>;
}

pub struct BaseService<T>
where
    T: FromRow + Send + Sync + 'static,
{
    db: Arc<Session>,
    phantom: PhantomData<T>,
}

// I need to create some type of trait for the `value` in `get_by_key` and `get_many_by_key`
// so the `value` can be a number, string, anything, frankly.
// enum QueryValue {
//     String(String),
//     Uuid(Uuid),
//     Int(i32),
// }

// fn value_list(value: QueryValue) -> Box<dyn ValueList> {
//     match value {
//         QueryValue::String(s) => (s,),
//         QueryValue::Uuid(u) => (u,),
//         QueryValue::Int(i) => (i,),
//     }
// }

impl<T> BaseService<T>
where
    T: Model + FromRow + ValueList + Send + Sync + 'static,
{
    pub fn new(db: &Arc<Session>) -> Self {
        Self {
            db: Arc::clone(db),
            phantom: PhantomData,
        }
    }

    /// Fetches a `T` by its `id`
    pub async fn get_by_id(&self, table: T::Tables, id: Uuid) -> Result<Option<T>> {
        self.get_by_key(table, "id", id.to_string()).await
    }

    /// Fetches many `T`s by one `key` and one `value`
    pub async fn get_many_by_key(
        &self,
        table: T::Tables,
        key: &str,
        value: impl ValueList,
    ) -> Result<Vec<T>> {
        let query = self
            .db
            .prepare(format!(
                "SELECT {} FROM {} WHERE {key} = ?",
                T::asterisk(),
                table.as_str()
            ))
            .await?;

        let res = self.db.execute(&query, value).await?;

        match res.rows_typed::<T>() {
            Ok(xs) => Ok(xs.filter_map(|x| x.ok()).collect::<Vec<T>>()),
            Err(e) => {
                tracing::error!("err: {:?}", e);

                Ok(vec![])
            }
        }
    }

    /// Fetches many `T`s by one `key` and many `values`
    pub async fn get_many_by_keys(
        &self,
        table: T::Tables,
        key: &str,
        values: Vec<String>,
    ) -> Result<Vec<T>> {
        let query = self
            .db
            .prepare(format!(
                "SELECT {} FROM {} WHERE {key} IN ?",
                T::asterisk(),
                table.as_str()
            ))
            .await?;

        let res = self.db.execute(&query, (values,)).await?;

        match res.rows_typed::<T>() {
            Ok(xs) => Ok(xs.filter_map(|x| x.ok()).collect::<Vec<T>>()),
            Err(e) => {
                tracing::error!("err: {:?}", e);

                Ok(vec![])
            }
        }
    }

    /// Fetches a `T` by one `key` and one `value`
    pub async fn get_by_key(
        &self,
        table: T::Tables,
        key: &str,
        value: String,
    ) -> Result<Option<T>> {
        let query = self
            .db
            .prepare(format!(
                "SELECT {} FROM {} WHERE {key} = ?",
                T::asterisk(),
                table.as_str()
            ))
            .await?;

        let res = self.db.execute(&query, (value,)).await?;

        match res.single_row_typed::<T>() {
            Ok(data) => Ok(Some(data)),
            Err(e) => {
                println!("err: {:?}", e);
                Ok(None)
            }
        }
    }

    /// Creates a `T` in the database
    pub async fn create(&self, table: T::Tables, row: T) -> Result<T> {
        let query = self
            .db
            .prepare(format!(
                "INSERT INTO {} ({}) VALUES ({})",
                table.as_str(),
                T::asterisk(),
                T::values()
            ))
            .await?;

        let res = self.db.execute(&query, row).await?;

        match res.single_row_typed::<T>() {
            Ok(data) => Ok(data),
            Err(e) => {
                println!("err: {:?}", e);
                Err(e.into())
            }
        }
    }
}

#[async_trait]
impl<T> Service<T> for BaseService<T>
where
    T: Model + FromRow + ValueList + Send + Sync + 'static,
{
    async fn get_by_id(&self, table: T::Tables, id: Uuid) -> Result<Option<T>> {
        self.get_by_key(table, "id", id.to_string()).await
    }
}

/// EnumValues is a trait that allows us to get the string value of an enum
/// variant. This is useful for getting the name of tables and materialized view.
/// ```
/// enum MVs {
///		OrgById,
///		OrgBySlug,
/// }
///
/// impl EnumValues for MVs {
///    fn as_str(&self) -> &'static str {
/// 	  match self {
/// 		MVs::OrgById => "org_by_id",
/// 		MVs::OrgBySlug => "org_by_slug",
/// 	  }
///   }
/// }
/// ```
pub trait EnumValues {
    fn as_str(&self) -> &'static str;
}
