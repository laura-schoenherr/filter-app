class Category < ActiveRecord::Base
  has_and_belongs_to_many :news_items

  def matches?(text)
    self.keywords.split(',').any? do |keyword|
      text.downcase[keyword.downcase]
    end
  end
end
