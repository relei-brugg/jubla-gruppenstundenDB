class IdeaVisit < ActiveRecord::Base
  belongs_to :idea



  def self.visit(idea, ip, download=false)
    visit = IdeaVisit.find_by_idea_id_and_ip_and_download(idea.id, ip, download)

    if !visit || visit.updated_at < 1.day.ago
      #update visit
      visit = IdeaVisit.create(idea: idea, ip: ip, download: download) if !visit
      visit.updated_at = Time.now
      visit.save

      #update idea-views
      idea.views += 1 if !download
      idea.downloads += 1 if download
      idea.update_record_without_timestamping
    end

    cleanVisits
  end

  def self.cleanVisits
    IdeaVisit.destroy_all (["updated_at < ?", Time.now - 1.day])
  end

end
