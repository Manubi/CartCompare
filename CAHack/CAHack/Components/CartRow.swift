import SwiftUI

struct CartRow: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        HStack(spacing: 20) {
            CartButton(numberOfProducts: cartManager.products.count)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Your cart from the 30.7")
                    .bold()
                
                Text("12.21€")
                    .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
                .padding(10)
                .background(.gray.opacity(0.3))
                .clipShape(Circle())
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 1)

    }
}

struct CartRow_Previews: PreviewProvider {
    static var previews: some View {
        CartRow()
            .environmentObject(CartManager())
    }
}

