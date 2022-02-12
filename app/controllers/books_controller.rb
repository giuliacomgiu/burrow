class BooksController < ApplicationController
  def search
    return unless params.except(:controller, :action).present?

    Books::ExternalSearch.new(params.permit(:query)).run
    redirect_to "/books/search/#{params[:query].split(' ').join('+')}"
  end

  def search_result

  end
end