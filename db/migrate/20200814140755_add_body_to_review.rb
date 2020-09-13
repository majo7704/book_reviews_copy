class AddBodyToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :body, :string
  end
end
