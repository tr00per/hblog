module Posts (
    BlogPost,
    posts
) where

import           Data.Char (toLower)
import           Data.List (intercalate)
import           Model

tr00per :: User
tr00per = User 1 "tr00per"

testTags :: Tags
testTags = Tags [Tag "test"]

mkTitle :: String -> Title
mkTitle real = Title {readable = real, permalink = normalize real}
    where normalize = join . map translate . words
          join      = intercalate "_"
          translate = map toLower

posts :: [BlogPost]
posts = [ BlogPost tr00per (DateTime "2016-03-21") testTags (mkTitle "Pierwszy post") "To jest pierwszy post"
        , BlogPost tr00per (DateTime "2016-03-22") testTags (mkTitle "Drugi post") "To jest drugi post!\n\nĄĆĘŁŃÓŚŹŻ ąćęłńóśźż"
        ]
