class SurveyAnswer < ActiveRecord::Base

  validates_presence_of   :country_id, :on => :create, :message => "En que Pais vives?"
  validates_presence_of   :gender, :on => :create, :message => "Pon tu sexo"  
  validates_presence_of   :answer_1, :on => :create, :message => "Pon al menos un símbolo."    
  
end
