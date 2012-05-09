class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :name
      t.string :enc_a
      t.string :ecn_b

      t.timestamps
    end
  end
end
