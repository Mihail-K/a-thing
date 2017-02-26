# frozen_string_literal: true
class PasswordResetsController < ApplicationController
  before_action :set_password_reset, except: :create

  def show
    render json: authorize(@password_reset)
  end

  def create
    @password_reset = PasswordReset.new(permitted_attributes(PasswordReset)) do |password_reset|
      password_reset.ip        = request.ip
      password_reset.remote_ip = request.remote_ip
    end
    authorize(@password_reset).save!

    head :created
  end

  def update
    authorize(@password_reset).update!(permitted_attributes(@password_reset))

    render json: @password_reset
  end

private

  def set_password_reset
    @password_reset = policy_scope(PasswordReset).find(params[:id])
  end
end
