class CreateWeekItems < ActiveRecord::Migration
	def change
		create_table :week_items do |t|
			t.belongs_to :week_day, index: true
			t.belongs_to :item, index: true
			t.timestamps null: false
		end
	end
end
