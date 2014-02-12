require 'test_helper'
require 'authlogic/test_case'

class UsersControllerTest < ActionController::TestCase


  def setup
    activate_authlogic
    user_login
    request.env['HTTP_REFERER'] = "topics/"
  end


  def test_delete_user_no_admin

    @users = User.all

    user_with_comment = nil
    @users.each do |u|
      user_with_comment = u unless u.comments.nil?
    end
    assert user_with_comment
    comment = user_with_comment.comments.first
    comment_count = Comment.all.size

    delete :destroy, {:id => user_with_comment, 'HTTP_REFERER' => "topics/"}

    assert_equal(Comment.all.size, comment_count)
    assert(Comment.find(comment.id))
  end
  def test_delete_user
    admin_login

    @users = User.all

    user_with_comment = nil
    @users.each do |u|
      user_with_comment = u unless u.comments.nil?
    end
    assert user_with_comment
    comment = user_with_comment.comments.first
    comment_count = Comment.all.size

    delete :destroy, {:id => user_with_comment, 'HTTP_REFERER' => "topics/"}

    assert_equal(Comment.all.size, comment_count-1)
  end
end
