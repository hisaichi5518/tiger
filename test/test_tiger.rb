require 'minitest/unit'
require 'minitest/autorun'
require 'tiger'

class TestTrigerClass
  include Tiger
end

module TestTrigerModule
  include Tiger
end

class TestTriger < MiniTest::Unit::TestCase
  def test_on
    test_tiger_class = ::TestTrigerClass.new

    assert test_tiger_class.triggers[:test].nil?

    ::TestTrigerClass.on :test_on do
    end
    test_tiger_class.on :test_on do
    end

    assert_equal ::TestTrigerClass.triggers[:test_on].size, 1
    assert_equal test_tiger_class.triggers[:test_on].size, 1
  end

  def test_emit
    test_tiger_class = ::TestTrigerClass.new
    test_tiger_class.on :test_emit do |args|
      args[:count] += 1
    end

    args = {count: 0}
    assert_equal args[:count], 0

    test_tiger_class.emit(:test_emit, args)

    assert_equal args[:count], 1
  end

  def test_all_triggers
    test_tiger_class = ::TestTrigerClass.new

    assert test_tiger_class.all_triggers[:test_all_triggers].nil?

    ::TestTrigerClass.on :test_all_triggers do |args|
      args[:count] += 1
    end
    test_tiger_class.on :test_all_triggers do |args|
      args[:count] += 1
    end

    assert_equal test_tiger_class.all_triggers[:test_all_triggers].size, 2
  end

  def test_emit_all
    test_tiger_class = ::TestTrigerClass.new
    ::TestTrigerClass.on :test_emit_all do |args|
      args[:count] += 1
    end
    test_tiger_class.on :test_emit_all do |args|
      args[:count] += 1
    end

    args = {count: 0}
    assert_equal args[:count], 0

    test_tiger_class.emit_all(:test_emit_all, args)

    assert_equal args[:count], 2
  end
end

