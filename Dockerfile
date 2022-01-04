
# BUILDER

FROM fpco/stack-build:lts-18.21 as builder

# run from non-root folder
RUN mkdir /work
WORKDIR /work

# Install dependencies
RUN apt-get update && apt-get install -y curl bash tar ca-certificates make git procps \
       && rm -rf /var/lib/apt/lists/*

# compile
COPY . /work
RUN stack test
RUN stack install --local-bin-path /work/

# RUNNER

FROM ubuntu:latest

# create and run as a non-root user:
RUN useradd -m appuser
WORKDIR /home/appuser
USER appuser

COPY --from=builder --chown=appuser /work/heroku-haskell-mvp-exe run 

CMD ["run"]
