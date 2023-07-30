import SwiftUI

struct LocationMapAnnotationView: View {
    
    var store: Store

    var body: some View {
        VStack(spacing: 0) {
            Image(store.imageLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(6)
                .background(.indigo)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.indigo)
                .frame(width: 8, height: 8)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -2)
                .padding(.bottom, 40)
        }
    }
}


struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView(store: storeList[0])
    }
}
