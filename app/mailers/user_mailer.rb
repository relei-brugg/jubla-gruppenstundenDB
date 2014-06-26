class UserMailer < ActionMailer::Base
  default from: "gruppenstundendb@releibrugg.ch"

  def new_idea_email(idea)

    @idea = idea
    @url = idea_path(@idea)
    moderators = User.where ('notifications = true and moderator = true')
    emails = moderators.pluck(:email)
    mail(to: 'gruppenstundendb@releibrugg.ch', bcc: emails, subject: 'Neue Gruppenstunde')
  end
end
