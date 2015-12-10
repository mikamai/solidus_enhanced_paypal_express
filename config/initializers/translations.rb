RouteTranslator.config do |config|
  config.force_locale = true
  config.locale_param_key = :locale
  config.generate_unnamed_unlocalized_routes = true
end
SolidusI18n::Config.available_locales = [:it, :de, :en] # displayed on frontend select box
SolidusGlobalize::Config.supported_locales = [:it, :de, :en] # displayed on translation forms
