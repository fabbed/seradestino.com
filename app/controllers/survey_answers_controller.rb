class SurveyAnswersController < ApplicationController

  before_filter :find_survey_answer

  SURVEY_ANSWERS_PER_PAGE = 20

  def create
    puts "Test"
    @survey_answer = SurveyAnswer.new(params[:survey_answer])
    respond_to do |format|
      if @survey_answer.save
        flash[:notice] = 'SurveyAnswer was successfully created.'
        format.html { redirect_to @survey_answer }
        format.xml  { render :xml => @survey_answer, :status => :created, :location => @survey_answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey_answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @survey_answer.destroy
        flash[:notice] = 'SurveyAnswer was successfully destroyed.'        
        format.html { redirect_to survey_answers_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'SurveyAnswer could not be destroyed.'
        format.html { redirect_to @survey_answer }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @survey_answers = SurveyAnswer.paginate(:page => params[:page], :per_page => SURVEY_ANSWERS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @survey_answers }
    end
  end

  def edit
  end

  def new
    @survey_answer = SurveyAnswer.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @survey_answer }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @survey_answer }
    end
  end

  def update
    respond_to do |format|
      if @survey_answer.update_attributes(params[:survey_answer])
        flash[:notice] = 'SurveyAnswer was successfully updated.'
        format.html { redirect_to @survey_answer }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @survey_answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_survey_answer
    @survey_answer = SurveyAnswer.find(params[:id]) if params[:id]
  end

end