class Event < ActiveRecord::Base
  has_event_calendar
  validates :name, :presence => true
  validates :start_at, :presence => true
  validates :end_at, :presence => true
  belongs_to :user

  def people
    partecipating = Attend.where('event_id'  => self.id)
    part_array=[]
    partecipating.each do |part|
      part_array << User.find(part.user_id).username
      part_array << " | "
    end
    if part_array.empty?
      "<strong>No one has confirmed the presence</strong>".html_safe
    else
      part_array
    end
  end

  def attend_list
      attend_list = (Attend.where('event_id'  => self.id))
      attend=[]
      attend_list.each do |attendant|
        attend << User.find(attendant.user_id).id
      end
      return attend
    end
end