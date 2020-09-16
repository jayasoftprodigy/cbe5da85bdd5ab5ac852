class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answers = Answer.where(question_id: params[:id])
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follow_users
    following_user = User.find_by(id: params[:follow_id])
    already_followed = FollowUser.find_by(user_id: following_user.id, follow_id: current_user.id) if following_user.present?
    if following_user.present? && !already_followed.present?
      FollowUser.create(user_id: following_user.id, follow_id: current_user.id)
      redirect_to question_path(id: params[:id]), notice: "Successfully Followed"
    elsif following_user.present? && already_followed.present?
      redirect_to question_path(id: params[:id]), alert: "Already following"
    else
      redirect_to question_path(id: params[:id]), alert: "User not found"
    end

  end

  def follow_topic
    following_topic = Topic.find_by(id: params[:topic_id])
    already_followed = FollowTopic.find_by(user_id: current_user.id, topic_id: following_topic.id) if following_topic.present?
    if following_topic.present? && !already_followed.present?
      FollowTopic.create(user_id: current_user.id, topic_id: following_topic.id)
      redirect_to question_path(id: params[:id]) , notice: "Successfully Followed"
    elsif following_topic.present? && already_followed.present?
      redirect_to question_path(id: params[:id]), alert: "Already following"
    else
      redirect_to question_path(id: params[:id]), alert: "Topic not found"
    end

  def add_answer
  end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:ques, :topic_id)
    end
    def answer_params
      params.require(:answer).permit(:user_id, :solution, :question_id)
    end
end
