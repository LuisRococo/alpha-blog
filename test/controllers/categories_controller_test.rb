require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Fantasy")
    @admin_plain_password = 'root'
    @admin_user = User.create(username: 'root', email:'luis@luis.com', 
                              password: @admin_plain_password, admin: true)                 
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as @admin_user, @admin_plain_password
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in_as @admin_user, @admin_plain_password
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Terror" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not admin" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "Terror" } }
    end

    assert_redirected_to categories_url
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end
end
