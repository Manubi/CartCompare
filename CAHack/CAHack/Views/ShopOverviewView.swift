import SwiftUI

struct ShopOverviewView: View {
    
    @EnvironmentObject var cartManager: CartManager
    var stores: [Store]
    
    @State private var totalStoreCosts: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Overview")
                    .font(.title).bold()
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack {
                Text("Total optimized cost: 12.21€")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text("Savings: 4.32€")
                    .padding([.top, .bottom], 6)
                    .padding([.leading, .trailing], 12)
                    .background(.green)
                    .cornerRadius(16)
                
                
                Spacer()
            }
            .padding(.top, 2)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .onAppear {
            totalStoreCosts = stores.reduce(0.0) { total, store in
                let storeCost = cartManager.calculateCost(for: store)
                return total + storeCost
            }
        }
    }
}


struct ShopOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ShopOverviewView(stores: [storeList[1]])
            .environmentObject(CartManager())
    }
}
