class RenameDeliveryFreeIdColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :delivery_free_id, :delivery_fee_id
  end
end
