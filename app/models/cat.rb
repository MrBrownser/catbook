class Cat < ActiveRecord::Base
  # Implementing authorization
  has_secure_password
  
  validates :name, presence: true, length: { in: 2..255 }
  validate :email

  scope :visible, -> { where(visible: true) }
  scope :hidden,  -> { where(visible: false) }

  # More info
  # http://guides.rubyonrails.org/association_basics.html
  # https://www.railstutorial.org/book/frontmatter
  # http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_many
  # http://stackoverflow.com/questions/5856838/scope-with-join-on-has-many-through-association
  has_many :follower_relations
  has_many :followed_relations, class_name: "FollowerRelation", foreign_key: "followed_cat_id"

  has_many :followers,    -> { visible }, through: :follower_relations, source: :followed
  has_many :followed_by,  -> { visible }, through: :followed_relations, source: :cat
end


__END__

# class User < ActiveRecord::Base
#   has_secure_password
# end

# user = User.new(name: 'david', password: '', password_confirmation: 'nomatch')
# user.save                                                       # => false, password required
# user.password = 'mUc3m00RsqyRe'
# user.save                                                       # => false, confirmation doesn't match
# user.password_confirmation = 'mUc3m00RsqyRe'
# user.save                                                       # => true
# user.authenticate('notright')                                   # => false
# user.authenticate('mUc3m00RsqyRe')                              # => user
# User.find_by(name: 'david').try(:authenticate, 'notright')      # => false
# User.find_by(name: 'david').try(:authenticate, 'mUc3m00RsqyRe') # => user