class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def hobby
    @hobby = Hobby.new
  end

  def hobbycreate
    print("Params = #{params}")
    @hobby = Hobby.new(name: params["name"])
    respond_to do |format|
      if @hobby.save
        format.html { redirect_to new_user_url, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: new_user_url }
      else
        format.html { render :hobby, status: :unprocessable_entity }
        format.json { render json: @hobby.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params.except("hobbies"))
    respond_to do |format|
      if @user.save
        addhobbytouser(user_params[:hobbies], @user)
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params.except("hobbies"))
        addhobbytouser(user_params[:hobbies], @user)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :birthdate, hobbies: [])
    end

    def addhobbytouser(hobbies, user)
      user.hobbies = []
      hobbies.reject(&:blank?).each { |id|
          @hobby = Hobby.find(id)
          user.hobbies << @hobby
        }
    end
end
