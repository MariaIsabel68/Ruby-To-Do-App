class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /todo_lists or /todo_lists.json
  def index
    @todo_lists = TodoList.all
  end

  # GET /todo_lists/1 or /todo_lists/1.json
  def show
    @todo_item = TodoItem.new
  end

  # GET /todo_lists/new
  def new
    #@todo_list = TodoList.new
    @todo_list = current_user.todo_lists.build
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists or /todo_lists.json
  def create
    #@todo_list = TodoList.new(todo_list_params)

    @todo_list = current_user.todo_lists.build(todo_list_params)

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to todo_list_url(@todo_list), notice: "Todo list was successfully created." }
        format.json { render :show, status: :created, location: @todo_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_lists/1 or /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to todo_list_url(@todo_list), notice: "Todo list was successfully updated." }
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1 or /todo_lists/1.json
  def destroy
    @todo_list.destroy
   
    respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: "Todo list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @todo_list = current_user.todo_lists.find_by(id: params[:id])
    redirect_to home_path, notice: "Not Authorized" if @todo_list.nil?
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_list_params
      params.require(:todo_list).permit(:title, :user_id)
    end
end
