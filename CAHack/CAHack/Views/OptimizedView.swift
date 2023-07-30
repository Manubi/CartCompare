import SwiftUI
import MapKit

struct OptimizedView: View {
    
    @EnvironmentObject var cartManager: CartManager
    @StateObject var locationManager = LocationManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var annotations: [MKPointAnnotation] = []
    @Binding var selectedTab: Int

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Map Overview")
                            .font(.title2).bold()
                        
                        Spacer()
                    }
                    .padding(.top, 0)
                    .padding(.leading, 16)
                    
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: storeList) { store in
                        MapAnnotation(coordinate: store.location) {
                            LocationMapAnnotationView(store: store)
                                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 3, x: 1, y: 1)
                        }                    }
                    .cornerRadius(20)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .padding([.trailing, .leading], 16)
                    
                    HStack {
                        Text("Your Shop")
                            .font(.title2).bold()
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.leading, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(shopFilters, id: \.id) { filter in
                                FilterTag(filter: filter)
                                    .environmentObject(cartManager)
                            }
                            .padding(.trailing, 0)
                        }
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom , 4)
                        .padding(.top, 0)
                    }
                    
                    ShopOverviewView(stores: [storeList[1]])
                        .environmentObject(cartManager)
                        .padding([.leading, .trailing], 16)
                    
                    HStack {
                        Text("Breakdown by store")
                            .font(.title3).bold()
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.leading, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(storeList, id: \.id) { store in
                                StoreView(store: store)
                                    .environmentObject(cartManager)
                            }
                            .padding(.trailing, 0)
                        }
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom , 4)
                        .padding(.top, 10)
                    }
                    
                    HStack {
                        Spacer()
                        
                        proceedButton
                        
                        Spacer()
                    }
                    .padding([.bottom, .top], 24)

                    Spacer()
                    
                }
                .onAppear {
                    self.annotations = storeList.map { store in
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = store.location
                        annotation.title = store.name
                        return annotation
                    }
                }
            }
        }
    }
}



struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        view.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    }
}

extension OptimizedView {
    
    private var proceedButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            self.selectedTab = 0
        }) {
            Text("Save your shop")
                .font(.headline)
                .frame(height: 35)
                .padding([.leading, .trailing], 16)
        }
        .buttonStyle(.borderedProminent)
    }
}
