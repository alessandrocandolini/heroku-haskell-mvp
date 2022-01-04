{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Server where

import Data.Aeson (ToJSON)
import Data.Data (Proxy (Proxy))
import Data.Maybe (fromMaybe)
import GHC.Generics (Generic)
import Network.Wai (Application)
import Network.Wai.Handler.Warp (Settings, defaultSettings, run, runSettings, setHost, setPort, setTimeout)
import Servant (Get, Server, (:>))
import Servant.API (JSON)
import Servant.Server (serve)
import System.Environment (lookupEnv)
import Text.Read (readMaybe)

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

settings :: IO Settings
settings = buildSettings . parsePort <$> lookupEnv "PORT"

parsePort :: Maybe String -> Int
parsePort = fromMaybe 8080 . (=<<) readMaybe

buildSettings :: Int -> Settings
buildSettings port = setTimeout 30 $ setPort port $ setHost "0.0.0.0" defaultSettings

startServer :: IO ()
startServer = settings >>= \s -> runSettings s app

server :: Server API
server = pure ok
  where
    ok = StatusResponse "ok"
