use axum::response::IntoResponse;

// pub(crate) fn 将函数 限制在 这个mod所在的crate，仅在当前crate内可见，不向外暴露
// 如果要向这个mod所在的crate外暴露，则使用pub然后再mod.rs中使用pub use ...
pub(crate) async fn signin_handler() -> impl IntoResponse {
    "Signin!"
}
pub(crate) async fn signup_handler() -> impl IntoResponse {
    "Signup!"
}
