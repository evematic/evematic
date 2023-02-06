module Evematic::Models::Helper
  extend ActiveSupport::Concern

  module ClassMethods
    [
      :access_rule, :account, :identity,
      :esi_alliance, :esi_character, :esi_corporation
    ].each do |name|
      define_method("#{name}_class") do
        Evematic.config.send(:"#{name}_class")
      end

      define_method("#{name}_model") do
        Evematic.config.send(:"#{name}_model")
      end
    end
  end

  [
    :access_rule, :account, :identity,
    :esi_alliance, :esi_character, :esi_corporation
  ].each do |name|
    define_method("#{name}_class") do
      self.class.send(:"#{name}_class")
    end

    define_method("#{name}_model") do
      self.class.send(:"#{name}_model")
    end
  end
end
