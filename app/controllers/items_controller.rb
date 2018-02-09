class ItemsController < ApplicationController
  before_action :set_todo
  
  def create
    item = @todo.items.create!(item_params)
    json_response(item, :created)
  end

  def item_params
    params.permit(:name, :done)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end
end
