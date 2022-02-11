class BooksController < ApplicationController
  def search
    Books::ExternalSearch.run
  end
end