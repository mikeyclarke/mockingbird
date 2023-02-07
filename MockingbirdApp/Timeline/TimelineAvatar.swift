import SwiftUI

struct TimelineAvatar: View {
    let url: URL

    var body: some View {
        Avatar(url: url, diameter: LayoutConfiguration.timelineTweetAvatarDiameter)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineAvatar(
            url: URL(string: "https://pbs.twimg.com/profile_images/1569656103528448000/d0BzVIPL_normal.jpg")!
        )
    }
}
