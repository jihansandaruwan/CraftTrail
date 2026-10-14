import MapKit
import SwiftUI

/// One pin on the craft map.
struct CraftMapPin: Identifiable, Equatable {
    let id: String
    let title: String
    let latitude: Double
    let longitude: Double
    let symbolName: String
    let selected: Bool
}

/// Apple's map as MKMapView.
/// SwiftUI Map was drawing an empty grid on a real iPhone, so this uses MKMapView instead.
struct CraftMap: UIViewRepresentable {
    var pins: [CraftMapPin]
    var region: MKCoordinateRegion
    var allowsPan: Bool = true
    var onSelect: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect)
    }

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.pointOfInterestFilter = .excludingAll
        map.mapType = .standard
        map.isRotateEnabled = false
        map.isPitchEnabled = false
        map.showsCompass = false
        return map
    }

    func updateUIView(_ map: MKMapView, context: Context) {
        context.coordinator.onSelect = onSelect
        map.isScrollEnabled = allowsPan
        map.isZoomEnabled = true

        let selectionChanged = context.coordinator.noteSelection(pins)
        let shownIDs = Set(map.annotations.compactMap { ($0 as? CraftPin)?.id })
        let nextIDs = Set(pins.map(\.id))
        if shownIDs != nextIDs || selectionChanged {
            map.removeAnnotations(map.annotations)
            map.addAnnotations(pins.map(CraftPin.init))
        }

        let key = Self.regionKey(region)
        if context.coordinator.regionKey != key {
            let shouldAnimate = !context.coordinator.regionKey.isEmpty
            map.setRegion(region, animated: shouldAnimate)
            context.coordinator.regionKey = key
        }
    }

    private static func regionKey(_ region: MKCoordinateRegion) -> String {
        String(
            format: "%.3f,%.3f,%.3f,%.3f",
            region.center.latitude,
            region.center.longitude,
            region.span.latitudeDelta,
            region.span.longitudeDelta
        )
    }

    final class Coordinator: NSObject, MKMapViewDelegate {
        var onSelect: (String) -> Void
        var regionKey = ""
        private var selectionKey = ""

        init(onSelect: @escaping (String) -> Void) {
            self.onSelect = onSelect
        }

        func noteSelection(_ pins: [CraftMapPin]) -> Bool {
            let key = pins.map { "\($0.id):\($0.selected)" }.joined(separator: "|")
            if key == selectionKey { return false }
            selectionKey = key
            return true
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let pin = annotation as? CraftPin else { return nil }
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "craft-pin")
                ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "craft-pin")
            view.annotation = annotation
            guard let marker = view as? MKMarkerAnnotationView else { return view }
            marker.glyphImage = UIImage(systemName: pin.symbolName)
            marker.markerTintColor = pin.selected
                ? UIColor(red: 0.769, green: 0.384, blue: 0.176, alpha: 1)
                : UIColor(red: 0.122, green: 0.302, blue: 0.227, alpha: 1)
            marker.glyphTintColor = .white
            marker.canShowCallout = false
            return marker
        }

        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            guard let pin = annotation as? CraftPin else { return }
            mapView.deselectAnnotation(annotation, animated: false)
            onSelect(pin.id)
        }
    }
}

final class CraftPin: NSObject, MKAnnotation {
    let id: String
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let symbolName: String
    let selected: Bool

    init(_ pin: CraftMapPin) {
        id = pin.id
        coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
        title = pin.title
        symbolName = pin.symbolName
        selected = pin.selected
    }
}
