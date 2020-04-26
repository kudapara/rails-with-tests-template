class Contact < ApplicationRecord
  validates_presence_of :firstname, :lastname, :email
  validates_uniqueness_of :email
  
  def self.by_letter(letter)
    where("lastname like ?", "#{letter}%").order(:lastname)
  end

  def fullname
    [firstname, lastname].join(' ')
  end
end
