module Mod1
  def hello
    'Hello from Mod1.'
  end

  def goodbye
    'Goodbye from Mod1.'
  end
end

class Klass1
  extend Mod1

  def hello
    'Hello from Klass1.'
  end
end

describe Klass1 do
  describe '#hello' do
    it do
      k = Klass1.new
      expect(k.hello).to eq('Hello from Klass1.')
    end

    it do
      k1 = Klass1.new
      k1.extend(Mod1)
      expect(k1.hello).to eq('Hello from Mod1.')

      k2 = Klass1.new
      expect(k2.hello).to eq('Hello from Klass1.')
    end
  end

  describe '.goodbye' do
    it { expect(Klass1.goodbye).to eq('Goodbye from Mod1.') }
  end

  describe '#goodbye' do
    it { expect { Klass1.new.goodbye }.to raise_error(NoMethodError) }
  end
end
