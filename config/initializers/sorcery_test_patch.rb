if Rails.env.test?
  module Sorcery
    module Controller
      module InstanceMethods
        def require_login
          true
        end

        def current_user
          User.first || FactoryBot.create(:user)
        end

        def logged_in?
          true
        end
      end
    end
  end
end
