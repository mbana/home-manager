
```sh
# https://github.com/pyca/cryptography/issues/6679
CARGO_BUILD_TARGET=aarch64-linux-android CARGO_CFG_TARGET_OS=linux CARGO_NET_GIT_FETCH_WITH_CLI=true cargo test --release
```