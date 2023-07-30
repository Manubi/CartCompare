import SwiftUI

struct Filter: Identifiable {
    var id = UUID()
    var name: String
}

let filters: [Filter] = [
    Filter(name: "Fruit"),
    Filter(name: "Vegetable"),
    Filter(name: "Meat"),
    Filter(name: "Protein-rich"),
    Filter(name: "Vegan Alternatives")
]

let filtersOffers: [Filter] = [
    Filter(name: "No recent change"),
    Filter(name: "Amazing deal"),
    Filter(name: "Current offer")
]

let shopFilters: [Filter] = [
    Filter(name: "Cheapest"),
    Filter(name: "Closest"),
    Filter(name: "CO2 Friendliest"),
    Filter(name: "Time efficient"),
    Filter(name: "Feeling lucky")
]

struct FilterTag: View {
    
    @EnvironmentObject var cartManager: CartManager
    @State private var isSelected: Bool = false
    
    var filter: Filter
    
    var body: some View {
        Text(filter.name)
            .font(.headline)
            .padding([.leading, .trailing], 12)
            .padding([.top, .bottom], 6)
            .background(isSelected ? Color.accentColor.opacity(0.3) : Color.accentColor.opacity(0.1))
            .cornerRadius(16)
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

struct FilterTag_Previews: PreviewProvider {
    static var previews: some View {
        FilterTag(filter: filters[0])
    }
}
