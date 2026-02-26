import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ZStack(alignment: .leading) {
            Color.sidebarBg.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                // ── Profile header ──
                HStack(alignment: .center, spacing: 12) {
                    // Avatar with crown
                    ZStack(alignment: .topTrailing) {
                        Circle()
                            .fill(Color.white.opacity(0.14))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            )
                        // Crown badge
                        ZStack {
                            Circle()
                                .fill(Color.badgeOrange)
                                .frame(width: 20, height: 20)
                            Image(systemName: "crown.fill")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                        }
                        .offset(x: 5, y: -3)
                    }

                    Text("Idan Moshe")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)

                    Spacer()

                    Image(systemName: "bell")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.6))

                    Image(systemName: "gearshape")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.leading, 2)
                        .onTapGesture {
                            state.selectedTab = 2
                            withAnimation { state.sidebarOpen = false }
                        }
                }
                .padding(.horizontal, Spacing.sidebarHorizontal)
                .padding(.top, 66)
                .padding(.bottom, 26)

                // ── Folder list ──
                ForEach(state.folders) { folder in
                    SidebarRowView(
                        folder: folder,
                        isSelected: state.selectedFolder.id == folder.id
                    )
                    .onTapGesture {
                        state.selectedFolder = folder
                        state.selectedTab = 0
                        withAnimation { state.sidebarOpen = false }
                    }
                }

                Spacer()

                // ── Bottom add / settings row ──
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.square")
                        Text("Add".localized)
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.4))

                    Spacer()

                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.4))
                }
                .padding(.horizontal, Spacing.sidebarHorizontal)
                .padding(.bottom, 42)
            }
        }
    }
}
