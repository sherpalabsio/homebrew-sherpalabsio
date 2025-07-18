# typed: false
# frozen_string_literal: true

class LocalSherpa < Formula
  desc "Define folder specific aliases, functions and variables in your shell"
  homepage "https://github.com/SherpaLabsIO/local_sherpa"
  url "https://github.com/sherpalabsio/local_sherpa/releases/download/v0.2.1/local_sherpa_0.2.1.tar.gz"
  sha256 "eb0d6a3d3db81bf5e1962c7e0c3041c3e3ff7b619600454b3093167ffc5f9a1e"
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
