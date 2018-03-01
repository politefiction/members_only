require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid emails should be accepted" do
    addresses = %w[user@example.com example.user@example.org user@test.example.com cave+caroline@aperture.net gordon-freeman@blackmesa.org GLaDOS_testing@aperture.sci]
    addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "invalid emails should be rejected" do
    addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should not be valid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = ""
    @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "password should be long enough" do
    @user.password = "a" * 5
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password and password confirmation should match" do
    @user.password = "a" * 6
    @user.password_confirmation = "a" * 7
    assert_not @user.valid?
    @user.password_confirmation = "a" * 6
    assert @user.valid?
  end

end
