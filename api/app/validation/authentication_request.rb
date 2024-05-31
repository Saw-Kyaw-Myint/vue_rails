module Validation
  module AuthenticationRequest
    def initialize
      request=params
      binding.pry
    end
    def call(params)
      put "call method"
      binding.pry
    end
  end
end
