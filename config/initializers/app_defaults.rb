# Default Application Settings

# Give the app a name and a creator, used in the footer view and emails
Rails.application.config.application_name = "Starter Application"
Rails.application.config.application_creator = "Application Author"

# The following two variables seem like they should be the same and they could be
# depending on your deployment server, however can be different if you've deployed
# to Heroku for instance, used in the production environment mail settings
Rails.application.config.application_host = "starter-app-rails5.herokuapp.com"
Rails.application.config.application_domain = "heroku.com"