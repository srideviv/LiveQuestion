class AddColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :numVotes, :integer, :default => 0
  end
end
