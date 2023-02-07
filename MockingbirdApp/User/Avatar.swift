import NukeUI
import SwiftUI

struct Avatar: View {
    let url: URL
    let diameter: CGFloat

    var body: some View {
        Group {
            LazyImage(url: url)
                .processors([.resize(size: CGSize(width: diameter, height: diameter)), .circle()])
                .frame(width: diameter, height: diameter)
        }
            .clipShape(Circle())
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(
            url: URL(string: "https://pbs.twimg.com/profile_images/1569656103528448000/d0BzVIPL_x96.jpg")!,
            diameter: CGFloat(48)
        )
    }
}
