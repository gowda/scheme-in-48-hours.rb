# frozen_string_literal: true

class RealNode < Treetop::Runtime::SyntaxNode
  def value
    text_value
  end
end
