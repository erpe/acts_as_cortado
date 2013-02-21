# Include hook code here
require 'acts_as_cortado'
require 'cortado_file'

#Then, include the modules
ActiveRecord::Base.send(:include, SO36::ActsAsCortado)
ActionView::Base.send(:include, SO36::ActsAsCortado::ActionViewExtensions)
