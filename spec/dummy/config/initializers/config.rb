Config.setup do |config|
  config.const_name = "Settings"
  config.use_env = true
  config.env_prefix = "EVEMATIC_DUMMY"
  config.env_separator = "__"
end
