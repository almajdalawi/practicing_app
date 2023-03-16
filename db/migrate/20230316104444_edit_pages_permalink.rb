class EditPagesPermalink < ActiveRecord::Migration[6.1]
  def change
    change_column :pages, :permalink, :string
  end
end
