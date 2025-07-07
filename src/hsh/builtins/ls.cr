require "phreak"

require "../version"

module Hsh::Builtins::Ls
  def self.run(args : Array(String)) : Nil
    Phreak.parse(args) do |root|
      root.default do
        puts Dir.entries "."
      end

      root.bind(short_flag: 'h', long_flag: "help", description: "Prints a help menu") do
        puts root
      end
    end
  end
end
