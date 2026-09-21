# Homebrew formula for hue — single-file Python script, zero external
# dependencies (stdlib only). Installs `hue` to bin directly.
class Hue < Formula
  desc "Control Philips Hue lights from the command line"
  homepage "https://github.com/ekinertac/philips-hue-cli"
  url "https://github.com/ekinertac/philips-hue-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "60a198f96063a8ead4cbd0a6502fb8756c892e4a0d4221a6a1e2a4006c794ff1"
  license "MIT"

  depends_on "python@3.13"

  def install
    bin.install "hue"
  end

  test do
    assert_match "hue 0.1", shell_output("#{bin}/hue --version")
    assert_match "Usage", shell_output("#{bin}/hue --help")
  end
end