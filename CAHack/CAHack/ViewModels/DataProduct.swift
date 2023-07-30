import Foundation

struct DataProduct: Codable, Identifiable {
    let id: String?
    let name: String?
    let description: String?
    let price: Double?
    let priceHistory: [DataPriceHistory]?
    let unit: String?
    let quantity: Int?
    let calcPricePerUnit: Double?
    let calcUnit: String?
    let category: String?
    let store: String?
}

struct DataPriceHistory: Codable {
    let date: String?
    let price: Double?
}


