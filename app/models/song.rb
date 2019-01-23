# class ReleasedYearValidation  < ActiveModel::Validator
#   def validate(record)
#     if(fields[:released])
#       return true
#     else
#       if(fields[:release_year].empty?)
#         record.errors[:release_year] << "'Release Year' Cannot Be Empty if 'release' is false"
#       end
#     end
#   end
# end
#
# class TitleValidation < ActiveModel::Validator
#   def validate(record)
#   end
# end
require 'time'

class ReleaseYearValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    #binding.pry
    if (record.released)
      if(value.nil?)
        record.errors.add(:release_year,"Error")
      end
      if(value.to_i>Time.now.year.to_i)
        record.errors.add(:release_year,"Error")
      end
    else
      if(!value.nil?)
        record.errors.add(:release_year,"Error")
      end
    end
 end
end

class TitleValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    # search for song with same title
    # if the new record
    # binding.pry
    song_with_same_title=Song.find_by({title:value})
    if !song_with_same_title.nil?
      if record.release_year==record.release_year
        record.errors.add(:title,"The same song cannot be released twice in the same year")
      end
    end
  end
end


class Song < ActiveRecord::Base
  validates :title,presence:true,title:true
  validates :release_year,release_year:true
end
