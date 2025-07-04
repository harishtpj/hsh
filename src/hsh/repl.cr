# The REPL interface for HSH shell
require "reply"

class Hsh::REPL < Reply::Reader
  def prompt(io : IO, lno : Int32, colour : Bool) : Nil
    io << "hsh>> "
  end
end
