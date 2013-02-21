require 'test/unit'

class ActsAsCortadoTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_this_plugin
    flunk
  end
  
  # check if cortado.jar was successfully build and copied 
  # to /public/jars
  #
  def test_existence_of_cortado_jar
    assert( File.exist?(File.join(RAILS_ROOT,'public','jars','cortado-ovt-stripped-0.2.2.jar') ) )
  end
  
  # check if database was successfully setup
  #
  def test_existence_of_db_table
    
  end
  
  
  
end
