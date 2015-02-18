class CatMailer < ActionMailer::Base
	default from: "catbook@esdeluxe.com"

  def welcome(cat)
  	@cat = cat
  	@url = "localhost:3000"
  	mail(to: @cat.email, subject: "Warm welcome to the catbook application!")
  end
end
