require "digest/sha2"
class User < ActiveRecord::Base
  has_many :posts
  has_many :votes
  has_many :comments
  has_many :comment_votes


    validates_presence_of :uname
    validates_uniqueness_of :uname

    validate :password_non_blank

    #def authenticate (username, pwd)
    #   if self.uname == username && self.password == pwd
    #      return true
    #   else
    #      return false
    #   end

    def password
      @password
    end

     def authenticate(username, password)
      user = User.find_by_uname(username)
      if user
        expected_password = encrypted_password(password, user.salt)
        if user.hashed_password != expected_password
          user = nil
        end
      end
      user
     end


    def password=(pwd)
      @password = pwd
      return if pwd.blank?
      create_new_salt
      self.hashed_password = encrypted_password(self.password, self.salt)
    end

    #Destroy function for user - Destroying a user should destroy his posts, votes, comments, comment votes
    def destroyCascade()
      posts = Post.find( :all, :conditions => [ "user_id = ?", self.id ] )
      for p in posts do
       p.destroyCascade()
      end

     # votes = Vote.find( :all, :conditions => [ "user_id = ?", self.id ] )
      #for m in 0 ... votes.size do
       # Vote.destroyCascade(votes[m])
      #end

      #comments = Comment.find( :all, :conditions => [ "user_id = ?", self.id ] )
      #for i in 0 ... comments.size do
       # Comment.destroyCascade(comments[i])
      #end

      #commentvotes = CommentVote.find( :all, :conditions => [ "user_id = ?", self.id ] )
      #for j in 0 ... commentvotes.size do
       # CommentVote.destroyCascade(comments[j])
      #end

      self.destroy
    end


    private
    def password_non_blank
      errors.add(:password, "Missing password") if hashed_password.blank?
    end

    def encrypted_password(password, salt)
      string_to_hash = password + "girashsri" + salt
      Digest::SHA2.hexdigest(string_to_hash)
    end

    def create_new_salt
      self.salt = self.object_id.to_s + rand.to_s
    end


  end
