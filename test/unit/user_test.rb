require 'test_helper'

class UserTest < ActiveSupport::TestCase


  def test_create_with_no_names

   u = random_new_user()
   u.first_name = nil
   u.last_name = nil

   assert !u.valid?

   assert_match("Bitte geben Sie", u.errors.messages[:first_name].first)
   
  end
end
