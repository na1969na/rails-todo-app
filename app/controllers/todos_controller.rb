class TodosController < ApplicationController
  # GET /todos
  def index
    @todos = Todo.all
  end

  # POST /todos
  def create
    @todo = Todo.new(create_todo_params)
    if @todo.save
      redirect_to root_path
    else
      # HTTP status code 422: Unprocessable Entity
      render 'index', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/:id
  def update
    @todo = Todo.find(params[:id])

    if @todo.update(update_todo_params)
      redirect_to root_path
    else
      # HTTP status code 422: Unprocessable Entity
      render 'index', status: :unprocessable_entity
    end
  end

  # DELETE /todos/:id
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    # HTTP status code 303: See Other
    redirect_to root_path, status: :see_other
  end

  private
  def create_todo_params
    params.require(:todo).permit(:task)
  end

  def update_todo_params
    params.require(:todo).permit(:task, :completed)
  end

end
