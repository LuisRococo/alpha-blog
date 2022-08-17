require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create({name: "Sports"})
    @category2 = Category.create({name: "Horror"})
  end

  test "Should how categories listening" do
    get '/categories'

    # seeks a link that matches that path
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
