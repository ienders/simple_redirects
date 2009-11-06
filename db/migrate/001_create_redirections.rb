class CreateRedirections < ActiveRecord::Migration
  def self.up
    create_table :redirections do |t|
      t.string     :url_from
      t.string     :url_to
      t.timestamps
    end
    add_index :redirections, :url_from
  end

  def self.down
    drop_table :redirections
  end
end
