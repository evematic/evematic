require "dry-initializer"

class Evematic::Routes::Router
  extend Dry::Initializer

  param :routes
  option :controllers
  option :path_names
  option :scope, default: -> { "/" }
end
