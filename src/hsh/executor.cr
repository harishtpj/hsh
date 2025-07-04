# The Main Executor class for shell
require "shellwords"

require "./errors"

module Hsh::Executor
  def self.run(cmd : String)
    input = cmd.shellsplit
    exe = input[0]
    args = input[1..]

    case exe
    when "exit"
      raise Hsh::Errors::Exit.new

    else
      exe_path = find_executable cmd
      raise Hsh::Errors::CmdNotFound.new(exe) unless exe_path

      system("#{exe_path} #{args.join ' '}")
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
