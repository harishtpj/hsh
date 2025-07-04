# The Main Executor class for shell
require "./errors"

module Hsh::Executor
  def self.run(cmd : String, args : Array(String) | Nil)

    case cmd
    when "exit"
      raise Hsh::Errors::Exit.new

    else
      unless Process.find_executable cmd
        raise Hsh::Errors::CmdNotFound.new
      end

      system cmd, args
    end
  end
end
