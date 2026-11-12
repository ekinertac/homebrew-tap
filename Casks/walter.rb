# Homebrew cask for Walter — a native macOS keyboard-first launcher.
#
# Walter ships a signed (Developer ID) DMG on each GitHub release. The app is
# code-signed but not currently notarized, so the postflight strips the
# quarantine attribute Homebrew applies on download; without it Gatekeeper
# would block the first launch. Distributed as a cask (prebuilt .app) rather
# than a build-from-source formula because a signed release DMG already exists.
cask "walter" do
  version "1.8.0"
  sha256 "f75dc49b31a7668b919e4e97b343cf4c5d9f23a17535e426357a33169612cde8"

  url "https://github.com/ekinertac/walter/releases/download/v#{version}/Walter-#{version}.dmg"
  name "Walter"
  desc "Native keyboard-first launcher configured with a TOML file"
  homepage "https://github.com/ekinertac/walter"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Walter.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Walter.app"]
  end

  zap trash: [
    "~/.config/walter",
    "~/Library/Preferences/com.ekinertac.walter.plist",
    "~/Library/Saved Application State/com.ekinertac.walter.savedState",
  ]
end
