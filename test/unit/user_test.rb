require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def test_create_with_no_names

   u = User.new()
   pp u.save!
  end
end
