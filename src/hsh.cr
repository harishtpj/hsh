# The entrypoint for hsh shell
require "./hsh/version"
require "./hsh/errors"
require "./hsh/executor"
require "./hsh/repl"

module Hsh
  def self.run
    print_banner
    reader = REPL.new

    loop do
      # Process.on_terminate { |r| p! r; next } # for debug
      Process.on_terminate { next }
      begin
        usr_cmd = reader.read_next
        next if !usr_cmd || usr_cmd.strip.empty?

        Executor.run usr_cmd

      rescue Errors::Exit
        puts "Quitting Shell, goodbye..."
        break

      rescue e : Errors::CmdNotFound
        error "Command not found: #{e}"

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
