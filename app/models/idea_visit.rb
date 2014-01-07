class IdeaVisit < ActiveRecord::Base
  belongs_to :idea


  def self.visitIdea(idea, ip)

    visit = IdeaVisit.find_by_idea_id_and_ip(idea.id, ip)

    if !visit || visit.updated_at < 1.day.ago
      #update visit
      visit = IdeaVisit.create(idea: idea, ip: ip) if !visit
      visit.updated_at = Time.now
      visit.save

      #update idea-views
      idea.views += 1
      idea.update_record_without_timestamping
    end

  end

end
