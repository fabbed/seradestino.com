namespace :sd do

  
    task :delete_answers_without_country_id => :environment do  
      SurveyAnswer.find(:all, :conditions => ['gender = ?', ""]).each do |survey_answer|
        survey_answer.destroy
        puts "DESTROY WITHOUT COUNTRY"
      end
      
      SurveyAnswer.find_by_sql("SELECT id, answer_1 FROM survey_answers where answer_1 IS NULL").each do |survey_answer|
        survey_answer.destroy
        puts "DESTROY WITHOUT ANSWER 1"
      end

      SurveyAnswer.all.each do |survey_answer|
        survey_answer.destroy if (survey_answer.answer_1.length < 3)
      end

      
    end
  
    task :delete_doubles => :environment do  
      SurveyAnswer.find_by_sql("SELECT id, answer_1, answer_2, answer_3, count(*) AS cnt FROM survey_answers GROUP BY answer_1 HAVING cnt > 1").each do |answer|
      puts
      answer_obj=SurveyAnswer.find_by_id(answer.id)
      puts "ID: #{answer_obj.id.to_s}"

      answers_with_same_answers = SurveyAnswer.find(:all, :conditions => ['answer_1 = ? AND answer_2 = ? AND answer_3 = ? AND gender = ? and country_id = ?', answer_obj.answer_1.to_s,  answer_obj.answer_2.to_s, answer_obj.answer_3.to_s, answer_obj.gender, answer_obj.country_id])
      
      puts "# Same stories: #{answers_with_same_answers.size}"
      answers_with_same_answers.each do |same_answer|
        puts "story: " + same_answer.id.to_s
      end

      answers_with_same_answers[1..answers_with_same_answers.size].each do |answer_to_delete|
        puts "To delete: " + answer_to_delete.id.to_s
        answer_to_delete.destroy
      end
    end

    end


    task :all => [:delete_answers_without_country_id, :delete_doubles]      
end
