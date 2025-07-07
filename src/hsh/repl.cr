# The REPL interface for HSH shell
require "reply"
require "colorize"

require "./version"
require "./helpers"

class Hsh::REPL < Reply::Reader
  def initialize : Nil
    super
    word_delimiters.clear
    word_delimiters << '/' << ' '
  end

  def prompt(io : IO, lno : Int32, color : Bool) : Nil
    cwd = Hsh::Helpers.pwd
    home_dir = Path.home.to_posix

    if cwd == home_dir
      cwd = "~"
    elsif cwd.to_s.starts_with?(home_dir.to_s)
      cwd = cwd.to_s.sub(home_dir.to_s, "~")
    else
      cwd = cwd.to_s
    end
    prompt = {
      whoami: Hsh::Helpers.full_username.colorize.green.toggle(color),
      cwd: cwd.colorize.blue.toggle(color)
    }
    io << (Hsh::PROMPT % prompt)
  end

  def highlight(expr : String) : String
    expr = expr.gsub /(?:^|[|;&]\s*|&&\s*|\|\|\s*)(\w[\w.-]*)/ do |match|
        if Hsh::Helpers::BUILTINS.includes? $1
          match.sub $1, $1.colorize.yellow.to_s
        else
          match
        end
    end

    expr.gsub /"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'/ do |match|
      match.colorize.blue.to_s
    end
  end

  def auto_complete(name_filter : String, expr : String) : {String, Array(String)}
    args = expr.empty? ? [] of String : expr.split[1..]
    search_path = args.empty? ? "." : args[-1]

    suggestions = Dir.entries(Path[search_path]).select(&.starts_with?(name_filter))
    suggestions = suggestions.map { |e| File.directory?(e) ? "#{e}/" : e }
    {"Paths", suggestions}
  end

  def history_file
    Path.home / ".hsh_history"
  end
end
