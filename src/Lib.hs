{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
    ( startApp
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Data.List (intercalate)
import Data.Char (toLower)

data BlogPost = BlogPost {
    user  :: User,
    date  :: DateTime,
    tags  :: Tags,
    title :: Title,
    body  :: String
} deriving (Eq, Show)

data User = User {
    userId   :: Int,
    userName :: String
} deriving (Eq, Show)

data Title = Title {
    readable  :: String,
    permalink :: String
} deriving (Eq, Show)

newtype DateTime = DateTime String deriving (Eq, Show)
newtype Tags = Tags [Tag] deriving (Eq, Show)
newtype Tag = Tag String deriving (Eq, Show)

$(deriveJSON defaultOptions ''BlogPost)
$(deriveJSON defaultOptions ''User)
$(deriveJSON defaultOptions ''Title)
$(deriveJSON defaultOptions ''DateTime)
$(deriveJSON defaultOptions ''Tags)
$(deriveJSON defaultOptions ''Tag)

type API = "posts" :> Get '[JSON] [BlogPost]

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return users

tr00per :: User
tr00per = User 1 "tr00per"

testTags :: Tags
testTags = Tags [Tag "test"]

mkTitle :: String -> Title
mkTitle real = Title {readable = real, permalink = normalize real}
    where normalize = join . map translate . words
          join      = intercalate "_"
          translate = map toLower

users :: [BlogPost]
users = [ BlogPost tr00per (DateTime "2016-03-21") testTags (mkTitle "Pierwszy post") "To jest pierwszy post"
        , BlogPost tr00per (DateTime "2016-03-22") testTags (mkTitle "Drugi post") "To jest drugi post!\n\nĄĆĘŁŃÓŚŹŻ ąćęłńóśźż"
        ]
