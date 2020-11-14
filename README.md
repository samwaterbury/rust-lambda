# Serverless API with Rust

Simple example demonstrating a serverless, Rust-powered API implementation.

![](https://d2908q01vomqb2.cloudfront.net/ca3512f4dfa95a03169c5a670a4c91a19b3077b4/2018/11/23/rust_lambda_logo.png)

## Background

AWS provides a [Rust runtime](https://github.com/awslabs/aws-lambda-rust-runtime) for creating Lambda functions. You can find an article about it [here](https://aws.amazon.com/blogs/opensource/rust-runtime-for-aws-lambda/).

Using Lambda functions as request handlers allows for fast responses with virtually unlimited scalability. However, those handlers become the bottleneck when they're implemented using slow runtimes like Python. On the other hand, Rust-implemented handlers should (in theory) achieve nearly the fastest possible performance without losing the benefits of serverless.

This repository provides a _minimal_ example of combining Rust with AWS Lambda to produce a very fast and scalable API. In this setup, AWS API Gateway proxies requests to the correct Lambda function, which then formulates and returns a response.

Please keep in mind that this is still a work-in-progress! Feel free to contribute.

## Development Environment

### Setup for macOS

First add the `86_64-unknown-linux-musl` target:

```sh
rustup target add x86_64-unknown-linux-musl && rustup update
```

Then install a linker for the target platform:

```sh
brew install filosottile/musl-cross/musl-cross
```

Lastly, create an entry in `.cargo/config` telling Cargo to use this linker:

```sh
mkdir -p .cargo \
    && echo -e '[target.x86_64-unknown-linux-musl]\nlinker = "x86_64-linux-musl-gcc"' \
    > .cargo/config
```

Alternatively, Docker images exist which can provide an isolated environment to build the executables in.

## Build and Deploy

You can compile the handler executables with:

```sh
cargo build [--release]
```

To create a single OpenAPI specification file, run:

```sh
npx @redocly/openapi-cli bundle --ext json openapi/openapi.json \
    > openapi/_bundled.json
```

## Local Testing

### Local API Server

**Note:** Docker will need to be installed to run the mock server locally.

Start by installing the [AWS Serverless Application Model (SAM) CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html):

```sh
brew tap aws/tap
brew install awscli aws-sam-cli
```

Build the lambda executables and run the local API Gateway server:

```sh
sam build && sam local start-api
```

You should now be able to hit the API mounted at [`http://localhost:3000/hello`](http://localhost:3000/hello).

### API Linting

The API specification in `openapi` adheres to the [OpenAPI specification](https://github.com/OAI/OpenAPI-Specification/) and can be linted with:

```sh
npx @redocly/openapi-cli lint openapi/openapi.json
```