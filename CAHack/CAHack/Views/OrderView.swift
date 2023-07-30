import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationView {
            VStack {
                CartRow()
                    .padding([.leading, .trailing], 16)
                    .padding(.top, 16)
                Spacer()
            }
            .navigationTitle("Past Carts")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        cartManager.addToCart(product: productList[3])
        return OrderView()
            .environmentObject(cartManager)
    }
}
