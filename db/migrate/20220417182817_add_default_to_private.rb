class AddDefaultToPrivate < ActiveRecord::Migration[6.1]
  def change
    change_column_default(
      :users,
      :private,
      true
    )

    change_column_default(
      :users,
      :likes_count,
      0
    )
  end
end
