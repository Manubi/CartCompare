import SwiftUI
import SwiftUICharts

struct SegmentGraphView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedSupermarket = 0
    @State private var dataProduct: DataProduct?
    @State private var priceHistory: [Double] = []
    
    let supermarkets = ["Billa", "Hofer", "Spar"]
    let productIds = [
            "Apples": [
                "Billa": "00-804413",
                "Hofer": "545173",
                "Spar": "6737634"
            ],
            "Bananas": [
                "Billa": "00-258074",
                "Hofer": "545162",
                "Spar": "6942526"
            ],
            "Beef": [
                "Billa": "00-317050",
                "Hofer": "546468",
                "Spar": "2020002281397"
            ],
            "Butter": [
                "Billa": "00-827690",
                "Hofer": "546430",
                "Spar": "3215098"
            ],
            "Croissants": [
                "Billa": "00-440691",
                "Hofer": "546069",
                "Spar": "7615153"
            ],
            "Milk": [
                "Billa": "00-432809",
                "Hofer": "546088",
                "Spar": "5048854"
            ],
            "Oil": [
                "Billa": "00-258074",
                "Hofer": "545932",
                "Spar": "2020002496678"
            ],
            "Juice": [
                "Billa": "00-861713",
                "Hofer": "548597",
                "Spar": "7354236"
            ],
            "Potatoes": [
                "Billa": "00-258074",
                "Hofer": "545162",
                "Spar": "6942526"
            ],
            "Red Bull": [
                "Billa": "00-12494",
                "Hofer": "548526",
                "Spar": "151238"
            ],
            "Spaghetti": [
                "Billa": "00-379560",
                "Hofer": "546368",
                "Spar": "7365270"
            ],
            "Toast": [
                "Billa": "00-425504",
                "Hofer": "544863",
                "Spar": "7088087"
            ],
            "Toilet Paper": [
                "Billa": "00-431244",
                "Hofer": "546139",
                "Spar": "8185433"
            ],
            "Tomatoes": [
                "Billa": "00-374991",
                "Hofer": "546133",
                "Spar": "2103617"
            ],
            "Yogurt": [
                "Billa": "00-668140",
                "Hofer": "546469",
                "Spar": "2729497"
            ],
        ]
    var product: Product
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Picker(selection: $selectedSupermarket, label: Text("Supermarket")) {
                        ForEach(0..<supermarkets.count) {
                            Text(self.supermarkets[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedSupermarket) { _ in
                        load()
                    }
                                        
                    if priceHistory.count > 3 {
                        LineView(data: self.priceHistory, title: "Price for \(product.name) (€)", legend: "Price changes between 07/2022 and 07/2023")
                            .frame(height: 380)
                            .padding([.leading, .trailing], 16)
                        
                        if let firstPrice = self.priceHistory.first, let lastPrice = self.priceHistory.last {
                            let priceIncrease = lastPrice - firstPrice
                            Text("In the last year, the price has increased by \(String(format: "%.2f€", priceIncrease))")
                                .padding(.top, 10)
                                .padding([.leading, .trailing], 12)
                        } else {
                            Text("Unable to calculate price increase.")
                        }
                        
                    } else {
                        Text("Not enough data to generate a chart")
                            .foregroundColor(.red)
                            .padding([.leading, .trailing], 16)
                    }
                    
                    Spacer() // This will push the content above
                }
                .navigationTitle(product.name)
                .onAppear(perform: load)
            }
  
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .frame(width: 25, height: 25)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
    
    func load() {
        if let url = Bundle.main.url(forResource: "finalData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([DataProduct].self, from: data)
                
                // Get the product id for the selected supermarket
                guard let productDictionary = productIds[product.name] else {
                    print("Could not find ids for product: \(product.name)")
                    return
                }
                
                let selectedProductId = productDictionary[supermarkets[selectedSupermarket]] ?? ""
                
                // Here we find the product with the matching id and use that for the chart data
                self.dataProduct = jsonData.first(where: { $0.id == selectedProductId })
                
                if let priceHistory = self.dataProduct?.priceHistory {
                    self.priceHistory = priceHistory.compactMap { $0.price }.reversed()
                    print(self.priceHistory)
                }
                
            } catch {
                print("Error loading data: \(error)")
            }
        } else {
            print("Could not find file")
        }
    }
    
    struct SegmentGraphView_Previews: PreviewProvider {
        static var previews: some View {
            SegmentGraphView(product: productList[1])
        }
    }
}
