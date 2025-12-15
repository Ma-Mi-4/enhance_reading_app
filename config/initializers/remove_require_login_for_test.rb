if Rails.env.test?
  Rails.application.config.after_initialize do
    [
      ApplicationController,
      QuestionsController
    ].each do |klass|
      callbacks = klass._process_action_callbacks

      callbacks.each do |cb|
        if cb.filter == :require_login
          callbacks.delete(cb)
        end
      end
    end
  end
end
