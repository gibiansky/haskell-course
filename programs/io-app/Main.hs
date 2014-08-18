{-# LANGUAGE OverloadedStrings #-}
import Graphics.Vty.Widgets.All
import Data.Text

-- | Add a border with a label to a widget.
label :: Show a => IO (Widget a) -> Text -> IO (Widget (Bordered a))
label widget label = do
  bord <- widget >>= bordered
  withBorderedLabel label bord

main = do
  -- Create my three main areas.
  topLeft <- plainText "Top left" `label` "First"
  topRight <- plainText "Top right" `label` "Second"
  bottom <- plainText "Top bottom" `label` "Third"

  -- Add a title.
  title <- hBorder
  setHBorderLabel title "My Pretty UI"

  -- Combine everything into a single widget using boxes.
  topBox <- hBox topLeft topRight
  mainBox <- vBox topBox bottom
  full <- vBox title mainBox

  -- Put things in focus groups and collections as needed.
  fg <- newFocusGroup
  addToFocusGroup fg mainBox
  collection <- newCollection
  addToCollection collection full fg

  -- Run the UI.
  runUi collection defaultContext

