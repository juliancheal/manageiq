module ActiveJob
  module QueueAdapters
    class MiqQuAdapter
      def enqueue(job)
      end

      def enqueue_at(job, timestamp)
      end

      class JobWrapper
        class << self
          def perform(job_data)
            Base.execute job_data
          end
        end
      end
    end
  end
end
