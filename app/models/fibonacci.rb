# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
class Fibonacci < ApplicationRecord
  validates :position, presence: true, uniqueness: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :value, presence: true,
                    format: { with: /\A\d+\z/, message: 'must be a non negative integer' }

  # フィボナッチ数列の値を取得する
  # @param [Integer] position 取得するフィボナッチ数列の位置
  # @return [BigDecimal] フィボナッチ数列の値
  def self.value(position:)
    # 既に計算済みの値であれば、その値を返す
    fibonacci = find_by(position: position)
    return fibonacci.value.to_d if fibonacci

    # 計算済みでなければ、新しく計算する
    calculate(position: position)
  end

  # フィボナッチ数列の値を計算して保存する
  # @param [Integer] position 計算するフィボナッチ数列の位置
  # @return [BigDecimal] 計算したフィボナッチ数列の値
  # @raise [ActiveRecord::RecordInvalid] レコードの保存に失敗した場合、エラーを発生
  def self.calculate(position:)
    validate_negative_position!(position: position)

    value = if base_case?(position: position)
              BigDecimal('1')
            else
              value(position: position - 1) + value(position: position - 2)
            end
    generate(position: position, value: value)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message.to_s
    raise e
  end

  # フィボナッチ数列の値を生成して保存する
  # @param [Integer] position 生成するフィボナッチ数列の位置
  # @param [BigDecimal] value 生成するフィボナッチ数列の値
  # @return [BigDecimal] 生成したフィボナッチ数列の値
  # @raise [ActiveRecord::RecordInvalid] レコードの保存に失敗した場合、エラーを発生
  def self.generate(position:, value:)
    fibonacci = new(position: position, value: value.to_i.to_s)
    fibonacci.save!
    value
  end

  # フィボナッチ数列の基本ケース (位置が0または1) をチェック
  # @param [Integer] position チェックするフィボナッチ数列の位置
  # @return [Boolean] チェック結果
  def self.base_case?(position:)
    position.zero? || position == 1
  end

  # 負の位置をバリデーションする
  # @param [Integer] position バリデーションするフィボナッチ数列の位置
  # @raise [ActiveRecord::RecordInvalid] バリデーションに失敗した場合、エラーを発生
  def self.validate_negative_position!(position:)
    raise ActiveRecord::RecordInvalid, Fibonacci.new if position.negative?
  end
end
