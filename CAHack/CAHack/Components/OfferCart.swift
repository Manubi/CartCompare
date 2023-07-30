import SwiftUI

struct OfferCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    var offer: Offer
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                Image(offer.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 150)
                HStack(spacing: 16) {
                    Image(offer.logoImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .padding(.leading, 3)
                                        
                    Text(offer.description)
                        .font(.system(size: 16))
                        .lineLimit(nil)
                    
                }
                .padding(10)
                .frame(width: 220, alignment: .leading)
                .background(.ultraThickMaterial)
                .cornerRadius(20)

            }
            .frame(width: 220, height: 150)
            .cornerRadius(20)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 3, x: 0, y: 3)
            
            NavigationLink(destination: OfferView(offer: offer)) {
                Image(systemName: "chevron.right")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black.opacity(1))
                    .clipShape(Circle())
                    .padding()
            }
                    
        }
    }
}

struct OfferCard_Previews: PreviewProvider {
    static var previews: some View {
        OfferCard(offer: offerList[0])
    }
}
