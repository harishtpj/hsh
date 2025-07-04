# The entrypoint for hsh shell
require "shellwords"

require "./hsh/errors"
require "./hsh/executor"
require "./hsh/repl"

module Hsh
  # Metainfo
  VERSION = "0.1.0"
  AUTHOR = "Harish Kumar"

  def self.run
    print_banner
    reader = REPL.new

    loop do
      begin
        usr_cmd = reader.read_next
        next if !usr_cmd || usr_cmd.strip.empty?

        input = usr_cmd.shellsplit
        cmd = input[0]
        args = input[1..]

        Executor.run cmd, args

      rescue Errors::Exit
        puts "Quitting Shell, goodbye..."
        break

      rescue Errors::CmdNotFound
        error "Command not found: #{cmd}"

      rescue e : IO::Error
        error "#{e}"

      rescue error
        error "Unexpected Error: #{error}"
      end
    end
  end

  private def self.print_banner
    puts "Welcome to hsh v#{VERSION} - Written by #{AUTHOR}"
    puts "For more info, type 'help'"
    puts
  end

  private def self.error(msg : String)
    STDERR.puts msg
  end
end

Hsh.run
