module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)
    flash.now[:error] = [sentence] + resource.errors.full_messages
    ""
  end
end
