# Homebrew cask for infiniterm: terminal cards on an infinite canvas, with
# each coding agent's state on its card's border.
#
# The DMG on ekinertac/infiniterm's releases is signed with a Developer ID and
# notarized, so unlike walter.rb there is no quarantine workaround. The app
# updates itself (checks every six hours, installs on restart), hence
# auto_updates: `brew upgrade` leaves it alone and this file only has to be
# current for fresh installs. Release tags are v<version> and the DMG names
# the build, so the version is "<version>,<build>" and the csv parts rebuild the URL.
#
# `ift`, the command line side, ships inside the bundle and is linked onto
# the PATH here; `ift install` does the same by hand for DMG installs.
cask "infiniterm" do
  version "0.5.2,560"
  sha256 "e054de0e99f70a7231be6a0bdabe3370ef13a111e5e68f2b978593fdeb5b085c"

  url "https://github.com/ekinertac/infiniterm/releases/download/v#{version.csv.first}/infiniterm-#{version.csv.first}-#{version.csv.second}-arm64.dmg"
  name "infiniterm"
  desc "Terminal cards on an infinite canvas with each coding agent's state visible"
  homepage "https://infiniterm.app/"

  livecheck do
    url "https://github.com/ekinertac/infiniterm/releases/latest/download/latest.json"
    strategy :json do |json|
      "#{json["version"]},#{json["build"]}"
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "infiniterm.app"
  binary "#{appdir}/infiniterm.app/Contents/MacOS/ift"

  zap trash: [
    "~/.config/infiniterm",
    "~/Library/Application Support/dev.ekinertac.infiniterm",
    "~/Library/Caches/dev.ekinertac.infiniterm",
    "~/Library/Preferences/dev.ekinertac.infiniterm.plist",
    "~/Library/Saved Application State/dev.ekinertac.infiniterm.savedState",
  ]
end
