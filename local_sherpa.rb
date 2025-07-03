# typed: false
# frozen_string_literal: true

class LocalSherpa < Formula
  desc "Define folder specific aliases, functions and variables in your shell"
  homepage "https://github.com/SherpaLabsIO/local_sherpa"
  url "https://github.com/sherpalabsio/local_sherpa/releases/download/v0.1.1/local_sherpa_0.1.1.tar.gz"
  sha256 "70d6c83180ba325cf6ec3000be449f9cc239e70e52d60789912c95d1b5a74e21"
  head "https://github.com/SherpaLabsIO/local_sherpa.git", branch: "main"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec / "init" => "local_sherpa_init"
  end

  def post_install
    shell = ENV["SHELL"].split("/").last

    unless %w[zsh bash].include?(shell)
      puts <<~CAVEATS
        Local Sherpa only supports Zsh and Bash. It seems that you are using #{shell}.
      CAVEATS
      return
    end

    ohai "Post install notes"

    puts <<~CAVEATS
      Don't forget to add the following line to your ~/.#{shell}rc file:
      eval "$(local_sherpa_init)"
      or run the following command:
      echo 'eval "$(local_sherpa_init)"' >> ~/.#{shell}rc
    CAVEATS
  end

  test do
    assert_match version.to_s, shell_output("#{ENV["SHELL"]} -c 'eval $(local_sherpa_init) && sherpa -v'")
  end
end
