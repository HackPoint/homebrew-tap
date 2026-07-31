class LumenCli < Formula
  desc "Terminal dashboard for Claude Code — live context fill, cost, and optimizer savings"
  homepage "https://github.com/HackPoint/lumen"
  version "1.5.1"

  on_macos do
    on_arm do
      url "https://github.com/HackPoint/lumen/releases/download/v#{version}/lumen-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "846c15efe53812b27dece30ecd3e3bff95c5da16839dbef92a35807986e33e1d"
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
      sha256 "365a11c9f8c6b190975dfd59623e83afe4e15fd3578ac59bd1bcf98385865188"
    end
  end

  def install
    bin.install "lumen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lumen --version")
  end
end
