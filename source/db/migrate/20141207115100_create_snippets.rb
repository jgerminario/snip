class CreateSnippets < ActiveRecord::Migration
	def change 
		create_table :snippets do |t|
			t.text :code
			t.string :title
			t.integer :line
			t.string :filename

			t.timestamps
		end

	end

end