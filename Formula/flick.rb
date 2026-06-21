# Homebrew formula for flick — builds from source so there is no Gatekeeper /
# notarization step (the binaries are compiled on the user's machine).
# Installs the `flick` CLI to bin and the menu bar app into the prefix; the
# caveat explains how to move the app to /Applications for login-item use.
class Flick < Formula
  desc "Menu bar app and CLI to toggle services via global hotkeys"
  homepage "https://github.com/ekinertac/flick"
  url "https://github.com/ekinertac/flick/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "92a2754f829d3b9d6c4dde4706d31a5116d7a0976371cb085a55d8a9f9007892"
  license "MIT"

  depends_on :macos

  def install
    system "make", "build"
    bin.install ".build/flick"
    prefix.install ".build/Flick.app"
  end

  def caveats
    <<~EOS
      The menu bar app was installed to:
        #{opt_prefix}/Flick.app

      To run it (and enable it as a login item), copy it to /Applications:
        cp -r #{opt_prefix}/Flick.app /Applications/

      Then add it under System Settings > General > Login Items.

      Services are configured in ~/.config/flick.json, created on first run.
    EOS
  end

  test do
    # With no arguments, flick creates a default config and lists services,
    # exiting 0. HOME is sandboxed to a temp dir during `brew test`.
    system bin/"flick"
  end
end
