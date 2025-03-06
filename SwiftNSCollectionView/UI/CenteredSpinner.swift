import SwiftUI

struct CenteredSpinner: View {
  var body: some View {
    ProgressView()
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
  }
}

// MARK: - CenteredSpinner_Previews

struct CenteredSpinner_Previews: PreviewProvider {
  static var previews: some View {
    CenteredSpinner()
  }
}
