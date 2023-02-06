module Evematic::Models::Mixins::ESI::Entity
  extend ActiveSupport::Concern

  included do
    include Evematic::ESI::Helper

    before_validation :assign_attributes_from_esi

    define_model_callbacks :esi_sync
  end

  def assign_attributes_from_esi
    return if fresh?

    res = fetch_esi_attributes

    attributes = parse_json(res.body).merge(
      esi_etag: res.headers["etag"].delete('"'),
      esi_expires_at: DateTime.parse(res.headers["expires"]),
      esi_last_modified_at: DateTime.parse(res.headers["last-modified"]).change(usec: 0)
    )
    transform_esi_attributes(attributes) if respond_to?(:transform_esi_attributes)
    assign_attributes(attributes)
  end

  def fresh?
    return false unless persisted?

    return false if esi_expires_at.blank?

    esi_expires_at >= Time.zone.now
  end

  def sync
    run_callbacks :esi_sync do
      assign_attributes_from_esi
      changed? ? save : true
    end
  end

  def sync!
    run_callbacks :esi_sync do
      assign_attributes_from_esi
      changed? ? save! : true
    end
  end

  private

  def parse_json(str)
    return Oj.load(str) if defined?(Oj)

    JSON.parse(str)
  end
end
