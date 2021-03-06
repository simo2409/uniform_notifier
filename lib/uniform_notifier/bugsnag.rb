module UniformNotifier
  class BugsnagNotifier < Base
    def self.active?
      !!UniformNotifier.bugsnag
    end

    protected

    def self._out_of_channel_notify(data)
      opt = {}
      if UniformNotifier.bugsnag.is_a?(Hash)
        opt = UniformNotifier.bugsnag
      end

      exception = Exception.new(data[:title])
      Bugsnag.notify(exception, opt.merge(
        :grouping_hash => data[:body] || data[:title],
        :notification => data,
      ))
    end
  end
end
