Rails.application.config.reform.schema = Dry::Validation.Schema do
  configure do
    message_compiler.messages.config.paths << Rails.root + 'config/locales/errors/base.yml'

    option :record
    def unique?(attr_name, value)
      record.class.where.not(id: record.try(:id)).where(attr_name => value).empty?
    end

    def blank?(attribute)
      self[attribute].blank?
    end
  end
end

