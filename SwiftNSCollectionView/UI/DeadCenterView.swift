import SwiftUI

struct DeadCenterView<Content: View>: View {
  @ViewBuilder var content: Content
  var body: some View {
    HStack {
      Spacer()
      VStack {
        Spacer()

        content

        Spacer()
      }
      Spacer()
    }
  }
}

struct DeadCenterView_Previews: PreviewProvider {
  static var previews: some View {
    DeadCenterView {
      Text("Hello World")
        .font(.title)

      Text("How are you?")
        .font(.subheadline)
    }
    .preferredColorScheme(.light)
  }
}
