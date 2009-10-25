class AddReferrerToDb < ActiveRecord::Migration
  def self.up
    add_column :survey_answers, :referrer, :string
  end

  def self.down
    remove_column :survey_answers, :referrer
  end
end
