import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var showVisitedOnly = false
    @State private var visitedIDs: Set<UUID> = []

    var filteredCrafts: [Craft] {
        var result = crafts

        if !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.englishName.localizedCaseInsensitiveContains(searchText)
            }
        }

        if showVisitedOnly {
            result = result.filter { visitedIDs.contains($0.id) }
        }

        return result
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Warm parchment background
                Color.bhutanCream.ignoresSafeArea()

                List {
                    // MARK: - Enhancement C: Endless-knot style accent
                    Section {
                        VStack(spacing: 6) {
                            Image(systemName: "infinity")
                                .font(.title2)
                                .foregroundStyle(Color.bhutanGold)

                            Text("Thirteen Traditional Arts of Bhutan")
                                .font(.system(.caption, design: .serif))   // Enhancement D
                                .foregroundStyle(Color.bhutanMaroon.opacity(0.8))
                                .italic()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .listRowBackground(Color.clear)
                    }

                    // MARK: - Visited toggle
                    Section {
                        Toggle(isOn: $showVisitedOnly) {
                            Label("Show visited only", systemImage: "checkmark.seal")
                                .font(.system(.subheadline, design: .serif))  // Enhancement D
                                .foregroundStyle(Color.bhutanMaroon)
                        }
                        .tint(.bhutanSaffron)
                        .listRowBackground(Color.bhutanCream)
                    }

                    // MARK: - Crafts
                    Section {
                        ForEach(Array(filteredCrafts.enumerated()), id: \.element.id) { index, craft in
                            NavigationLink(
                                destination: CraftDetailView(
                                    craft: craft,
                                    visitedIDs: $visitedIDs
                                )
                            ) {
                                HStack(spacing: 12) {
                                    // Thumbnail with gold frame
                                    Image(craft.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 55, height: 55)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.bhutanGold, lineWidth: 1.5)
                                        )

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(craft.name)
                                            .font(.system(.headline, design: .serif))  // D
                                            .foregroundStyle(Color.bhutanDeep)
                                        Text(craft.englishName)
                                            .font(.system(.subheadline, design: .serif)) // D
                                            .foregroundStyle(Color.bhutanMaroon.opacity(0.7))
                                    }

                                    Spacer()

                                    Image(systemName: visitedIDs.contains(craft.id)
                                          ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(visitedIDs.contains(craft.id)
                                                         ? Color.bhutanSaffron : Color.gray)
                                        .font(.title3)
                                }
                                .padding(.vertical, 4)
                            }
                            // Enhancement B: alternate row colours
                            .listRowBackground(
                                index.isMultiple(of: 2)
                                    ? Color.bhutanCream
                                    : Color.bhutanGold.opacity(0.10)
                            )
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.bhutanCream)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: - Enhancement A: two-line logo + title
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.bhutanGold, lineWidth: 1.2)
                            )

                        VStack(alignment: .leading, spacing: 0) {
                            Text("Zorig Chusum ✦")
                                .font(.system(.headline, design: .serif))     // D
                                .foregroundStyle(Color.bhutanMaroon)
                            Text("Thirteen Traditional Arts")
                                .font(.system(.caption2, design: .serif))     // D
                                .foregroundStyle(Color.bhutanGold)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search crafts")
            .tint(.bhutanSaffron)
        }
    }
}

#Preview {
    ContentView()
}
