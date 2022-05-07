# frozen_string_literal: true

class BooksController < ApplicationController
  def search; end

  def search_result
    books = Books::ExternalSearch.new(params.permit(:query)).run
    render json: books
  end
end
