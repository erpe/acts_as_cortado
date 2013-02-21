# uses cortado applet code
# http://www.flumotion.net/src/cortado/cortado-0.2.2.tar.gz

#require 'lib/cortado_migration'
require 'net/http'
require 'ftools'

raise "You need 'ant' to create jarfile..." unless system('which ant')


root_dir = File.expand_path( File.join(File.expand_path(__FILE__),'..','..','..','..') )
#puts "root-dir: #{root_dir}"

plugin_dir = File.join(root_dir,'vendor','plugins','acts_as_cortado')
file_name = 'cortado-0.2.2.tar.gz'
dir_name = File.join(plugin_dir,'cortado-0.2.2')
dest_dir = File.join(root_dir,'public','jars')
view_dir = File.join(root_dir,'app','views','cortado')

puts "fetching cortado source from flumotion..."
begin
  source = Net::HTTP.new('www.flumotion.net',80)
  resp, data = source.get('/src/cortado/cortado-0.2.2.tar.gz')
  #TODO check if resp is 200
  puts "going to write to #{plugin_dir}"
  Dir.chdir(plugin_dir) do
    File.open(file_name,'w') do |f|
      f.puts(data)
    end
  end
rescue Exception => e
  puts "could not fetch cortado source -"
  puts "do it manually - fetch http://www.flumotion.net/src/cortado/cortado-0.2.2.tar.gz"
  raise "could not complete!"
end

puts "unpacking the source..."
Dir.chdir(plugin_dir) do
  system("tar xvfz #{file_name}")
end


puts "going to build applet... in #{dir_name}"

Dir.chdir(dir_name) do
  # create build.config-file
  File.open('build.config','w') do |f|
    f.puts("# choose between debug and stripped builds")
    f.puts("build.type   stripped")
  end
  ret = system('ant applet-ovt')
end

puts "going to create jar-directory /public/jars and copy jar-file"
Dir.mkdir(dest_dir) unless File.exist?(dest_dir)
from = File.join(dir_name,'output','dist','applet','cortado-ovt-stripped-0.2.2.jar')
File.copy(from,dest_dir,true)

puts "going to create views..."
Dir.mkdir(view_dir) unless File.exist?(view_dir)
Dir.chdir(File.join(plugin_dir,'templates')) do
  Dir.glob('*.rhtml').each { |f| File.copy(f,view_dir) }
end


