require 'will_paginate/array'

module Upsc

  class Book
  	DOWNLOAD_PATH = "http://upsc.herokuapp.com"
  	ROOT_PATH = "#{Rails.root}/public/"
  	def self.get_books(params)
  	  category = params[:category].downcase rescue ""
  	  book_path = ROOT_PATH + "#{category}"
  	  book_categories = Dir.glob("#{book_path}/*").delete_if{|category| category.include?("assets") }.delete_if{|book| book.include?("pdf") }
  	  books = Dir.glob("#{book_path}/*.pdf")
  	  books = books.collect{|book| book.gsub("#{book_path}", "#{DOWNLOAD_PATH}/#{category}") }.delete_if{|book| book.include?("assets") }
  	  [book_categories, books]
  	end

  end

end