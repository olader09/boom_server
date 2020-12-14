module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      params = request.params
      role = params['role']&.camelize&.constantize || Player
      if verified_user = Knock::AuthToken.new(token: params['token']).entity_for(role)
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def beat
      transmit type: ActionCable::INTERNAL[:message_types][:ping], message: DateTime.current.strftime('%Q')
    end
  end
end
