{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}
module Lib (
    startApp
) where

import           Network.Wai
import           Network.Wai.Handler.Warp
import           Posts                    (BlogPost, posts)
import           Servant

type API = "posts" :> Get '[JSON] [BlogPost]

server :: Server API
server = return posts

api :: Proxy API
api = Proxy

app :: Application
app = serve api server

startApp :: IO ()
startApp = run 8080 app
