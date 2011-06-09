object @link
attributes :url, :slug, :created_at
unless @link.valid?
  code(:errors) { @link.errors.full_messages }
end
