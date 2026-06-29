# Homebrew formula for qwok — builds from source (Go), so there is no
# Gatekeeper / notarization step (the binary is compiled on the user's machine).
# Installs the `qwok` CLI to bin. qwok drives portless at runtime; the caveat
# points users at it.
class Qwok < Formula
  desc "Run your local dev apps by name (pm2-style, over portless)"
  homepage "https://github.com/ekinertac/qwok"
  url "https://github.com/ekinertac/qwok/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b7f5a8c4284c5128adc887c8ca4774934ca354e0a0925aa92e15c7715be5e9f4"
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
