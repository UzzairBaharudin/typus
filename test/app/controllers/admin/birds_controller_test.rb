require "test_helper"

=begin

  What's being tested here?

    - Polymorphic associations.

=end

class Admin::BirdsControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
    @bird = Factory(:bird)
    @image_holder = Factory(:image_holder)
    @request.env['HTTP_REFERER'] = "/admin/birds/edit/#{@bird.id}"
  end

  test "relate polymorphic associations" do
    assert_difference('@bird.image_holders.count') do
      post :relate, :id => @bird.id,
                    :related => { :model => 'ImageHolder',
                                  :id => @image_holder.id,
                                  :association_name => 'image_holders' }
    end

    assert_response :redirect
    assert_redirected_to @request.env['HTTP_REFERER']
    assert_equal "Bird successfully updated.", flash[:notice]
  end

end
