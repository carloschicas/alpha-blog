require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: 'carloschicas', email: 'carloschicas@yahoo.com',
                              password: 'password', admin: true)
    @category = Category.create(name: 'Travel')
  end

  test 'get a new article for and create an article' do
    sign_in_as(@admin_user)
    get new_article_path
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: {
        title: 'Nuevo articulo de prueba',
        description: 'akjsdfgkjdshfkajshdfkajshdfkjashdfkajsdhgk',
        category_ids: [@category.id]
      } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Nuevo articulo de prueba', response.body
    assert_match @category.name, response.body
  end
end
