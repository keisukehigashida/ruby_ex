# -*- coding: utf-8 -*-

require 'rubygems'
require 'dbi'

dbh = DBI.connect('DBI:SQLite3:student01.db')
sth = dbh.execute("select * from students")

sth.each do |row|
	row.each_with_name do |val, name|
		puts "#{name}: #{val.to_s}"
	end
end

sth.finish
dbh.disconnect


