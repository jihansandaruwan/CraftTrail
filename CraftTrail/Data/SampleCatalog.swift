import Foundation

/// Sample crafts and towns. Edit this file to change the catalog.
/// Workshop names are fictional. The traditions and towns are real places to read about.
enum SampleCatalog {
    static let crafts: [Craft] = [
        Craft(
            id: "mask",
            name: "Ambalangoda Masks",
            category: .masks,
            region: .southCoast,
            summary: "A painted fire mask with a tall flame crest and wide side flames.",
            story: "Ambalangoda, on the south coast, is known for carved wooden masks. The fire mask has a tall crest of flames, a flame fan on each side, round eyes, fangs, and a tongue. Masks like these are used in kolam theatre and in older folk traditions. The picture follows that mask.",
            studioNote: "Demo shed: Rainbow Grin Mask Shed in Ambalangoda.",
            motif: .mask
        ),
        Craft(
            id: "batik",
            name: "Coastal Batik",
            category: .batik,
            region: .southCoast,
            summary: "Cloth patterned with wax, then dyed in deep colours.",
            story: "Batik is a wax-resist way of dyeing cloth. Hot wax draws the pattern, dye colours the open cloth, and the wax is boiled away. Sri Lankan batik is especially associated with the south, with flowers, leaves, and bold shapes. The drawing shows a hanging cloth, not a photo of a workshop.",
            studioNote: "Demo table: Wax Flower Batik Table in Matara.",
            motif: .batik
        ),
        Craft(
            id: "laksha",
            name: "Kandyan Laksha",
            category: .lacquer,
            region: .hillCountry,
            summary: "Red and gold lacquer built up in smooth layers.",
            story: "Laksha is traditional lacquer work from the Kandyan hill country. Layers of lacquer are applied and polished until the surface shines, often red with fine gold pattern. You see it on bangles, walking sticks, and small wooden gifts. The stack of rings here stands in for that layered colour.",
            studioNote: "Demo bench: Red Lacquer Practice Bench in Kandy.",
            motif: .laksha
        ),
        Craft(
            id: "brass",
            name: "Brass Pahana",
            category: .brass,
            region: .hillCountry,
            summary: "A small brass oil lamp with a single flame.",
            story: "The pahana is a traditional oil lamp used in homes and at temples. Brass workers around Kandy, including the Pilimatalawa area, hammer and cast metal into lamps, trays, and vessels. The picture is a simple lamp, not a measured drawing of a ritual object.",
            studioNote: "Demo bench: Little Lamp Brass Bench in Pilimatalawa.",
            motif: .brass
        ),
        Craft(
            id: "dumbara",
            name: "Dumbara Weaving",
            category: .weaving,
            region: .hillCountry,
            summary: "Handwoven cloth with red and black geometric bands.",
            story: "Dumbara weaving comes from the Dumbara valley near Kandy. Weavers build repeating geometric bands, traditionally in red, black, and the natural colour of the fibre. The patterns are different from batik: they come from the loom, not from wax. The stripes in the app echo that woven look.",
            studioNote: "Demo loom: Red Thread Loom House in the Dumbara valley.",
            motif: .dumbara
        ),
        Craft(
            id: "beeralu",
            name: "Beeralu Lace",
            category: .lace,
            region: .southCoast,
            summary: "Bobbin lace with an open, flower-like pattern.",
            story: "Beeralu is bobbin lace made in the south, especially around Galle and Weligama. The maker works many small bobbins on a pillow, crossing threads into an open pattern. Pieces are often white or cream. The picture shows lace on a pillow, not a real pattern chart.",
            studioNote: "Demo veranda: Pillow Lace Veranda in Galle.",
            motif: .lace
        ),
        Craft(
            id: "sesath",
            name: "Perahera Sesath",
            category: .sesath,
            region: .hillCountry,
            summary: "A round ceremonial sunshade on a tall handle.",
            story: "A sesath is a ceremonial standard carried in processions, including the Kandy Esala Perahera. Makers build a round disc from palm leaf, mica, or coloured panels, then set it on a handle. The picture uses a round gold and red disc so the shape is easy to recognise.",
            studioNote: "Demo bench: Sun Disc Sesath Bench in Kandy.",
            motif: .sesath
        )
    ]

    static let destinations: [Destination] = [
        Destination(
            id: "ambalangoda",
            name: "Rainbow Grin Mask Shed",
            town: "Ambalangoda",
            mapLabel: "Masks",
            region: .southCoast,
            latitude: 6.235,
            longitude: 80.054,
            blurb: "A sample stop in the mask-making town on the south coast.",
            craftID: "mask",
            craftName: "Ambalangoda Masks",
            motif: .mask,
            isIllustrative: true
        ),
        Destination(
            id: "matara",
            name: "Wax Flower Batik Table",
            town: "Matara",
            mapLabel: "Batik",
            region: .southCoast,
            latitude: 5.949,
            longitude: 80.549,
            blurb: "A sample batik table in Matara, a southern town where dyed cloth is common.",
            craftID: "batik",
            craftName: "Coastal Batik",
            motif: .batik,
            isIllustrative: true
        ),
        Destination(
            id: "kandy-laksha",
            name: "Red Lacquer Practice Bench",
            town: "Kandy",
            mapLabel: "Laksha",
            region: .hillCountry,
            latitude: 7.293,
            longitude: 80.641,
            blurb: "A sample lacquer bench in Kandy, in the hill-country craft tradition.",
            craftID: "laksha",
            craftName: "Kandyan Laksha",
            motif: .laksha,
            isIllustrative: true
        ),
        Destination(
            id: "pilimatalawa",
            name: "Little Lamp Brass Bench",
            town: "Pilimatalawa",
            mapLabel: "Brass",
            region: .hillCountry,
            latitude: 7.264,
            longitude: 80.548,
            blurb: "A sample brass bench near Pilimatalawa, a town known for metalwork.",
            craftID: "brass",
            craftName: "Brass Pahana",
            motif: .brass,
            isIllustrative: true
        ),
        Destination(
            id: "dumbara",
            name: "Red Thread Loom House",
            town: "Dumbara Valley",
            mapLabel: "Weave",
            region: .hillCountry,
            latitude: 7.316,
            longitude: 80.768,
            blurb: "A sample loom house in the Dumbara valley, east of Kandy.",
            craftID: "dumbara",
            craftName: "Dumbara Weaving",
            motif: .dumbara,
            isIllustrative: true
        ),
        Destination(
            id: "galle",
            name: "Pillow Lace Veranda",
            town: "Galle",
            mapLabel: "Lace",
            region: .southCoast,
            latitude: 6.032,
            longitude: 80.217,
            blurb: "A sample lace veranda in Galle, on the southern coast.",
            craftID: "beeralu",
            craftName: "Beeralu Lace",
            motif: .lace,
            isIllustrative: true
        ),
        Destination(
            id: "kandy-sesath",
            name: "Sun Disc Sesath Bench",
            town: "Kandy",
            mapLabel: "Sesath",
            region: .hillCountry,
            latitude: 7.302,
            longitude: 80.625,
            blurb: "A sample sesath bench in Kandy, home of the Esala Perahera.",
            craftID: "sesath",
            craftName: "Perahera Sesath",
            motif: .sesath,
            isIllustrative: true
        )
    ]

    static func craft(_ id: String) -> Craft? {
        crafts.first { $0.id == id }
    }

    static func destination(_ id: String) -> Destination? {
        destinations.first { $0.id == id }
    }

    static func destination(forCraftID id: String) -> Destination? {
        destinations.first { $0.craftID == id }
    }
}
