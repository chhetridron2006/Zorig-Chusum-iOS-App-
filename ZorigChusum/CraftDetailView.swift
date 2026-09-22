import SwiftUI

struct CraftDetailView: View {
    let craft: Craft
    @Binding var visitedIDs: Set<UUID>

    private var isVisited: Bool {
        visitedIDs.contains(craft.id)
    }

    var body: some View {
        ZStack {
            Color.bhutanCream.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // MARK: - Hero image (gold frame)
                    Image(craft.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.bhutanGold, lineWidth: 3)
                        )
                        .shadow(color: .bhutanMaroon.opacity(0.25),
                                radius: 8, x: 0, y: 4)
                        .padding(.top, 10)

                    // MARK: - Dzongkha name (serif, large)
                    Text(craft.name)
                        .font(.system(.largeTitle, design: .serif))   // D
                        .fontWeight(.bold)
                        .foregroundStyle(Color.bhutanMaroon)

                    // MARK: - English name
                    Text(craft.englishName)
                        .font(.system(.title3, design: .serif))       // D
                        .foregroundStyle(Color.bhutanGold)

                    // MARK: - Decorative diamond divider
                    HStack(spacing: 8) {
                        Rectangle()
                            .fill(Color.bhutanGold.opacity(0.6))
                            .frame(height: 1)
                        Image(systemName: "diamond.fill")
                            .font(.caption2)
                            .foregroundStyle(Color.bhutanSaffron)
                        Rectangle()
                            .fill(Color.bhutanGold.opacity(0.6))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 40)

                    // MARK: - Description
                    Text(craft.description)
                        .font(.system(.body, design: .serif))         // D
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.bhutanDeep)
                        .padding(.horizontal)

                    // MARK: - Visited toggle
                    Toggle(isOn: Binding(
                        get: { isVisited },
                        set: { newValue in
                            if newValue { visitedIDs.insert(craft.id) }
                            else        { visitedIDs.remove(craft.id) }
                        }
                    )) {
                        Label("Visited", systemImage: "checkmark.seal.fill")
                            .font(.system(.headline, design: .serif)) // D
                            .foregroundStyle(Color.bhutanMaroon)
                    }
                    .tint(.bhutanSaffron)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)

                    // MARK: - Mark-visited button
                    Button {
                        if isVisited { visitedIDs.remove(craft.id) }
                        else         { visitedIDs.insert(craft.id) }
                    } label: {
                        Text(isVisited ? "Mark as Not Visited" : "Mark as Visited")
                            .font(.system(.headline, design: .serif)) // D
                            .foregroundStyle(Color.bhutanCream)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isVisited ? Color.gray : Color.bhutanMaroon)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.bhutanGold, lineWidth: 1.2)
                            )
                    }
                    .padding(.horizontal, 40)

                    Spacer(minLength: 20)
                }
                .padding(.vertical)
            }
        }
        .navigationTitle(craft.name)
        .navigationBarTitleDisplayMode(.inline)
        .tint(.bhutanSaffron)
    }
}

#Preview {
    NavigationStack {
        CraftDetailView(
            craft: Craft(
                name: "Thagzo",
                englishName: "Weaving",
                imageName: "Thagzo",
                description: "Thagzo is Bhutan's renowned textile art."
            ),
            visitedIDs: .constant([])
        )
    }
}
