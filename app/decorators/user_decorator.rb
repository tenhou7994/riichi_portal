class UserDecorator < BaseDecorator
  delegate_all

  def display_name
    if source.first_name.present? || source.last_name.present?
      [source.first_name, source.last_name].join(' ')
    else
      h.t('shared.common.noname')
    end
  end
end