class LumenCli < Formula
  desc "Terminal dashboard for Claude Code — live context fill, cost, and optimizer savings"
  homepage "https://github.com/HackPoint/lumen"
  version "1.1.2"

  on_macos do
    on_arm do
      url "https://github.com/HackPoint/lumen/releases/download/v#{version}/lumen-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9c9aff4814e6a32cbb4b2f559b69dc28cac779e791eb0db170cffb23a99168cd"
    end
  end

  # The release pipeline has always built an x86_64 Linux CLI; it just was not
  # offered here, so `brew install` on Linux failed with no bottle. The daemon and
  # CLI are pure cross-platform Rust (SQLite is compiled from source via rusqlite
  # `bundled`), so the same binary needs no system libraries.
  #
  # arm64 Linux is absent on purpose: the pipeline builds no such artifact yet, and
  # pointing at a URL that 404s is worse than declining to offer it.
  on_linux do
    on_intel do
      url "https://github.com/HackPoint/lumen/releases/download/v#{version}/lumen-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "54623adf350fda8c7228206dd1bcfba24a4f307bc73f8dd84703b6f98a24ef5c"
    end
  end

  def install
    bin.install "lumen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lumen --version")
  end
end
