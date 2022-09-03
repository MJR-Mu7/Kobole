## Alpine is at times outdated. Ubuntu is best when building Kobole.
FROM ubuntu:latest as final
FROM ubuntu:bionic AS builder
LABEL maintainer="❤️ MJR.Mu7 : @mjr_mu7"
LABEL description="1st Stage of the Multistage Docker image for Kobole NPoS. Here we create the binary."

# The node will be built in this directory
WORKDIR /kobo

RUN apt -y update && \
	apt install -y --no-install-recommends \
	software-properties-common curl git file binutils binutils-dev \
	make cmake ca-certificates g++ zip dpkg-dev python openssl gettext\
	build-essential pkg-config libssl-dev libudev-dev time clang

# install rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# rustup directory
ENV PATH /root/.cargo/bin:$PATH

# set default rust compiler and updating to latest rust
RUN rustup default stable && rustup update

# update nightly channel
RUN rustup update nightly

# install wasm toolchain for kobole
RUN rustup target add wasm32-unknown-unknown --toolchain nightly

#compiler ENV
ENV CC gcc
ENV CXX g++

# Copy code to build directory, instead of only using .dockerignore, we copy elements
# explicitly. This lets us cache build results while iterating on scripts.
COPY latte latte
COPY pallets pallets
COPY primitives primitives
COPY res res
COPY Cargo.toml .
COPY Cargo.lock .

# Build latte.
RUN cargo fetch # cache the result of the fetch in case the build gets interrupted
RUN cargo build --release

# Build subkey.
#RUN curl https://getsubstrate.io -sSf | bash -s -- --fast && \
#	 cargo install --force subkey --git https://github.com/paritytech/substrate --version 2.0.2 --locked

# Final stage. Copy the kobole executable and subkey.
FROM final
LABEL maintainer="❤️ MJR.Mu7 : @mjr_mu7" \
	 description="2nd build stage for Kobole. Here we copy the binary."

# curl is required for uploading to keystore
# note: `subkey insert` is a potential alternarve to curl
RUN apt -y update && apt upgrade -y && \
#	apt install -y --no-install-recommends \
#	software-properties-common curl ca-certificates
	rm -rf /var/lib/apt/lists/*

# apt cleanup
RUN	apt-get autoremove -y && \
	apt-get clean && \
	find /var/lib/apt/lists/ -type f -not -name lock -delete; \
# add user
	useradd -m -u 1000 -U -s /bin/sh -d /kobole kobole

# add kobole binary to docker image
COPY --from=builder /kobo/target/release/kobole /usr/local/bin

USER kobole
LABEL description="Kobole, a Nominated Proof of Stake, NFT enabled DAO enabling WASM Smart Contracts. 🚀🚀🚀🚀 "

# check if executable works in this container
RUN /usr/local/bin/kobole --version

EXPOSE 30336 9936 9946
VOLUME ["/kobole"]

ENTRYPOINT ["/usr/local/bin/kobole"]
