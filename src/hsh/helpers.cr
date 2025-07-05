# Module for Helper functions
module Hsh::Helpers
  def self.username
    {%if flag?(:win32) %}
      ENV["USERNAME"]
    {% else %}
      `whoami`
    {% end %}
  end
end
