# ActsAsCortado

require 'cortado_migration'
module SO36
  module ActsAsCortado
    def self.included(mod)
      mod.extend(ClassMethods)
    end
    
    def self.init_database
      CreateCortadoFiles.up
    end
    
    def self.destroy_cortado_files_table
      CreateCortadoFiles.down
    end
    
    # declare the class level helper methods which
    # will load the relevant instance methods
    # defined below when invoked
    module ClassMethods
      
      def acts_as_cortado
        has_many :cortado_files, :as => :streamable
        extend SO36::ActsAsCortado::SingletonMethods
        include SO36::ActsAsCortado::InstanceMethods
      end
      
      def default_options
        { 
          :width => 0,
          :height => 0
        }
      end
      
    end
    
    # Adds a catch_chickens class method which finds
    # all records which have a 'streamable' field set
    # to true.
    module SingletonMethods
      
      def streamable_with_cortado_files
        find(:all, :conditions => [])
      end
      
    end
    
    # Adds instance methods.
    module InstanceMethods
      def cortado_info
          "<foo>info here </foo>"
      end
    end
    
     module ActionViewExtensions
    # TODO check / get length of cortado_file
    # TODO make aspect-ratio parametrized
    
    # options can be
    # local => true || false
    # bufferSize => 200
    # userId => <userid>
    # password => <password>
    # duration => <length of media>
    # keepAspect => true | false default to true
    # width => int | defaults to 352
    # height => int | defaults to 288
    #
    def cortado_applet_for(cortado_file,options = nil)
      @file_uri = cortado_file.file_uri
      
      render(:partial => '/cortado/applet')
    end
    
    def popup_cortado_applet_for(cortado_file)
      
    end
    
    # independent applet from CortadoFile 
    # created solely by given options
    #
    def applet_for_options(opts)
      
    end
    
    def popup_applet_for_options(opts)
      
    end
    
    
    
  end
    
  end
  
 
  
end