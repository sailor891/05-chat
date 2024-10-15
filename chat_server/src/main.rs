use anyhow::Result;
use chat_server::{get_router, AppConfig};
use tokio::net::TcpListener;
use tracing::{info, level_filters::LevelFilter};
use tracing_subscriber::{fmt::Layer, layer::SubscriberExt, util::SubscriberInitExt, Layer as _};

#[tokio::main]
async fn main() -> Result<()> {
    let layer = Layer::new().with_filter(LevelFilter::INFO);
    tracing_subscriber::registry().with(layer).init();

    let config = AppConfig::load()?;
    let addr = format!("127.0.0.1:{}", config.server.port);
    let listener = TcpListener::bind(&addr).await?;
    info!("listening on {}", addr);

    let app = get_router(config);
    axum::serve(listener, app.into_make_service()).await?;

    Ok(())
}
