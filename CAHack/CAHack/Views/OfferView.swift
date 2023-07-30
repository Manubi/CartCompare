import SwiftUI

struct OfferView: View {
    var offer: Offer
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(offer.image)
                .resizable()
                .scaledToFit()
                .frame(width: 360)
                .cornerRadius(20)
                .padding(.leading, 14)
            
            HStack(spacing: 8) {
                Text(offer.name)
                    .font(.system(size: 24, weight: .bold))
            
                Image(offer.logoImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            .padding(.top, 16)
            .padding(.leading, 16)
            
            
            Text("Expiry: \(offer.expiry)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.leading, 16)
                .padding(.top, 4)

            
            Text(offer.longDescription)
                .font(.system(size: 16))
                .padding(.leading, 16)
                .padding(.top, 4)
            
            Spacer()
            
        }
    }
}

struct OfferView_Previews: PreviewProvider {
    static var previews: some View {
        OfferView(offer: offerList[1])
    }
}
