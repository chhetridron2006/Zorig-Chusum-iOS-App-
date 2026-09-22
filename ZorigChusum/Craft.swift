import Foundation

struct Craft: Identifiable {
    let id = UUID()
    let name: String          // Dzongkha term
    let englishName: String   // English meaning
    let imageName: String     // Name of the image asset
    let description: String   // Short explanation
}
