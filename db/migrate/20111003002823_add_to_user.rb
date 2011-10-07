class AddToUser < ActiveRecord::Migration
  def up
    User.create :uname => "admin",
                 :name => "admin",
                 :salt => "396127440.739111634267147",
                 :hashed_password => "88824915f126f905167b13fb9a64fc88219e4d2165e5a2c6d939659d6519cdb5",
                 :admin_perm => true
  end

  def down
  end
end
