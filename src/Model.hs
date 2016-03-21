{-# LANGUAGE TemplateHaskell #-}
module Model (
    BlogPost (..),
    User (..),
    Title (..),
    DateTime (..),
    Tags (..),
    Tag (..)
) where

import           Data.Aeson
import           Data.Aeson.TH

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
