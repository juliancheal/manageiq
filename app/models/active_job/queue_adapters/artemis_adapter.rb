module ActiveJob
  module QueueAdapters
    class ArtemisAdapter
      def enqueue(job)
        job.provider_job_id = MiqQueue.artemis_client(job.queue_name).publish_topic(
            "class"   => JobWrapper,
            "wrapped" => job.class.to_s,
            "queue"   => job.queue_name,
            "args"    => [ job.serialize ]
        )
      end

      def enqueue_at(job, timestamp)
        job.provider_job_id = MiqQueue.artemis_client(job.queue_name).publish_topic(
          "class"   => JobWrapper,
          "wrapped" => job.class.to_s,
          "queue"   => job.queue_name,
          "args"    => [ job.serialize ],
          "at"      => timestamp
        )
      end

      class JobWrapper
        
        def perform(job_data)
          Base.execute job_data
        end
      end
    end
  end
end
