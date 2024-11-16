# frozen_string_literal: true

module Validators
  module NumberValidator
    # 文字列が数値かどうかを判定する
    # @param [String]str 数値の文字列
    # @return [Boolean] 数値の場合はtrue、それ以外はfalse
    def integer?(str)
      case str
      when /\A-?\d+\z/
        true
      else
        false
      end
    end
  end
end
