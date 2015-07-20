# -*- coding: utf-8 -*-

require 'rubygems'
require 'dbi'
require 'date'

class BookInfo
	def initialize (title, author, page, publish_date)
		@title = title
		@author = author
		@page = page
		@publish_date = publish_date
	end

	attr_accessor :title, :author, :page, :publish_date

	def to_s
		"#{@title}, #{@author}, #{@page}, #{@publish_date}"
	end

	def toFormattedString(sep="\n")
		"著書名：#{@title}#{sep} 著者名：#{@author}#{sep} ページ数：#{@page}#{sec} 出版日：#{@publish_date}#{sep}"
	end
end

class BookInfoManager
	def initialize ( sqlite_name)
		@db_name = sqlite_name
		@dbh = DBI.connect("DBI:SQLite3:#{@db_name}")
	end

	def initBookInfo
		puts "\n0.データベースの初期化"
		print "初期化しますか？　Y/yで実行します。："
		yesno = gets.chomp.upcase

		if /^Y$/ =~ yesno
			@dbh.do("drop table if exists bookinfos")
			@dbh.do("create table bookinfos (id varchar(50),title varchar(100),author varchar(100),page int,publish_date datetime,primary key(id));")
			puts "\nデータベースを初期化しました。"
		end
	end

	def addBookInfo
		puts "¥\n蔵書データの登録"
		print "蔵書データを登録します。"

		book_info = BookInfo.new( "", "", 0, Date.new)
		print "キー：　"
		key = gets.chomp
		print "書籍名：　"
		book_info.title	= gets.chomp
		print "著者名：　"
		book_info.author = gets.chomp		
		print "ページ数；　"
		book_info.page = gets.chomp.to_i
		print "発刊年：　"
		year = gets.chomp.to_i
		print "発行月：　"
		month = gets.chomp.to_i
		print "発行日：　"
		day = gets.chomp.to_i
		book_info.publish_date = Date.new( year, month, day )

		@dbh.do("insert into bookinfos values(¥'#{key}¥',¥ß'#{book_info.title}¥',¥'#{book_info.author}¥',#{book_info.page},¥'#{book_info.publish_date}¥');")
	end




	def listBookInfo

		item_name = {'id' => 'キー', 'title' => "書籍名", 'author' => "著者名", 'page' => "ページ数", 'publish_date' => "出版日"}

		puts "\n2.蔵書データの表示"
		print "蔵書データを表示します。"

		sth = @dbh.execute("select * from bookinfos")

		count = 0
		sth.each do |row|
			row.each_with_name do |val, name|
				puts "#{item_name[name]}: #{val.to_s}"
			end
		puts "\n-----------------------------"
		count = count + 1
		end
		sth.finish
		puts "\n#{count}件表示しました。"
	end

	def run
		while true
			print "0.データベースの初期化　1.データベースの登録　2.データベースの表示　9.終了　："
			num = gets.chomp

			case
			when '0' == num
				initBookInfo
			when '1' == num
				addBookInfo
			when '2' == num
				listBookInfo
			when '9' == num
				@dbh.disconnect
				break;
			else
			end
		end
	end
end

book_info_manager = BookInfoManager.new("bookinfo_sqlite.db")
book_info_manager.run





