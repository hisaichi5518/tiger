require 'minitest/unit'
require 'minitest/autorun'
require 'tiger'

class TestTigerClass
  include Tiger
end

module TestTigerModule
  include Tiger
end

class TestTiger < MiniTest::Unit::TestCase
  def test_class_on
    test_tiger_class = ::TestTigerClass.new

    assert test_tiger_class.triggers[:test_on].nil?

    ::TestTigerClass.on :test_on do
    end
    test_tiger_class.on :test_on do
    end

    assert_equal ::TestTigerClass.triggers[:test_on].size, 1
    assert_equal test_tiger_class.triggers[:test_on].size, 1
  end

  def test_class_emit
    test_tiger_class = ::TestTigerClass.new
    ::TestTigerClass.on :test_emit do |args|
      args[:count] += 1
      args[:self]   = self
    end
    test_tiger_class.on :test_emit do |args|
      args[:count] += 1
      args[:self]   = self
    end

    args = {count: 0}
    assert_equal args[:count], 0
    test_tiger_class.emit(:test_emit, args)
    assert_equal args[:count], 1
    assert_instance_of TestTigerClass, args[:self]

    ::TestTigerClass.emit(:test_emit, args)
    assert_equal args[:count], 2
    assert_equal args[:self], TestTigerClass
  end

  def test_class_all_triggers
    test_tiger_class = ::TestTigerClass.new

    assert test_tiger_class.all_triggers[:test_all_triggers].nil?

    ::TestTigerClass.on :test_all_triggers do |args|
      args[:count] += 1
    end
    test_tiger_class.on :test_all_triggers do |args|
      args[:count] += 1
    end

    assert_equal test_tiger_class.all_triggers[:test_all_triggers].size, 2
  end

  def test_class_emit_all
    test_tiger_class = ::TestTigerClass.new
    ::TestTigerClass.on :test_emit_all do |args|
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

