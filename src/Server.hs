{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Server where

import Data.Aeson (ToJSON)
import Data.Data (Proxy (Proxy))
import GHC.Generics (Generic)
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Servant (Get, Server, (:>))
import Servant.API (JSON)
import Servant.Server (serve)

newtype StatusResponse = StatusResponse
  { status :: String
  }
  deriving (Generic, Eq, Show, Ord)

instance ToJSON StatusResponse

type StatusEndpoint = "status" :> Get '[JSON] StatusResponse

type API = StatusEndpoint

api :: Proxy API
api = Proxy

app :: Application
app = serve api server

startServer :: IO ()
startServer = run 8080 app

server :: Server API
server = pure ok
  where
    ok = StatusResponse "ok"
