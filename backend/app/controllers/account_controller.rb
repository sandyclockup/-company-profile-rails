=begin
 * This file is part of the Sandy Andryanto Company Profile Website.
 *
 * @author     Sandy Andryanto <sandy.andryanto.dev@gmail.com>
 * @copyright  2024
 *
 * For the full copyright and license information,
 * please view the LICENSE.md file that was distributed
 * with this source code.
=end

require 'fileutils'
require 'securerandom'


class AccountController < ApplicationController

    before_action :authorize_request

    def profile_detail
        auth_user = @current_user
        auth_user.password_digest = nil
        response = {
            message: "ok",
            status: true,
            data: auth_user
        }
        render :json => response, :status => :ok
        return
    end

    def profile_update

        user_id = @current_user.id

        if(!params.has_key?(:email))
            payload = {
                message: "The field 'email' can not be empty!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        if(params.has_key?(:phone))
            user_by_phone  = User.find_by("phone = ? AND id != ?", params[:phone], user_id)
            if(user_by_phone != nil)
                payload = {
                    message: "The phone number has already been taken.!",
                    status: false,
                    data: nil
                }
                render :json => payload, :status => :bad_request
                return
            end
        end

        email = params[:email]
        phone = params[:phone]

        user_by_email  = User.find_by("email = ? AND id != ?", params[:email], user_id)

        if(user_by_email != nil)
            payload = {
                message: "The email has already been taken.!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        user = @current_user
        user.email = email
        if(params.has_key?(:phone))
            user.phone = phone
        end
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.gender = params[:gender]
        user.country = params[:country]
        user.address = params[:address]
        user.about_me = params[:about_me]
        user.save()

        response = {
            message: "Yor profile has been changed !!",
            status: true,
            data: user
        }
        render :json => response, :status => :ok
        return

    end

    def profile_upload

        Dir.mkdir(Rails.root.join('storage', 'uploads')) unless Dir.exist?(Rails.root.join('storage', 'uploads'))

        uploaded_io = params[:file]

        file_uuid = SecureRandom.uuid
        file_name = file_uuid.to_s
        # Moving the file to some safe place; as tmp files will be flushed timely
        File.open(Rails.root.join('storage', 'uploads', file_name), 'wb') do |file|
          file.write(uploaded_io.read)
        end

        user = @current_user

        if(user.image)
            file_exist = Rails.root.join('storage', user.image)
            File.delete(file_exist) if File.exist?(file_exist)
        end

        user.image = "uploads/"+file_uuid
        user.save()

        response = {
            message: "Yor file has been uploaded !!",
            status: true,
            data: "uploads/"+file_uuid
        }
        render :json => response, :status => :ok
        return

    end

    def password_update

        user = @current_user

        if(!params.has_key?(:current_password))
            payload = {
                message: "The field 'current_password' can not be empty!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        if(!params.has_key?(:new_password))
            payload = {
                message: "The field 'new_password' can not be empty!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        if(!params.has_key?(:new_password_confirm))
            payload = {
                message: "The field 'new_password_confirm' can not be empty!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        current_password = params[:current_password]
        new_password = params[:new_password]
        new_password_confirm = params[:new_password_confirm]

        auth_user = user.authenticate(current_password)

        if(new_password.length < 8)
            payload = {
              message: "The new password must be at least 8 characters.!",
              status: false,
              data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        if(new_password != new_password_confirm)
            payload = {
              message: "The password confirmation does not match.!",
              status: false,
              data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        if(!auth_user)
            payload = {
                message: "Incorrect current password please try again !!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        user.password = new_password
        user.save()

        response = {
            message: "Your password has been reset!",
            status: true,
            data: nil
        }
        render :json => response, :status => :ok
        return

    end
    

end
