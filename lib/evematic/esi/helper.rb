require "evematic/esi/client"

module Evematic::ESI::Helper
  extend ActiveSupport::Concern

  module ClassMethods
    def esi_delete(*args, **kwargs)
      esi_client.delete(*args, **kwargs)
    end

    def esi_get(*args, **kwargs)
      esi_client.get(*args, **kwargs)
    end

    def esi_post(*args, **kwargs)
      esi_client.post(*args, **kwargs)
    end

    def esi_put(*args, **kwargs)
      esi_client.put(*args, **kwargs)
    end

    def esi_client
      @esi_client ||= Evematic::ESI::Client.new
    end
  end

  def esi_delete(*args, **kwargs)
    self.class.esi_delete(*args, **kwargs)
  end

  def esi_get(*args, **kwargs)
    self.class.esi_get(*args, **kwargs)
  end

  def esi_post(*args, **kwargs)
    self.class.esi_post(*args, **kwargs)
  end

  def esi_put(*args, **kwargs)
    self.class.esi_put(*args, **kwargs)
  end
end
