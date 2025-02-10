# typed: false
# frozen_string_literal: true

class LocalSherpa < Formula
  desc "???"
  homepage "https://github.com/nomadsherpa/local_sherpa"
  url "https://github.com/nomadsherpa/local_sherpa/releases/download/test/Archive.zip"
  sha256 "d37c7dc325cda6cd28617a9924c842bd0a4bd41d0ab585995a255860e8279b1d"
  version "1.0.0-beta.1"

  def install
    #   bin.install "#{buildpath}/bin/skhd"
  end

  def caveats
    "caveats??"
  end

  # test do
  # TODO
  # assert_equal "1.0.0-beta.1", shell_output("#{bin}/sherpa -v").strip
  # end
end
