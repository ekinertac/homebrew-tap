# Homebrew formula for qwok — builds from source (Go), so there is no
# Gatekeeper / notarization step (the binary is compiled on the user's machine).
# Installs the `qwok` CLI to bin. qwok drives portless at runtime; the caveat
# points users at it.
class Qwok < Formula
  desc "Run your local dev apps by name (pm2-style, over portless)"
  homepage "https://github.com/ekinertac/qwok"
  url "https://github.com/ekinertac/qwok/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "dfeb58301b4a87e9ee3ae92f158ba7cf4083ee39a1688a7389cb859162c3aab0"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/qwok"
  end

  def caveats
    <<~EOS
      qwok wraps portless for named .localhost URLs. Install it once:
        npm install -g portless     # or: brew install portless

      Start the proxy, then register and run an app:
        sudo portless proxy start
        cd ~/Code/myapp
        qwok add myapp --cmd "npm run dev"
        qwok run myapp
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/qwok --help")
  end
end
