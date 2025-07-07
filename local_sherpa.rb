# typed: false
# frozen_string_literal: true

class LocalSherpa < Formula
  desc "Define folder specific aliases, functions and variables in your shell"
  homepage "https://github.com/SherpaLabsIO/local_sherpa"
  url "https://github.com/sherpalabsio/local_sherpa/releases/download/v0.2.0/local_sherpa_0.2.0.tar.gz"
  sha256 "a829e388af508ca6adfa0e512c50bca5a80aea7a6c52efcd6880ad27e2bc0679"
  head "https://github.com/SherpaLabsIO/local_sherpa.git", branch: "main"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec / "init" => "local_sherpa_init"
  end

  def post_install
    ohai "Post install notes"

    shell = ENV["SHELL"].split("/").last
    rc_file = File.join(Dir.home, ".#{shell}rc")

    line = 'eval "$(local_sherpa_init)"'

    return if File.readlines(rc_file).any? { |l| l.include?(line) }

    File.open(rc_file, "a") { |f| f.puts line }

    puts <<~CAVEATS
      Added the following line to your ~/.#{shell}rc file:
        #{line}
      Don't forget to restart your shell.
    CAVEATS
  end

  test do
    assert_match version.to_s, shell_output("#{ENV["SHELL"]} -c 'eval $(local_sherpa_init) && sherpa -v'")
  end
end
