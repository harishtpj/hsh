# List of custom defined errors for shell
module Hsh::Errors
  class Exit < Exception
  end

  class CmdNotFound < Exception
  end
end
