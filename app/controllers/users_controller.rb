# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :set_users, except: :create
  before_action :set_user, only: %i(show update destroy)

  def index
    @users = @users.page(params[:page]).per(params[:count])

    render json: authorize(@users), meta: meta_for(@users)
  end

  def show
    render json: authorize(@user)
  end

  def create
    @user = User.new(permitted_attributes(User))
    authorize(@user).save!

    render json: @user, status: :created
  end

  def update
    authorize(@user).update!(permitted_attributes(@user))

    render json: @user
  end

  def destroy
    authorize(@user).destroy!
  end

private

  def set_users
    @users = policy_scope(User)
  end

  def set_user
    @user = @users.find(params[:id])
  end
end
