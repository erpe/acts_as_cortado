class CortadoFile < ActiveRecord::Base
  
  belongs_to :streamable, :polymorphic => true
  validates_presence_of :file_uri
  validates_presence_of :file_name
  validates_presence_of :streamable_id
  
end