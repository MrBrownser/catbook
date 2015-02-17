require 'benchmark'

namespace :catbook do
	desc "Seed the catbook database with random data"
	task seed_catbook: :environment do
		case Rails.env
		when "development"
			1000.times do |i|
    			Cat.create!(name: Faker::Name.name, birthday: Faker::Date.birthday)
  			end
		end