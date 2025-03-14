# frozen_string_literal: true
# typed: false

class LocalSherpa < Formula
  desc "Sherpa loads and unloads functions, aliases, and variables on a per-directory basis in your shell."
  homepage "https://github.com/SherpaLabsIO/local_sherpa"
  url "https://github.com/sherpalabsio/local_sherpa/releases/download/v0.1.1/local_sherpa_0.1.1.tar.gz"
  sha256 "66c21c7862de4329f711d2c7632ed52a7f41e662f267a81c8fb8819f0773bf86"
  version "0.1.1"

  depends_on "bash"

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
      eval \"$(local_sherpa_init)\"
      or run the following command:
      echo 'eval \"$(local_sherpa_init)\"' >> ~/.#{shell}rc
    CAVEATS
  end

  test do
    assert_match version.to_s, shell_output("#{ENV['SHELL']} -c 'eval $(local_sherpa_init) && sherpa -v'")
  end
end
