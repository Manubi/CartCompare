import SwiftUI

struct StoreView: View {
    @EnvironmentObject var cartManager: CartManager
    var store: Store
    @State private var cartItems: [Product] = []
    @State private var totalCost: Double = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(store.name)
                    .font(.title).bold()
                .padding(.bottom, 0)
                
                Image(store.imageLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            Text(store.address)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            Text("Items in the Cart:")
                .font(.headline)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                ForEach(cartItems, id: \.id) { item in
                    if let price = store.groceries[item.name] {
                        Text("\(item.name) - \(price, specifier: "%.2f")€")
                    }
                }
            }
            
            Text("Total cost at \(store.name): \(totalCost, specifier: "%.2f")€")
                .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .onAppear {
            cartItems = cartManager.products.filter { product in
                return store.cheapestItems.contains(product.name)
            }
            totalCost = cartItems.reduce(0.0) { total, product in
                total + (store.groceries[product.name] ?? 0.0)
            }
        }
    }
}
