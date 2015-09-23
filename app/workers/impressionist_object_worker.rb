class ImpressionistObjectWorker
  include Sidekiq::Worker
  include ImpressionistController::InstanceMethods

  def perform(args)
    obj = nil
    begin
      obj = args[:impressionable_type].constantize.where(id: args[:impressionable_id]).first
    rescue
      return
    end
    return if obj.nil?

    if unique_instance?(obj, args[:options][:unique])
      params = args.except(:options, :impressionable_type, :impressionable_id)
      obj.impressions.create(params)
    end
  end

end

