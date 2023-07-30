import SwiftUI

struct ProductCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .top) {
                
                Image(product.image)
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
                    .frame(width: 170, height: 240)
                    .clipped()
                
                
                VStack(alignment: .leading) {
                    Text(product.name)
                        .foregroundColor(.primary)
                        .bold()
                    
                    Text(String(format: "%.2f€ - %.2f€", product.minPrice, product.maxPrice))
                        .foregroundColor(.primary)
                        .font(.caption)
                    
                }
                .padding()
                .frame(width: 170, alignment: .leading)
                .background(.ultraThickMaterial)
                .cornerRadius(20)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 3, x: 0, y: 3)
            }
            
            Button {
                cartManager.addToCart(product: product)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.8))
                    .clipShape(Circle())
                    .padding()
            }
            
        }
        .frame(width: 170, height: 240)
        .cornerRadius(20)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 3, x: 0, y: 3)
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: productList[0])
            .environmentObject(CartManager())
    }
}
