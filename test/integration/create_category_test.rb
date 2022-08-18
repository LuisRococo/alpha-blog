require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_plain_password = 'root'
    @admin_user = User.create(username: 'root', email:'luis@luis.com', 
                              password: @admin_plain_password, admin: true)                 
    sign_in_as @admin_user, @admin_plain_password
  end

  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success

    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name: "Fantasy"}}
      assert_response :redirect
    end

    # una vez el redirect sucede, queremos seguirlo
    follow_redirect!
    assert_response :success
    assert_match "Fantasy", response.body
  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success

    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: ""}}
    end

    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
