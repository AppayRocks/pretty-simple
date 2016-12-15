{-# LANGUAGE CPP #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}

{-|
Module      : Text.Pretty.Simple
Copyright   : (c) Dennis Gosnell, 2016
License     : BSD-style (see LICENSE file)
Maintainer  : cdep.illabout@gmail.com
Stability   : experimental
Portability : POSIX

-}
module Text.Pretty.Simple
  where

#if __GLASGOW_HASKELL__ < 710
-- We don't need this import for GHC 7.10 as it exports all required functions
-- from Prelude
import Control.Applicative
#endif

import Control.Monad.IO.Class (MonadIO, liftIO)

import Text.Pretty.Simple.Internal.Parser (expressionParse)
import Text.Pretty.Simple.Internal.Printer (expressionPrint)

prettyString :: String -> String
prettyString string =
  either (const string) expressionPrint $ expressionParse string

pShow :: Show a => a -> String
pShow = prettyString . show

pPrint :: (MonadIO m, Show a) => a -> m ()
pPrint = liftIO . putStrLn . pShow
