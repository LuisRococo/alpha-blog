require "test_helper"

class ArticleCreationTest < ActionDispatch::IntegrationTest
  setup do
    @category_1 = Category.create(name: 'Categoria 1')
    @category_2 = Category.create(name: 'Categoria 2')

    @admin_plain_password = 'root'
    @admin_user = User.create(username: 'root', email:'luis@luis.com', 
                              password: @admin_plain_password, admin: true)                 
    sign_in_as @admin_user, @admin_plain_password
  end

  # 1. get new article page
    # check for status and for something on the page
  # 2. post new article
    # check for database change
  # 3. check for redirect, and search article name on page


  test "Create article successfully" do
    article_name = 'article test'

    # get the new article page
    get new_article_path
    assert_response :success
    assert_select 'h1.text-center', text: 'Create Article'

    # post article and check database difference
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: article_name, description: 'test de articulo', category_ids: [@category_1.id, @category_2.id] }}
    end

    # check for redirect and article title on article show page
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h2.text-center.mt-4', text: article_name
  end
end
