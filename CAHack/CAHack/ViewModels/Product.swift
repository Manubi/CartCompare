import Foundation

struct Product: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var minPrice, maxPrice: Double
}

var productList = [
    Product(name: "Apples", image: "apple", minPrice: 2.59, maxPrice: 2.99),
    Product(name: "Bananas", image: "banana", minPrice: 1.59, maxPrice: 1.69),
    Product(name: "Beef", image: "beef", minPrice: 4.89, maxPrice: 5.58),
    Product(name: "Butter", image: "butter", minPrice: 2.19, maxPrice: 2.59),
    Product(name: "Croissants", image: "croissants", minPrice: 0.59, maxPrice: 0.99),
    
    Product(name: "Milk", image: "milk", minPrice: 1.25, maxPrice: 2.0),
    Product(name: "Oil", image: "oil", minPrice: 2.19, maxPrice: 4.99),
    Product(name: "Juice", image: "orangejuice", minPrice: 0.99, maxPrice: 1.19),
    Product(name: "Potatoes", image: "potato", minPrice: 1.89, maxPrice: 2.00),
    Product(name: "Red Bull", image: "redbull", minPrice: 1.45, maxPrice: 1.49),
    
    Product(name: "Spaghetti", image: "spaghetti", minPrice: 1.48, maxPrice: 1.59),
    Product(name: "Toast", image: "toast", minPrice: 0.89, maxPrice: 0.99),
    Product(name: "Toilet Paper", image: "toilet", minPrice: 2.98, maxPrice: 3.00),
    Product(name: "Tomatoes", image: "tomato", minPrice: 0.59, maxPrice: 1.39),
    Product(name: "Yogurt", image: "yogurt", minPrice: 0.35, maxPrice: 0.59),
]
