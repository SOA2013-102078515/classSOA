class AddColumnsToMoviegoers < ActiveRecord::Migration
  def change
    add_column :moviegoers, :provider, :string
    add_column :moviegoers, :uid, :string
    add_column :moviegoers, :name, :string
  end
end
