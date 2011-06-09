class BcryptMiddleware < Riot::ContextMiddleware
  register

  def call(context)
    setup_bcrypt_stub(context) if stub_bcrypt?(context)
    middleware.call(context)
  end

  private

  def stub_bcrypt?(context)
    context.option(:stub_bcrypt)
  end

  def setup_bcrypt_stub(context)
    context.setup do
      stub(::BCrypt::Password).create(anything) do
        "$2a$10$GnPjgre0YcmiKkGItPMMg.SNu8Mo9qP3MTk5sp5mxWxmtG7lFSqri"
      end
    end
  end
end
