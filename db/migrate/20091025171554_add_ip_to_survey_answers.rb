class AddIpToSurveyAnswers < ActiveRecord::Migration
  def self.up
    add_column :survey_answers, :ip, :string
  end

  def self.down
    remove_column :survey_answers, :ip
  end
end
