import SwiftUI
//import CoreData

struct ContentView: View {
    
    @StateObject var cartManager = CartManager()
    @FocusState private var isTextFieldFocused: Bool
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State private var isShowingGraph = false
    @State private var selectedProduct: Product?
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return productList
        } else {
            return productList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var columns = [GridItem(.adaptive(minimum: 120), spacing: 10)]
    
    var body: some View {
        NavigationView {
            VStack {
                if !searchIsActive {
                    topBar
                        .opacity(searchIsActive ? 0 : 1)
                        .animation(.easeInOut)
                        .padding(.top, 0)
                }
                
                SearchBar(text: $searchText)
                    .padding(.horizontal, 10)
                    .offset(y: searchIsActive ? 0 : 0)
                    .animation(.easeInOut, value: searchIsActive)
                    .onTapGesture {
                        withAnimation {
                            self.searchIsActive.toggle()
                        }
                    }
                
                VStack {
                    ScrollView {
                                                
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(filters, id: \.id) { filter in
                                    FilterTag(filter: filter)
                                        .environmentObject(cartManager)
                                }
                                .padding(.trailing, 0)
                            }
                            .padding([.leading, .trailing], 16)
                            .padding(.bottom , 0)
                            .padding(.top, 8)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(filtersOffers, id: \.id) { filter in
                                    FilterTag(filter: filter)
                                        .environmentObject(cartManager)
                                }
                                .padding(.trailing, 0)
                            }
                            .padding([.leading, .trailing], 16)
                            .padding(.bottom , 4)
                            .padding(.top, 0)
                        }
                        
                        
                        HStack {
                            Text("Offers for you")
                                .font(.title2).bold()
                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(offerList, id: \.id) { offer in
                                    OfferCard(offer: offer)
                                        .environmentObject(cartManager)
                                }
                                .padding(.trailing, 4)
                            }
                            .padding([.leading, .trailing], 16)
                            .padding(.bottom , 7)
                            .padding(.top, 0)
                        }
                        
                        HStack {
                            Text("Popular Groceries")
                                .font(.title2).bold()
                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.top, 10)
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(productList, id: \.id) { product in
                                Button(action: {
                                    self.selectedProduct = product
                                    self.isShowingGraph = true
                                }) {
                                    ProductCard(product: product)
                                        .environmentObject(cartManager)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 16)
                        .sheet(isPresented: $isShowingGraph) {
                            SegmentGraphView(product: selectedProduct ?? productList[0])
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager())
    }
}

extension ContentView {
    
    private var topBar: some View {
        
        ZStack (alignment: .topLeading){
            HStack {
                VStack (alignment: .leading, spacing: 0) {
                    Text("Shop Now")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(UIColor.lightGray))
                    
                    HStack(spacing: 10) {
                        Text("Gonzagagasse 16, 1010 Wien")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Button {
                            print("Location")
                        } label: {
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
        .padding(.top, 24)
    }
}

struct SearchBar: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            TextField("Find your groceries", text: $text)
                .focused($isFocused)
                .padding(7)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .onTapGesture {
                    isFocused = true
                }
        }
        .padding([.leading, .trailing], 5)
    }
}
