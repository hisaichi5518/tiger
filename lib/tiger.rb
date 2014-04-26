require "tiger/version"
require "tiger/class_method"

module Tiger
  include ClassMethod

  def self.included(klass)
    klass.extend ClassMethod
  end

  def all_triggers
    module_triggers = self.class.triggers || {}
    class_triggers  = self.triggers       || {}

    module_triggers.merge(class_triggers) do |key, m, c|
      m + c
    end
  end

  def emit_all(name, *args)
    triggers = all_triggers[name] || []
    triggers.each do |proc|
      proc.call(*args)
    end
  end
end
