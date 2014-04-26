module Tiger
  module ClassMethod
    attr_accessor :triggers

    def initialize
      @triggers = {}
    end

    def on(name, &code)
      trigger(name).push(code)
    end

    def emit(name, *args)
      trigger(name).each do |code|
        self.instance_exec(*args, &code)
      end
    end

    private
    def trigger(name)
      @triggers       ||= {}
      @triggers[name] ||= []
      @triggers[name]
    end
  end
end
