module ContentCreation
  def initialize(params, context)
    @params = params
    @context = context
  end

  def call
    with_activity(content_type) do |result|
      result.on(:rate_limited) do
        broadcast(:redirect, "/help/rate-limited")
      end
      result.on(:spam) do
        broadcast(:redirect, "/help/spam")
      end
      result.on(:ok) do
        content = create_content
        ::Users::ActivityCreateService.call(@context, content)
        broadcast(:success, content)
      end
      result.call
    end
  end
end
