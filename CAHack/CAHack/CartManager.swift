import Foundation

class CartManager: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var minTotal: Double = 0
    @Published var maxTotal: Double = 0
    
    var totalOptimizedCost: Double = 0.0
    var savings: Double {
        return maxTotal - totalOptimizedCost
    }
    
    func addToCart(product: Product) {
        products.append(product)
        minTotal += product.minPrice
        maxTotal += product.maxPrice
    }
    
    func removeFromCart(product: Product) {
        products = products.filter { $0.id != product.id }
        minTotal -= product.minPrice
        maxTotal -= product.maxPrice
    }
    
    func cheaperItems(for store: Store) -> [Product] {
        return products.filter { product in
            return store.groceries[product.name] ?? 0 <= product.minPrice
        }
    }

    func calculateCost(for store: Store) -> Double {
        let storeCost = products.filter { product in
            return store.cheapestItems.contains(product.name)
        }.reduce(0.0) { total, product in
            total + (store.groceries[product.name] ?? 0.0)
        }
        return storeCost
    }
    
    func updateTotalOptimizedCost(with cost: Double) {
        totalOptimizedCost += cost
    }
}
