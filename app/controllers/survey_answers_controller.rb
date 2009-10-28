class SurveyAnswersController < ApplicationController

  before_filter :authenticate, :except => [:create, :new, :show] if !(RAILS_ENV == "development")
  SURVEY_ANSWERS_PER_PAGE = 20
  before_filter :find_survey_answer
  
  protect_from_forgery :except => [:create, :new]

  SURVEY_ANSWERS_PER_PAGE = 20

  layout "survey_answers", :only => [:new, :create]

  def create

    @survey_answer = SurveyAnswer.new(params[:survey_answer])
    @survey_answer.ip = request.env["REMOTE_ADDR"]
    @survey_answer.referrer = request.env["HTTP_REFERER"]

    if @survey_answer.save
      flash[:notice] = 'SurveyAnswer was successfully created.'
      respond_to do |wants|
        wants.js {  render :text => "$('#facebox').html('<h3>Gracias!</h3>')", :layout => false}  
        wants.html { 
          redirect_to @survey_answer
        }
      end
    else
      render :action => "new"
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

    if params[:encuesta] == "1"
      @survey_answers = SurveyAnswer.find(:all, :conditions => ['survey_identifier = ?', "survey_1"], :order => "country_id asc").paginate(:page => params[:page], :per_page => SURVEY_ANSWERS_PER_PAGE)

      @country_survey_answers = SurveyAnswer.find(:all, :conditions => ['survey_identifier = ? and country_id IN (?,?,?)', "survey_1", Country.find_by_name("Colombia").used_id, Country.find_by_name("España").used_id, Country.find_by_name("México").used_id], :order => "country_id asc")

    elsif params[:encuesta] == "2"
      @survey_answers = SurveyAnswer.find(:all, :conditions => ['survey_identifier = ?', "survey_2"], :order => "country_id asc").paginate(:page => params[:page], :per_page => SURVEY_ANSWERS_PER_PAGE)
    else
      params[:encuesta] == "1"
      @survey_answers = SurveyAnswer.find(:all, :conditions => ['survey_identifier = ?', "survey_1"], :order => "country_id asc").paginate(:page => params[:page], :per_page => SURVEY_ANSWERS_PER_PAGE)
    end
    
    respond_to do |format|
      format.html {render :template => "/survey_answers/index", :layout => "admin"}
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

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == "seradestino" && password == "diego"
    end
  end

end