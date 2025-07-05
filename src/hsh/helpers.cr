# Module for Helper functions
module Hsh::Helpers
  BUILTINS = ["cd", "cls", "pwd", "exit", "whoami"]

  {%if flag?(:win32) %}
    USERNAME = ENV["USERNAME"]
  {% else %}
    USERNAME = `whoami`.strip
  {% end %}

  HOST = System.hostname

  def self.pwd
    Path[Dir.current].to_posix
  end

  def self.full_username
    "#{USERNAME}@#{HOST}"
  end
end
