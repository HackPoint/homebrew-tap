class LumenCli < Formula
  desc "Terminal dashboard for Claude Code — live context fill, cost, and optimizer savings"
  homepage "https://github.com/HackPoint/lumen"
  version "1.3.1"

  on_macos do
    on_arm do
      url "https://github.com/HackPoint/lumen/releases/download/v#{version}/lumen-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "1cd2e0fb86b8c660185146233f3268bf6e0b99284ea31c98acfce39316015dba"
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
      sha256 "07cc8f1c362b452f7a47f60900ffab0653cdf6f455515363b5e883e14362ea14"
    end
  end

  def install
    bin.install "lumen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lumen --version")
  end
end
