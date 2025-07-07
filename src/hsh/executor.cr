# The Main Executor class for shell
require "shellwords"

require "./builtins/**"
require "./errors"
require "./helpers"

module Hsh::Executor
  def self.run(cmd : String, shell_info : Hash(Symbol, String))
    input = cmd.shellsplit
    exe = input[0]
    args = input[1..]

    case exe
    when "cls"
      print "\x1b[2J\x1b[H"

    when "cd"
      cur_dir = Dir.current
      if args.empty?
        Dir.cd Path.home
      else
        raise Hsh::Errors::InvalidArgs.new(1, args.size) if args.size != 1
        if args[0] == "-"
          Dir.cd shell_info[:prev_pwd]
        else
          Dir.cd Path[args[0]].normalize
        end
      end
      shell_info[:prev_pwd] = cur_dir

    when "pwd"
      puts Hsh::Helpers.pwd

    when "whoami"
      puts Hsh::Helpers::USERNAME

    when "where"
      raise Hsh::Errors::InvalidArgs.new(1, args.size) if args.size != 1
      exe_path = find_executable args[0]
      puts exe_path || "Executable not found: #{args[0]}"

    when "ls"
      Hsh::Builtins::Ls.run args

    when "exit"
      raise Hsh::Errors::Exit.new

    else
      exe_path = find_executable exe
      raise Hsh::Errors::CmdNotFound.new(exe) unless exe_path

      system("#{exe_path} #{args.shelljoin}")
    end
  end

  private def self.find_executable(cmd : String) : (String | Nil)
    path = Path.new cmd

    {% if flag?(:win32) %}
      exe_path = Process.find_executable path
      return exe_path if exe_path

      basename = path.ends_with_separator? ? "" : path.basename
      basename = "" if basename == path.anchor.to_s
      if (basename.empty? ? !path.anchor : !basename.includes?("."))
        extensions = ENV["PATHEXT"].rstrip(';').split(';')
        extensions.each do |ext|
          next if ext.downcase == ".exe"
          new_path = Path.new "#{path}#{ext.downcase}"
          exe_path = Process.find_executable new_path
          return exe_path if exe_path
        end
      end

      return exe_path
    {% else %}
      return Process.find_executable path
    {% end %}
  end
end
