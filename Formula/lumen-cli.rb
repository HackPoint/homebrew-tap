class LumenCli < Formula
  desc "Terminal dashboard for Claude Code — live context fill, cost, and optimizer savings"
  homepage "https://github.com/HackPoint/lumen"
  version "1.2.3"

  on_macos do
    on_arm do
      url "https://github.com/HackPoint/lumen/releases/download/v#{version}/lumen-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "2a2d50ca69459b490bac1bdec2fd6717bcb38aeb5503376a950a96d52e426169"
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
      sha256 "75ef74df13bb9bb25a13653f19893df76bea3cdd58c5c37f5e540b7ce5a5b7be"
    end
  end

  def install
    bin.install "lumen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lumen --version")
  end
end
