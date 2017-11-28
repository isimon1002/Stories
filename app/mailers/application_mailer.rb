class ApplicationMailer < ActionMailer::Base
  default from: 'ijsimon@sbcglobal.net'
  layout 'mailer'
  
  def new_comment(user, tale, comment)
 
 # #18
     headers["Message-ID"] = "<comments/#{comment.id}@StoryTime.com>"
     headers["In-Reply-To"] = "<tale/#{tale.id}@StoryTime.com>"
     headers["References"] = "<tale/#{tale.id}@StoryTime.com>"
 
     @user = user
     @tale = tale
     @comment = comment
 
 # #19
     mail(to: user.email, subject: "New comment on #{tale.title}")
   end
end
