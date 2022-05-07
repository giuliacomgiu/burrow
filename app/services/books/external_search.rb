# frozen_string_literal: true

module Books
  class ExternalSearch
    def initialize(options)
      @query = options[:query].to_s
    end

    def run
      @response = Faraday.get(url)
      parse_response
    end

    private

    ORIGIN = 'https://www.googleapis.com'
    VERSION = 'v1'
    PATH = "books/#{VERSION}/volumes".freeze

    def parse_response
      @parsed_response = JSON.parse(@response.body).except('kind')

      {
        total_items: parse_items.size,
        items: parse_items
      }
    end

    def parse_items
      return [] if @parsed_response['items'].blank?

      @parsed_items ||=
        @parsed_response['items']
        .filter do |book|
          book.dig('volumeInfo', 'title') &&
            book.dig('volumeInfo', 'authors') &&
            book.dig('volumeInfo', 'publisher') &&
            book.dig('volumeInfo', 'publishedDate') &&
            (book.dig('volumeInfo', 'industryIdentifiers').any? { |id| id['type'] == 'ISBN_10' })
        end
        .map do |book|
          {
            title: book['volumeInfo']['title'],
            authors: book['volumeInfo']['authors'],
            publisher: book['volumeInfo']['publisher'],
            published_date: book['volumeInfo']['publishedDate'],
            isbn: book['volumeInfo']['industryIdentifiers']
                  &.filter_map { |id| id['identifier'] if id['type'] == 'ISBN_10' }
                  &.pop
          }
        end
    end

    def url
      "#{ORIGIN}/#{PATH}/?q=#{query}"
    end

    def query
      "#{@query.split(' ').join('+')}&#{authentication_key}"
    end

    def authentication_key
      'key=AIzaSyD_zn1FDbq1UbytVq929LWb4DJQUjhgkVE'
    end
  end
end
