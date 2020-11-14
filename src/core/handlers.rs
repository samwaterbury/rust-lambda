use lambda_http::{Body, Request, Response};
use lambda_runtime::{error::HandlerError, Context};
use serde_json::json;

pub fn handle_get_hello(
    _request: Request,
    _context: Context,
) -> Result<Response<Body>, HandlerError> {
    let body = json!({"message": "Hello! Have a great day."});
    let response = Response::builder()
        .status(200)
        .header("content-type", "application/json")
        .body(Body::from(serde_json::to_string(&body)?))
        .unwrap();

    Ok(response)
}
