class CreateSurveyAnswers < ActiveRecord::Migration
  def self.up
    create_table :survey_answers do |t|
      t.integer :country_id
      t.string :gender
      t.text :answer_1
      t.text :answer_2
      t.text :answer_3
      t.text :answer_4
      t.text :answer_5
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :survey_answers
  end
end