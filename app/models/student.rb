class Student < ApplicationRecord

    has_and_belongs_to_many :courses

    after_creates :print_message



private 
    def print_message
    puts "student create"
     end
end