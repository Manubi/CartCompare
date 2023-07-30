import Foundation
import MapKit

struct Store: Identifiable {
    var id = UUID()
    var name: String
    var address: String
    var imageLogo: String
    var location: CLLocationCoordinate2D
    var groceries: [String: Double]
}

var storeList = [
    Store(name: "Billa", address: "Gonzagagasse 9, 1010 Wien", imageLogo: "billa_logo", location: CLLocationCoordinate2D(latitude: 48.21453, longitude: 16.37111), groceries: ["Apples": 2.59, "Bananas": 1.59, "Beef": 4.89, "Butter": 2.19, "Croissants": 2.0, "Milk": 1.69, "Sunflower Oil": 4.99, "Orange Juice": 1.19, "Potatoes": 2.0, "Red Bull": 1.49, "Spaghetti": 1.49, "Toast": 0.95, "Toilet Paper": 3.99, "Tomatoes": 0.69, "Yogurt": 0.39]),
    Store(name: "Hofer", address: "Neutorgasse, Heinrichsg, 2, 1, 1010 Wien", imageLogo: "hofer_logo", location: CLLocationCoordinate2D(latitude: 48.21397, longitude: 16.37015), groceries: ["Apples": 1.79, "Bananas": 1.69, "Beef": 3.99, "Butter": 1.85, "Croissants": 0.59, "Milk": 1.25, "Sunflower Oil": 2.19, "Orange Juice": 1.19, "Potatoes": 2.0, "Red Bull": 1.45, "Spaghetti": 1.48, "Toast": 0.89, "Toilet Paper": 2.98, "Tomatoes": 0.59, "Yogurt": 0.35]),
    Store(name: "Spar Gourmet", address: "Vorlaufstraße 3, 1010 Wien", imageLogo: "spar_logo", location: CLLocationCoordinate2D(latitude: 48.21248, longitude: 16.37259), groceries: ["Apples": 2.99, "Bananas": 1.69, "Beef": 5.58, "Butter": 2.59, "Croissants": 0.69, "Milk": 1.69, "Sunflower Oil": 3.49, "Orange Juice": 0.99, "Potatoes": 1.89, "Red Bull": 1.49, "Spaghetti": 1.59, "Toast": 0.95, "Toilet Paper": 3.99, "Tomatoes": 1.39, "Yogurt": 0.59])
    
]

extension Store {
    var cheapestItems: [String] {
        var cheapestItems = [String]()
        for (product, price) in groceries {
            let isCheapest = storeList.allSatisfy { otherStore in
                return otherStore.id == id || otherStore.groceries[product, default: .infinity] > price
            }
            if isCheapest {
                cheapestItems.append(product)
            }
        }
        return cheapestItems
    }
}
