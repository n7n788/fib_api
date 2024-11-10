class Fibonacci < ApplicationRecord
  validates :position, presence: true, uniqueness: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :value, presence: true,
            format: { with: /\A\d+\z/, message: "must be a non negative integer" }

  # フィボナッチ数列の値を取得する
  # @param [Integer] position 取得するフィボナッチ数列の位置
  # @return [Integer] フィボナッチ数列の値
  def self.value(position:)
    # 既に計算済みの値であれば、その値を返す
    fibonacci = find_by(position: position)
    return fibonacci.value.to_i if fibonacci

    # 未計算であれば、計算して保存する
    begin
      raise ActiveRecord::RecordInvalid.new(Fibonacci.new) if position < 0
      return generate(position: 0, value: 1) if position == 0
      return generate(position: 1, value: 1) if position == 1
      return generate(position: position, value: value(position: position - 1) + value(position: position - 2))
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "フィボナッチレコードの保存に失敗しました: #{e.message}"
      raise e
    end
  end

  # フィボナッチ数列の値を生成する
  # @param [Integer] position 生成するフィボナッチ数列の位置
  # @param [Integer] value 生成するフィボナッチ数列の値
  # @return [Integer] 生成したフィボナッチ数列の値
  # @raise [ActiveRecord::RecordInvalid] レコードの保存に失敗した場合、エラーを発生
  def self.generate(position:, value:)
    fibonacci = new(position: position, value: value.to_s)
    fibonacci.save!
    return value
  end
end
