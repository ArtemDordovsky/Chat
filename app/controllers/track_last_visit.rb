module TrackLastVisit
  def self.included(klazz)
    klazz.send(:after_filter, :track, except: :create)
  end

  def track
    current_user.touch
  end
end
