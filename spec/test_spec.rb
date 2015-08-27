describe 'Operator' do
  describe '||=' do
    a ||= 2
    a ||= 3
    it { expect(a).to eq(2) }
  end

  describe '<=>' do
    it 'return 0 if first operand equals second' do
      expect(1 <=> 1).to eq(0)
    end

    it 'return 1 if first operand is greater than second' do
      expect(1 <=> 0).to eq(1)
    end

    it 'return -1 if first operand is less than second' do
      expect(1 <=> 2).to eq(-1)
    end
  end

  describe '<<' do
    it 'move the left operands value to left by the number of bits specified by the right operand' do
      expect(0b00111100 << 2).to eq(240)
    end
  end

  describe '>>' do
    it 'move the left operands value to left by the number of bits specified by the right operand' do
      expect(0b00111100 >> 2).to eq(15)
    end
  end

  describe '=~' do
    it { expect('foo' =~ /f/).to eq 0 }
    it { expect('foo' =~ /b/).to be_nil }
  end

  describe '!~' do
    it { expect('foo' !~ /b/).to be true }
    it { expect('foo' !~ /f/).to be false }
  end
end

describe Array do
  describe 'initialize' do
    let(:c) { 'd' }
    it { expect([*1..3]).to eq([1, 2, 3]) }
    it { expect((1..3).to_a).to eq([1, 2, 3]) }
    it { expect(%w(a b #{c})).to eq(['a', 'b', '#{c}']) }
    it { expect(%W(a b #{c})).to eq(['a', 'b', 'd']) }
  end

  describe '<<' do
    it 'push the given object on to the end' do
      expect([1] << 2).to eq([1, 2])
    end
  end

  describe '&' do
    it 'return a new array containing elements common' do
      expect([1, 2] & [2, 3]).to eq([2])
    end
  end

  describe 'flatten' do
    it { expect([1, 2, [3]].flatten).to eq([1, 2, 3]) }
  end
end

describe 'Array#map' do
  let(:a) { [10, 20, 30, 40, 50] }

  it '' do
    expect(a.map { |v| v * 10 }).to eq([100, 200, 300, 400, 500])
    expect(a).to eq([10, 20, 30, 40, 50])
  end

  it '' do
    expect(a.map! { |v| v / 10 }).to eq([1, 2, 3, 4, 5])
    expect(a).to eq([1, 2, 3, 4, 5])
  end
end

describe Hash do
  let(:h1) { {} }

  it { expect(h1.class).to eq(Hash) }

  describe 'initialize' do
    let(:h2) { Hash.new(0) }

    it { expect(h2.class).to eq(Hash) }

    it { expect(h1['foo']).to be_nil }
    it { expect(h2['foo']).to eq(0) }
  end
end

# MyClass
class MyClass
  def initialize(*args)
    @a = args[0]
    @b = args[1]
    @c = args[2]
    @d = args[3]
  end

  attr_accessor :a
  attr_writer :b
  attr_reader :c

  def foo
    self.e = 9
  end

  def e=(e)
    @e = e
  end
end

describe MyClass do
  let(:my_class) { MyClass.new(1, 2, 3, 4) }

  subject { my_class }

  describe 'attr_accessor' do
    it 'generate reader and writer' do
      expect(subject.a = 5).to eq(5)
    end
  end

  describe 'attr_writer' do
    it 'generate writer' do
      expect(subject.b = 6).to eq(6)
    end

    it 'raise NoMethodError when accessed with reader' do
      expect { subject.b }.to raise_error(NoMethodError)
    end
  end

  describe 'attr_reader' do
    it 'generate reader' do
      expect(subject.c).to eq(3)
    end

    it 'raise NoMethodError when accessed with writer' do
      expect { subject.c = 7 }.to raise_error(NoMethodError)
    end
  end

  describe 'no accessor' do
    it 'raise NoMethodError when accessed with writer' do
      expect { subject.d = 8 }.to raise_error(NoMethodError)
    end

    it 'raise NoMethodError when accessed with reader' do
      expect { subject.d }.to raise_error(NoMethodError)
    end
  end

  describe '#foo' do
    it '' do
      expect(subject.foo).to eq(9)
    end
  end

  describe '#e' do
    it '' do
      expect(subject.e = 10).to eq(10)
    end
  end
end

describe 'all?' do
  let(:a1) { %w(aaa bbb ccc) }
  let(:a2) { ['aaa', 'bbb', 111] }
  let(:a3) { ['aaa', false, 'ccc'] }

  it '' do
    expect(a1.all? { |w| w.is_a?(String) }).to be(true)
  end

  it '' do
    expect(a2.all? { |w| w.is_a?(String) }).to be(false)
  end

  it '' do
    expect(a3.all?).to be(false)
  end
end

describe 'any?' do
  let(:a1) { [1, 2, 3] }
  let(:a2) { [false, true] }
  let(:a3) { [false, nil] }

  it '' do
    expect(a1.any? { |w| w < 4 }).to be(true)
  end

  it '' do
    expect(a1.any? { |w| w >= 4 }).to be(false)
  end

  it '' do
    expect(a2.any?).to be(true)
  end

  it '' do
    expect(a3.any?).to be(false)
  end
end

describe Float do
  let(:a) { 0.5 * 0.5 }
  let(:b) { 0.5 * 0.5 }

  it 'be Float' do
    expect(a.class).to eq(Float)
  end

  it 'have same value' do
    expect(a).to eq(b)
  end

  it 'not be same' do
    expect(a).not_to be(b)
  end
end

describe Bignum do
  let(:a) { 100_000_000_000 * 100_000_000_000 }
  let(:b) { 100_000_000_000 * 100_000_000_000 }

  it 'be Bignum' do
    expect(a.class).to eq(Bignum)
  end

  it 'have same value' do
    expect(a).to eq(b)
  end

  it 'not be same' do
    expect(a).not_to be(b)
  end
end

describe Fixnum do
  let(:a) { 1 }
  let(:b) { 1 }

  it 'be Fixnum' do
    expect(a.class).to eq(Fixnum)
  end

  it 'have same value' do
    expect(a).to eq(b)
  end

  it 'be same' do
    expect(a).to be(b)
  end
end

describe '__send__' do
  let(:str2id) { { 'foo' => :action1 } }

  def action1
    'action1'
  end

  it '' do
    expect(__send__ str2id['foo']).to eq('action1')
  end
end

describe 'Range' do
  describe '..' do
    range = 1..10

    it 'create a range from start point to end point inclusive' do
      expect(range.first).to eq(1)
      expect(range.last).to eq(10)
      expect(range.exclude_end?).to be(false)
      expect(range.to_a.length).to eq(10)
    end
  end

  describe '...' do
    range = 1...10

    it 'create a range from start point to end point exclusive' do
      expect(range.first).to eq(1)
      expect(range.last).to eq(10)
      expect(range.exclude_end?).to be(true)
      expect(range.to_a.length).to eq(9)
    end
  end
end
