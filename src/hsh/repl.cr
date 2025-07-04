# The REPL interface for HSH shell
require "reply"

require "./version"

class Hsh::REPL < Reply::Reader
  def prompt(io : IO, lno : Int32, colour : Bool) : Nil
    io << Hsh::PROMPT
  end
end
