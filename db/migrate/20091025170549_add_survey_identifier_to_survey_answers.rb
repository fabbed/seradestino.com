class AddSurveyIdentifierToSurveyAnswers < ActiveRecord::Migration
  def self.up
    add_column :survey_answers, :survey_identifier, :string
  end

  def self.down
    remove_column :survey_answers, :survey_identifier
  end
end
