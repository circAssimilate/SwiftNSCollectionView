import SwiftUI

struct CollectionItemView: View {
    var title: String
    
    var body: some View {
        DeadCenterView {
            Text(title)
                .font(.caption)
        }
        .background(Color.yellow)
        .cornerRadius(8)
        .shadow(radius: 5)
        .frame(width: 80, height: 60)
        .padding(2)
    }
}
