require "dry-initializer"
require "faraday"
require "faraday/detailed_logger"
require "faraday/http_cache"
require "faraday/retry"
require "faraday/typhoeus"

class Evematic::ESI::Client
  extend Dry::Initializer

  option :base_url, default: -> { Evematic.config.esi_base_url }
  option :cache, default: -> { Rails.cache }
  option :detailed_logging, default: -> { Evematic.config.esi_detailed_logging }
  option :logger, default: -> { Rails.logger }
  option :instrumenter, default: -> { ActiveSupport::Notifications }
  option :user_agent, default: -> { Evematic.config.esi_user_agent }

  def delete(path, body: nil, params: {}, token: nil)
    json_encoded.delete(path) do |req|
      req.body = body
      req.params = params
      req.headers = default_headers
      req.headers = headers(token)
    end
  end

  def get(path, params: {}, token: nil)
    url_encoded.get(path) do |req|
      req.params = params
      req.headers = headers(token)
    end
  end

  def post(path, body: nil, params: {}, token: nil)
    json_encoded.post(path) do |req|
      req.body = body
      req.params = params
      req.headers = headers(token)
    end
  end

  def put(path, body: nil, params: {}, token: nil)
    json_encoded.put(path) do |req|
      req.body = body
      req.params = params
      req.headers = headers(token)
    end
  end

  private

  def headers(token)
    h = default_headers
    h[:authorization] = authorization_header(token) if token
    h
  end

  def default_headers
    {user_agent: user_agent.strip}
  end

  def authorization_header(token)
    "Authorization: Bearer #{token}"
  end

  def url_encoded
    @url_encoded ||= Faraday.new(url: base_url) do |conn|
      conn.use(:http_cache, store: cache, logger:, instrumenter:)
      conn.request :url_encoded
      conn.request :retry, retry_options
      conn.response :detailed_logger, logger if detailed_logging
      conn.adapter :typhoeus
    end
  end

  def json_encoded
    @json_encoded ||= Faraday.new(url: base_url) do |conn|
      conn.use(:http_cache, store: cache, logger:, instrumenter:)
      conn.request :json
      conn.request :retry, retry_options
      conn.response :detailed_logger, logger if detailed_logging
      conn.adapter :typhoeus
    end
  end

  def retry_options
    @retry_options ||= Evematic.config.esi_retry_options.to_h.merge(retry_statuses: [503, 504])
  end
end
