# List of custom defined errors for shell
module Hsh::Errors
  class Exit < Exception
  end

  class CmdNotFound < Exception
  end

  class InvalidArgs < Exception
    def initialize(expected : Int32, received : Int32)
      super("expected #{expected}, received #{received}")
    end
  end
end
