class GroupEvent < ActiveRecord::Base

  BASE_ATTRIBUTES = %i(start_on end_on duration name description location)  

  # - Associations
  belongs_to :user

  # - Validations
  validate :any_base_attribute_present
  validates :user_id, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :start_on, timeliness: { on_or_after: Date.today }, allow_blank: true
  validates :end_on, timeliness: { after: :start_on }, allow_blank: true

  # - Callbacks
  before_validation :format_attributes

  # - Methods
  # Public: tests whether an EventGroup can be considered as published
  # 
  # Returns true if is all base attributes are present, false if not.
  def published?
    all_base_attributes_present?
  end
  
  # Public: set to true the :removed attribute and save
  # 
  # returns nothing.
  def mark_as_removed!
    self.removed = true
    self.save
  end

  private
    # Private: format all the attributes that need formatting
    # 
    # Returns nothing.
    def format_attributes
      self.start_on = self.end_on - self.duration if duration? && end_on? && !start_on?
      self.duration = (self.end_on - self.start_on).to_i if start_on? && end_on? && !duration?
      self.end_on = self.start_on + self.duration if start_on? && duration? && !end_on?
    end

    # Private: Ensure there is at least one of the base attributes to create/update a GroupEvent.
    #
    # Returns nothing.
    def any_base_attribute_present
      unless BASE_ATTRIBUTES.any? { |attribute| self.send("#{attribute}?")}
        errors.add :base, "specify at least one base attribute"
      end
    end

    # Private: tests whether all the base attributes are present
    # 
    # Returns true if all present, false if not.
    def all_base_attributes_present?
      BASE_ATTRIBUTES.all? { |attribute| self.send("#{attribute}?") }
    end
end
