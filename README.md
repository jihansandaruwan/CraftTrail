# CraftTrail Sri Lanka

A small picture-book iOS app about Sri Lankan crafts. Screens use flat vector drawings (SwiftUI shapes), not photographs. Ivory paper, forest green, terracotta, and thick dark outlines make the sticker look.

This project was prepared on Windows. It has not been compiled here. A Mac with Xcode is required to build and run it.

## What the app does

- Home: brand, search, category chips, craft cards, and craft towns
- Explore: a MapKit map of Sri Lanka with sample stops, plus a list
- Craft page: cartoon, short story, region, and a heart button
- Town page: the sample stop, a small map, and a link back to the craft
- Favourites: hearts saved on the phone with SwiftData
- Profile: guest name, light / dark / system appearance

Drag a craft drawing to tilt it. Swipe a favourite left to remove it. Search and filters work offline.

Workshop names are made up for the demo. The towns and craft traditions are real. The app says this on the town and craft pages.

## Technology

- Swift and SwiftUI
- iOS 17 or newer (SwiftData needs iOS 17)
- NavigationStack and a tab bar
- SwiftData for favourites only
- MapKit for the craft map
- No third-party packages

## What your friend needs

- A Mac
- Xcode 16 or newer
- An iPhone simulator running iOS 17 or newer
- A free Apple ID if they run it on a real iPhone. The simulator does not need a paid developer account.

## Open and run

1. Copy this `CraftTrail` folder to the Mac, or clone it from GitHub.
2. Open `CraftTrail.xcodeproj`.
3. At the top of Xcode, choose the **CraftTrail** scheme and an iPhone simulator.
4. Press Run.
5. If signing fails, open the CraftTrail target, go to **Signing & Capabilities**, and choose their Apple ID as the Team.

Map pictures load when the Mac or phone is online. The craft list still works offline.

## Tests

In Xcode choose **Product > Test**, or press Command-U.

- `CatalogTests` checks search, filters, demo labels, and that pins sit in Sri Lanka
- `FavouriteStoreTests` saves a heart in memory and removes it
- `CraftTrailUITests` opens the mask card, taps the heart, and checks Favourites

## Folder map

- `CraftTrail/` app source
- `Design/` colours and the sticker modifier
- `Illustrations/` the cartoon drawings
- `Data/SampleCatalog.swift` the crafts and towns (edit this to change content)
- `Data/CatalogSearch.swift` search and filters
- `Persistence/` SwiftData hearts and appearance
- `Views/` screens
- `CraftTrailTests/` and `CraftTrailUITests/`

## How to explain it in the viva

- The catalog is static sample data. Only hearts, the guest name, and the appearance choice are saved on the device.
- SwiftData is the persistence. That is why the deployment target is iOS 17.
- MapKit is the advanced framework. Pins are sample spots in real towns. The gold note on a page says the workshop name is not a real listing.
- `StickerCardModifier` is the custom SwiftUI modifier (paper card, dark outline, hard shadow).
- Drawings are original SwiftUI shapes so the app stays light and does not need photo files.
- Dark Mode is the Profile appearance picker. Text size follows the iPhone text-size setting. Card entrance animation turns off when Reduce Motion is on.

## If Xcode reports a build error

- “MapStyle has no member standard(elevation:pointsOfInterest:)”: in `ExploreView.swift` and `DestinationDetailView.swift`, change `.mapStyle(.standard(elevation: .flat, pointsOfInterest: .excludingAll))` to `.mapStyle(.standard)`.
- Signing error on a real phone: select a Team, as above. Use a simulator if there is no Apple ID handy.
- Missing simulator: Xcode, Settings, Components, install an iOS 17 or newer simulator.

## GitHub

From the `CraftTrail` folder (the one that contains `CraftTrail.xcodeproj`):

```bash
git init
git add .
git commit -m "Add CraftTrail Sri Lanka picture-book app"
git branch -M main
git remote add origin https://github.com/YOUR_NAME/CraftTrail.git
git push -u origin main
```

Do not commit the assignment PDF or the Labs folder unless you mean to. Push this folder only.

## AI-assisted development

Cursor was used to draft this first version from the SE4041 Part A brief and this direction: a simple Sri Lankan heritage app with a vector cartoon look, not a photo-heavy product. The student should be able to explain the screens, SwiftData, MapKit, and the sticker modifier, and should keep a short log of later prompts.

## Known limits

- Not compiled or tested on a Mac yet
- iPhone only
- No login and no server
- Seven crafts and seven demo stops
- Map tiles need a network connection the first time
