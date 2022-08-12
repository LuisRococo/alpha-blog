class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def show ()
    end

    def index ()
        @articles = Article.all
    end

    def new ()
        # so the first time the page loads, it does not generate any error
        @article = Article.new()
    end

    def create ()
        @article = Article.new(article_params)
        @article = User.first
        if @article.save
            flash[:notice] = "Article was created successfully"
            # redirect_to article_path(@article)
            redirect_to @article
        else
            render "new"
            # redirect_to new_article_path # no funciona porque al redireccionar se pierden los parametros
        end
    end

    def update ()
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render "edit"
        end
    end
 
    def edit ()
    end

    def destroy ()
        @article.destroy
        redirect_to articles_path, status: :see_other
    end

    # solo usado dentro de este controlador
    private
    
    def set_article 
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end
end