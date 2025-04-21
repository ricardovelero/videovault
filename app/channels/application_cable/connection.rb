module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # Aquí depende de tu sistema de auth. Por ejemplo, si usas Devise con cookies:
      if env["warden"].user.present?
        env["warden"].user
      else
        reject_unauthorized_connection
      end
    end
  end
end
