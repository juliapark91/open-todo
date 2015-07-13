module API

  class ListsController < APIController
    
    before_action :authenticated?
  
    def create 
      @list = List.new( list_params )
      
      if @list.save
        render json: { success: "list sucessfully created" }, status: :created
      else
        render json: { failure: "invalid name" }, status: :unprocessable_entity
      end
    end
    
  private 
  
    def list_params
      params.require( :list ).permit( :name )
    end

  end
  
end
