# The REPL interface for HSH shell
require "reply"
require "system/user"

require "./version"
require "./helpers"

class Hsh::REPL < Reply::Reader
  def prompt(io : IO, lno : Int32, colour : Bool) : Nil
    cwd = Dir.current
    prompt = {
      user: Hsh::Helpers.username,
      host: System.hostname,
      cwd: (cwd == Path.home.to_s) ? "~" : cwd
    }
    io << (Hsh::PROMPT % prompt)
  end
end
