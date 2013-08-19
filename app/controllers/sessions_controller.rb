#https://github.com/plataformatec/devise/wiki/How-To:-Upgrade-to-Devise-2.2
#http://stackoverflow.com/questions/14319868/ember-js-with-devise-on-rails-application-406-not-acceptable-on-sign-up
class SessionsController < Devise::RegistrationsController
    respond_to :json
end
