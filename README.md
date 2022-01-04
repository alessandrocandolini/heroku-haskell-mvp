# heroku-haskell-mvp

[![CI](https://github.com/alessandrocandolini/heroku-haskell-mvp/actions/workflows/ci.yml/badge.svg)](https://github.com/alessandrocandolini/heroku-haskell-mvp/actions/workflows/ci.yml) [![codecov](https://codecov.io/gh/alessandrocandolini/heroku-haskell-mvp/branch/main/graph/badge.svg?token=JFTWHU7AQE)](https://codecov.io/gh/alessandrocandolini/heroku-haskell-mvp)

## How to build and run locally

The project uses the [Haskell tool stack](https://docs.haskellstack.org/en/stable/README/).

Assuming `stack` is installed in the system, the project can be build by running
```
stack build
```
To build and also run the tests, run
```
stack test
```
which is equivalent to
```
stack build --test
```
To run tests with coverage
```
stack test --coverage
```
which produces textual and html reports.

To run the executable,
```
stack exec heroku-haskell-mvp-exe
```
If `curl` is available on the machine, the server can be reached using 
```
curl http://localhost:8080/status
```

For faster feedback loop,
```
stack test --fast --file-watch
```
To run `ghci` (with a version compatible with the resolver) run
```
stack ghci
```
For more information, refer to the `stack` official docs.
