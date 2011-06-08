class DatabaseCleanerMiddleware < Riot::ContextMiddleware
  register

  def call(context)
    setup_database_cleaner(context) if clean_database?(context)
    middleware.call(context)
  end

  private

  def clean_database?(context)
    context.option(:clean_database)
  end

  def setup_database_cleaner(context)
    context.setup { DatabaseCleaner.clean }
  end
end

