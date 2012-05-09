class Vote < ActiveRecord::Base
  attr_accessible :ecn_b, :enc_a, :name, :party
  attr_accessor :party

  before_save :encrypt, :on => :create

  def encrypt
    v = EVoting.new
    env_vote = v.encrypt_vote(party.to_i)
    puts env_vote.inspect + "---------------"
    self.enc_a = env_vote.a.to_s
    self.ecn_b = env_vote.b.to_s
    
    puts enc_a + "==================="
    puts ecn_b + "==================="
  end

  def self.encrypted_votes
    all.map{|v| EncryptedMessage.new(v.enc_a.to_i, v.ecn_b.to_i)}
  end

end
