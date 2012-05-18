#path = "/home/abid/Projects/evoting/"
#require "#{path}encrypted_message.rb"
#require "#{path}crypto_helper.rb"
#require "#{path}elgamal.rb"

class EVoting

  attr_accessor :scheme, :q

  def initialize
    p = 23
    g = 4
    x = 3
    @q = 11
    @scheme = Elgamal.new(p,g,x)
  end

  def encrypt_vote(vote)
    vote_msg = CryptoHelper::mod_pow(@scheme.g, vote, @scheme.p)
    puts "vote after power = #{vote_msg}"
    @scheme.encrypt(vote_msg)
  end

  def calculate_results(votes)
    m_a=1
    m_b=1
    votes.each do |vote|
      m_a *= vote.a
      m_b *= vote.b
    end  

    puts "m_a befrore #{m_a}"
    puts "m_b befrore #{m_b}"

    m_a = m_a % @scheme.p
    m_b = m_b % @scheme.p

    puts "m_a after #{m_a}"
    puts "m_b after #{m_b}"

    result = EncryptedMessage.new(m_a,m_b)
    result = @scheme.decrypt(result)
    puts "result is = #{result}"
    (-votes.length..votes.length).each do |i|
        puts "i is = #{i} "
        if CryptoHelper::mod_pow(@scheme.g,i,@scheme.p) == result
          puts i
          return i
        end
    end
  end

  def possible_outcomes
    (-2..2).each do |i|
      puts "for score = #{i} result should = #{CryptoHelper::mod_pow(@scheme.g,i,@scheme.p)}"
    end
  end

  def generate_secret(auths, shares, p)
    secret = 0
    auths.each_with_index do |i_auth, i|
      si = 1
      all_n = 1
      all_d = 1
      auths.each_with_index do |j_auth, j|
        if(j!=i)
          all_n*=auths[j]
          all_d*=(auths[j]-auths[i]);
        end
      end
      si=all_n/all_d;
      secret+=CryptoHelper.mul_mod(si,shares[i],p);
      secret=secret%p;
    end
    secret
  end

  def shamir_scheme(t,n)
    cofs = coeffs
    shares = []
    (1..n).each do |r|
      shares << value_at(cofs, r)
    end   
   
  end

  private

  def value_at(cofs, r)
    res = 0
    cofs.each_with_index do |cof, ind|
      res = res + cof*(r**ind) %
    end
  end

  end
  def coeffs
    cofs = [@scheme.x]
    (1..t-2).each do|c|
     cofs << rand(@q) 
    end 
  end
end

















