# -*- coding: utf-8 -*-

require 'date'


class BookInfo
	def initialize ( title, author, page, publish_date )
		@title = title
		@author = author
		@page = page
		@publish_date = publish_date
	end

	attr_accessor :title, :author, :page, :publish_date

	def to_s
		"#{@title}, #{@author}, #{@page}, #{@publish_date}"
	end

	def toFormattedString ( sep = "\n" )
		"著書名：#{@title}#{sep} 著者：#{@author}#{sep} ページ数：#{@page}#{sep} 出版日：#{publish_date}#{sep}"
	end
end


class BookInfoManager
	def initialize
		@book_infos = {}
	end

	def addBookInfo
		book_info = BookInfo.new( "", "", 0, Date.new )
		print "key:"
		key = gets.chomp
		print "title:"
		book_info.title = gets.chomp
		print "author:"
		book_info.author = gets.chomp
		print "page:"
		book_info.page = gets.chomp.to_i
		print "year"
		year = gets.chomp.to_i
		print "month"
		month = gets.chomp.to_i
		print "day"
		day = gets.chomp.to_i
		book_info.publish_date = Date.new( year, month, day )

		@book_infos[key] = book_info
	end

	def listAllbookInfos
		puts "\n-------------------------------"
		@book_infos.each { |key, info|
			print info.toFormattedString
		puts "\n-------------------------------"
		}
	end

	def run
		while true
			print "1.regist 2.print 9.exit  :  "
			num = gets.chomp

			case 
			when '1' == num
				addBookInfo
			 when '2' == num
				listAllbookInfos
			 when '9' == num
				break;
			 else
			end
		end
	end
end

book_info_manager = BookInfoManager.new

book_info_manager.run

