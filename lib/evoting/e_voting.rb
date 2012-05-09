#path = "/home/abid/Projects/evoting/"
#require "#{path}encrypted_message.rb"
#require "#{path}crypto_helper.rb"
#require "#{path}elgamal.rb"

class EVoting

  attr_accessor :scheme

  def initialize
    p = 1849271
    g = 7109
    x = 1234
    #p = 17
    #g = 6
    #x = 2
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

  def compute_secret_shares(sec_mat, p)
    n = sec_mat.size
    t = sec_mat.first.size

    res_poly = Array.new(t,0)

    t.times do |r|
      n.times do |s|
        res_poly[r]+=sec_mat[s][r]
      end
      res_poly[r] %=p
    end

    f = Array.new(n,0)

    n.times do |ss|
      t.times do |spi|
        f[ss]+=res_poly[spi]*((ss+1)**spi)
      end
      f[ss] %= p
    end
    f
  end
end
