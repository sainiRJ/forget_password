class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :login, :deletAll, :delete_user, :resetMail, :forget_password]
     helper_method :current_user, :logged_in?


     require_relative "../../lib/json_web_token"
     
    def index

    end 
      
    def create
      @user = User.new
    end
   
    def new
      @user=User.new(user_params)
      if @user.save
        render json: {message: "User registered successfully", status: :ok}
    else
        render json: { errors: @user.errors.full_messages, status: :unprocessable_entity }
      end
    end
   
   
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email, :first_name, :last_name)
    end
   
   
    def login
      def login_form
        
      end
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        payload = { user_id: user.id }
        token = ::JsonWebToken.encode(payload)  
        render json: {id: user.id, token: token}, status: :ok
      else
        render json: {error: "Invalid Username or Password"},status: :bad_request
      end
    end
   
   
   
   
    def get_user
    
        @current_user ||= User.find_by(id: session[:user_id])    
      if @current_user.nil?
        render json: {error: "Unauthorized", message: "you are not logged in"},status: :bad_request   
        else
          if session[:user_id]== params[:id].to_i
            @user = User.find_by(id: params[:id].to_i)
             
            else
                render json: {error: "Unauthorized", message: "you are not authorized user"},status: :bad_request
          end
      end 
    end
   
   
    def delete_user
      @current_user ||= User.find_by(id: session[:user_id])  
   
   
      if @current_user.nil?
        render json: {error: "Unauthorized", message: "you are not logged in"},status: :bad_request
   
   
        else
          if session[:user_id]== params[:id].to_i
            user = User.find_by(id: params[:id].to_i).destroy
           
            # redirect_to "/user/login"
   
   
            else
                render json: {error: "Unauthorized", message: "you canot delete other user details"},status: :bad_request
          end
      end 
    end
   
   
    def allUser
      page_number = params[:page] || 1
      @users = User.paginate(page: page_number, per_page: 10)
    end 

    def reset_mail
      def resetMail_form
        
      end
      email = params[:email]
      user = User.find_by(email: email)
      if !user
        render json:{error: "unknown", message: "user does not exist in database"}

        else
          payload = { email: email }
          token = ::JsonWebToken.encode(payload)  
      # MyMailer.send_email('rajeshpushpakar01@gmail.com', 'reset Password', token).deliver_now
      UserMailer.send_plain_text_email(email,"password Reset", " http://localhost:3000/user/forget/#{token}").deliver_now
          render json: {message: "Reset Password link send to given Email-id"}
      end
    end

    def update_password   
    def forget_password
    end
      verify = ::JsonWebToken.decode(params[:token])
        email = verify['email']
      user  = User.find_by(email: email)
     if user.update(password_params)
        render json: {message: "password update succesfully"}

     else 
      render json: { errors: user.errors.full_messages, status: :unprocessable_entity }
      end
    end
    private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
