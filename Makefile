# This Makefile is only used by the Serverless Application Model (SAM) CLI for
# local development purposes. For anything else, cargo-make is recommended.

# This command does not need to be modified. It takes a single argument BINARY
# which represents the name of one of the Rust handler binaries. The executable
# for that handler will be compiled for the Lambda target and copied into the
# artifacts directory used by the SAM CLI.
#
# The ARTIFACTS_DIR variable is provided by the SAM CLI when it invokes the
# Makefile. Therefore it does not need to be manually specified anywhere.
build-binary:
	cargo build \
		--bin "${BINARY}" \
		--release \
		--target x86_64-unknown-linux-musl
	mkdir -p "./target/x86_64-unknown-linux-musl/output/${BINARY}"
	cp "./target/x86_64-unknown-linux-musl/release/${BINARY}" \
		"./target/x86_64-unknown-linux-musl/output/${BINARY}/bootstrap"
	cp "./target/x86_64-unknown-linux-musl/output/${BINARY}/bootstrap" \
		$(ARTIFACTS_DIR)

# An example command corresponding to a single handler. It should be duplicated
# for every Rust binary in the project.
build-GetHelloFunction:
	$(MAKE) build-binary BINARY="get_hello"

build-all:
	build-GetHelloFunction
