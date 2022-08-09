class ArticlesController < ApplicationController
    def show ()
        @article = Article.find(params[:id])
    end

    def index ()
        @articles = Article.all
    end

    def new ()
        # so the first time the page loads, it does not generate any error
        @article = Article.new()
    end

    def create ()
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
            flash[:notice] = "Article was created successfully"
            # redirect_to article_path(@article)
            redirect_to @article
        else
            render "new"
            # redirect_to new_article_path # no funciona porque al redireccionar se pierden los parametros
        end
    end
end