FROM rust:1.87.0

RUN  apt-get update \
  && apt-get install -y build-essential git curl wget clang \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/zorp-corp/nockchain.git

WORKDIR nockchain

RUN sed -i "s|^export MINING_PUBKEY .=.*$|export MINING_PUBKEY ?= 3jxFnKN9SMxTEeBSjmheAVRL41yJea3PCVgEdnGnC39LWjhqEmeNs1Kok4pwh1fnWkeio9ehAXZ2Lov9m2DPdk4tXBs4BSFuMydTDkXHGn51Jp31PuF9WsbNcTUUENKQ9w7b|" Makefile
RUN mv .env_example .env
RUN sed -i "s|^MINING_PUBKEY=.*$|MINING_PUBKEY=3jxFnKN9SMxTEeBSjmheAVRL41yJea3PCVgEdnGnC39LWjhqEmeNs1Kok4pwh1fnWkeio9ehAXZ2Lov9m2DPdk4tXBs4BSFuMydTDkXHGn51Jp31PuF9WsbNcTUUENKQ9w7b|" .env

RUN make install-hoonc
RUN make build
RUN make install-nockchain-wallet
RUN make install-nockchain

CMD [ "make", "run-nockchain" ]
