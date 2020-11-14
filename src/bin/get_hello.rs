use core::handlers::handle_get_hello;
use lambda_http::lambda;

fn main() {
    lambda!(handle_get_hello)
}
