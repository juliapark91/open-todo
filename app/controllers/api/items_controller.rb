module API

  class ItemsController < APIController
    
    before_action :authenticated?
    before_action :set_list
    
    def index
      @items = @list.items
      render json: @items
    end

    def create 
      @item = @list.items.new( item_params )
      
      if @item.save
        render json: { success: "item sucessfully created" }, status: :created
      else
        render json: { failure: "invalid item name" }, status: :unprocessable_entity
      end
    end

    def update
      @item = @list.items.find(params[:id])
      if @item.update( item_params )
        render json: { success: "Item update completed" }, status: :updated
      else
        render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      begin
        @item = @list.items.find(params[:id])
        @item.destroy
        render json: { success: "item deleted successfully" }, status: :deleted
      rescue ActiveRecord::RecordNotFound
        render :json => { failure: "item failed to delete or does not exist"}, :status => :not_found
      end
    end
    
  private 
  
    def item_params
      params.require( :item ).permit( :name )
    end

    def set_list
      @list = List.find(params[:list_id])
    end

  end
  
end
