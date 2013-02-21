
class CreateCortadoFiles < ActiveRecord::Migration
  def self.up
    create_table :cortado_files do |t|
      t.column :file_uri, :string, :null => false
      t.column :file_name, :string
      t.column :meta_xml, :text
      t.column :streamable_id, :integer, :null => false
      t.column :streamable_type, :string
    end
  end

  def self.down
    drop_table :cortado_files
  end
end