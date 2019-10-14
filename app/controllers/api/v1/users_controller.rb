module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all

        render_jsonapi @users, params: paginate_params, paginate: true
      end
    end
  end
end