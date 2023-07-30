import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager
    @State private var shouldShowOptimizedView = false
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            if cartManager.products.count > 0 {
                ForEach(cartManager.products, id: \.id) { product in
                    ProductRow(product: product)
                }
                
                HStack {
                    Text("Your cart total is")
                    Spacer()
                    
                    Text(String(format: "%.2f€ - %.2f€", cartManager.minTotal, cartManager.maxTotal))
                        .font(.system(size: 18))
                    
                }
                .padding()
                
                NavigationLink(destination: OptimizedView(selectedTab: $selectedTab).environmentObject(cartManager), isActive: $shouldShowOptimizedView) {
                    EmptyView()
                }
                
                proceedButton
                
                
            } else {
                Text("Your cart is empty")

            }
            
        }
        .navigationTitle("My Cart")
        .padding(.top)
        .onAppear {
            let productNames = cartManager.products.map { $0.name }
            print("Names of items in the cart: \(productNames)")
        }

    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

extension CartView {
    
    private var proceedButton: some View {
        Button {
            shouldShowOptimizedView = true
        } label: {
            Text("Let's optimise your shop")
                .font(.headline)
                .frame(height: 35)
                .padding([.leading, .trailing], 16)
        }
        .buttonStyle(.borderedProminent)
    }
}
