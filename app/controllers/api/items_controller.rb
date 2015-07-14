module API

  class ItemsController < APIController
    
    before_action :authenticated?
  
    def create 
      @list = List.find(params[:list_id])
      @item = @list.items.new( item_params )
      
      if @item.save
        render json: { success: "item sucessfully created" }, status: :created
      else
        render json: { failure: "invalid item name" }, status: :unprocessable_entity
      end
    end

    def update
      @list = List.find(params[:list_id])
      @item = @list.items.find(params[:id])
      if @item.update( item_params )
        render json: { success: "Item update completed" }, status: :updated
      else
        render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
  private 
  
    def item_params
      params.require( :item ).permit( :name )
    end

  end
  
end
