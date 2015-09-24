class ImpressionistWorker
  include Sidekiq::Worker
  include ImpressionistController::CommonMethods

  def perform(args)
    if unique?(args['options']['unique'])
      params = args.except('options')
      Impression.create(params)
    end
  end

end

