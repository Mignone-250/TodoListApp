class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /tasks or /tasks.json
  def index
    if user_signed_in?
      @tasks = current_user.tasks.paginate(page: params[:page], per_page: 10)
    else
    @tasks = Task.paginate(page: params[:page], per_page: 10)
  end
end

def search
    if params[:search].present?
      if user_signed_in?
         @tasks = current_user.tasks.where("title LIKE ?", "%#{params[:search]}%").paginate(page: params[:page], per_page: 10)
      else
        @tasks = Task.where("title LIKE ?", "%#{params[:search]}%").paginate(page: params[:page], per_page: 10)
      end
    else
      @tasks = user_signed_in? ? current_user.tasks.paginate(page: params[:page], per_page: 10) : Task.none.paginate(page: params[:page], per_page: 10)
    end

    render :index
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    #@task = Task.new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path, notice: "Not Authorized To Do This!" if @task.nil?
  end






  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:id, :title, :description, :duedate, :priority, :status, :category, :assigned_to, :created_at, :completed_at, :user_id)
    end
end
