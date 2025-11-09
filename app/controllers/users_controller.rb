class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to set_level_user_path(@user, new_registration: true), notice: "ユーザー登録が完了しました。レベルを設定してください"
    else
      puts "🧩 Validation errors: #{@user.errors.full_messages}"
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
