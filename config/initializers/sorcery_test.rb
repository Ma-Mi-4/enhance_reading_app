if Rails.env.test?
  module Sorcery
    module Controller
      module Submodules
        module RequireLogin
          def require_login; end
          def not_authenticated; end
        end
      end
    end
  end
end
