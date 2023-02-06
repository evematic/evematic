Rack::MiniProfiler.config.enable_hotwire_turbo_drive_support = true
Rack::MiniProfiler.config.assets_url = ->(name, version, env) {
  ActionController::Base.helpers.asset_path(name)
}

Rack::MiniProfiler.config.position = "bottom-right"
