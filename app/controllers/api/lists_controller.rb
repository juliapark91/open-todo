module API

  class ListsController < APIController

    before_action :authenticated?
    before_action :set_user
  
    def create 
      @list = @user.lists.new( list_params )
      
      if @list.save
        render json: { success: "list sucessfully created" }, status: :created
      else
        render json: { failure: "invalid name" }, status: :unprocessable_entity
      end
    end

    def destroy
      begin
        @list = @user.lists.find(params[:id])
        @list.destroy
        render json: {}, status: :no_content
      rescue ActiveRecord::RecordNotFound
        render :json => {}, :status => :not_found
      end
    end

    def update
      @list = @user.lists.find(params[:id])
      if @list.update( list_params )
        render json: @list
      else
        render json: { errors: @list.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
  private 
  
    def list_params
      params.require( :list ).permit( :name, :permissions )
    end

    def set_user
      @user = User.find(params[:user_id])
    end

  end
  
end
