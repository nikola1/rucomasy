module MessageSHelper
  def message(text)
    erb :message, locals: { content: text }
  end
end