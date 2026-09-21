# Homebrew formula for hue — single-file Python script, zero external
# dependencies (stdlib only). Installs `hue` to bin directly.
class Hue < Formula
  desc "Control Philips Hue lights from the command line"
  homepage "https://github.com/ekinertac/philips-hue-cli"
  url "https://github.com/ekinertac/philips-hue-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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