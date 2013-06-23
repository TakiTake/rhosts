module RHosts
  module Rulable
    def rules
      @rules ||= {}
    end

    def rule(pattern, &block)
      rules[pattern] = block
    end
  end
end
