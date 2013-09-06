ThinkingSphinx::Index.define :term, :with => :active_record do
  indexes :short_name
  indexes :long_name
  indexes :description
end
