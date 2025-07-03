class ShellExitException < Exception
end

module Hsh
  VERSION = "0.1.0"

  def self.execute(cmd : String)
    cmd = cmd.split
    exe = cmd[0]
    args = cmd[1..]

    case exe
    when "cd"
      puts "Yet to implement"

    when "exit"
      raise ShellExitException.new

    else
      sts = Process.run(exe, args: args, output:STDOUT, error:STDERR)
    end
  end

  def self.run
    loop do
      print "hsh> "
      usr_cmd = gets(chomp: true)

      unless usr_cmd
        STDERR.puts "Error reading user input: EOFError"
        next
      end

      begin
        execute usr_cmd
      rescue ShellExitException
        break
      rescue e : IO::Error
        STDERR.puts "Command not found: #{e}"
      rescue error
        STDERR.puts "Unexpected Error: #{error}"
      end
    end
  end
end

Hsh.run
