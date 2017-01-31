module Mod2
  def hello
    'Hello from Mod2.'
  end

  def goodbye
    'Goodbye from Mod2.'
  end
end

class Klass2
  include Mod2

  def hello
    'Hello from Klass2.'
  end
end

describe Klass2 do
  describe '.goodbye' do
    it { expect { Klass2.goodbye }.to raise_error(NoMethodError) }
  end

  describe '#goodbye' do
    it { expect(Klass2.new.goodbye).to eq('Goodbye from Mod2.') }
  end
end
