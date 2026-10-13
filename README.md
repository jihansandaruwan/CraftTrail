# CraftTrail Sri Lanka

CraftTrail is my SE4041 iOS app. It is a small guide to Sri Lankan crafts for someone who wants to see what the crafts are and which towns they come from.

The crafts in the app are Ambalangoda masks, coastal batik, Kandyan laksha, brass oil lamps, Dumbara weaving, beeralu lace, and the perahera sesath.

I did the pictures as cartoons instead of using photos. They are SwiftUI shapes with a dark outline, on cream cards, with green and terracotta as the main colours. I wanted it to feel like a sticker sheet, not a normal list app.

I built this on Windows, so I have not run it in the simulator myself. It needs a Mac with Xcode.

## Screens

- Home has search, craft categories, the craft cards, and the towns.
- Explore has a map of Sri Lanka and the same towns in a list.
- A craft page shows the drawing, a short description, the region, and a heart button.
- A town page shows the sample stop and links back to the craft.
- Favourites keeps whatever you heart. It is still there after you close the app.
- Profile is just a guest name, plus light, dark, or system appearance.

You can drag a craft drawing and it tilts a bit. On Favourites, swipe left to remove one.

The towns are real. The workshop names are made up for this demo, and the app says that on the page.

## How to run

1. Clone this repo.
2. Open `CraftTrail.xcodeproj`.
3. Choose the CraftTrail scheme and an iPhone simulator on iOS 17 or later.
4. Press Run.

If Xcode asks for a Team, use your Apple ID. A simulator does not need a paid developer account.

The map picture needs internet. Search and the lists work without it.

iOS 17 is the lowest version because favourites are saved with SwiftData.

## What I used

Swift, SwiftUI, NavigationStack, a tab bar, SwiftData, and MapKit. I did not add any third-party libraries.

## Tests

In Xcode, Product > Test.

- `CatalogTests` checks search, filters, and that the map points are in Sri Lanka.
- `FavouriteStoreTests` saves a heart and removes it.
- `CraftTrailUITests` opens the mask, taps the heart, and checks Favourites.

## Where things are

- `CraftTrail/Views` — screens
- `CraftTrail/Illustrations` — the cartoon drawings
- `CraftTrail/Design` — colours and the sticker card style
- `CraftTrail/Data/SampleCatalog.swift` — the craft and town text
- `CraftTrail/Data/CatalogSearch.swift` — search and filters
- `CraftTrail/Persistence` — saved hearts and the appearance setting
- `CraftTrailTests` and `CraftTrailUITests`

## If it does not build

If Xcode complains about `mapStyle`, open `ExploreView.swift` and `DestinationDetailView.swift` and change that line to `.mapStyle(.standard)`.

If a real iPhone will not run, set the Team under Signing & Capabilities. The simulator is enough for the demo.

I used Cursor to help me set the project up and write parts of the code. The app idea, the crafts, and the cartoon look are mine, and I can explain the screens, how saving works, and how the map is used.
