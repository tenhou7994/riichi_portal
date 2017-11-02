Rails.application.config.reform.schema = Dry::Validation.Schema do
  configure do
    option :record
    def unique?(attr_name, value)
      record.class.where.not(id: record.id).where(attr_name => value).empty?
    end

    def blank?(attribute)
      self[attribute].blank?
    end
  end
end