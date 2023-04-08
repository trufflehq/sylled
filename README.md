# Sylled
> Psyched to have a Scylla ORM (kinda?)

## Local Development

Install Rust with [rustup](https://rustup.rs/).

### Clippy

For helpful linting rools, install [Clippy](https://github.com/rust-lang/rust-clippy) with `rustup`:

```sh
rustup component add clippy
```

Run it with `cargo`:

```sh
cargo clippy --fix
```

### Cargo Make

To build scripts from the _Makefile.toml_, install Cargo Make:

```sh
cargo install cargo-make
```

Run "setup" to install some tooling dependencies:

```sh
cargo make setup
```

### Configuration

See `.env.example`

### Running Docker

To run the Compose formation with just the supporting services needed to run `cargo make dev`:

```sh
docker compose up -d
```

To shut it down:

```sh
docker compose down
```

### Running the Local dev server

Use `cargo` to run the dev server locally:

```sh
cargo make dev
```

### Update Dependencies

First, install the `outdated` command for `cargo`:

```sh
cargo install --locked cargo-outdated
```

Then, update and check for any major dependency changes:

```sh
cargo update
cargo outdated
```
