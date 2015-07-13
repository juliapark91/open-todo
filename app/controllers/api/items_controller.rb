module API

  class ItemsController < APIController
    
    before_action :authenticated?
  
    def create 
      @item = Item.new( item_params )
      
      if @item.save
        render json: { success: "item sucessfully created" }, status: :created
      else
        render json: { failure: "invalid item name" }, status: :unprocessable_entity
      end
    end
    
  private 
  
    def item_params
      params.require( :item ).permit( :name )
    end

  end
  
end
