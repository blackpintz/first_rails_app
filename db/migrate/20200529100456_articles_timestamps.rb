class ArticlesTimestamps < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :created_at, :datetime
    add_column :cars, :color, :string
  end
end
