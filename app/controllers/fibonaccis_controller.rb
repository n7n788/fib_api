# frozen_string_literal: true

class FibonaccisController < ApplicationController
  # GET /fib
  def show
    # 整数でない場合
    unless integer?(n_params)
      render json: { status: 400, message: 'Bad request.' }, status: 400
      return
    end

    position = n_params.to_i - 1
    if position.negative? # 負の整数の場合
      render json: { status: 400, message: 'Bad request.' }, status: 400
    else
      render json: { result: Fibonacci.value(position: position).to_i }, status: 200
    end
  end

  private

  def n_params
    params.require(:n)
  end

  # 文字列が数値かどうかを判定する
  # @param [String]str 数値の文字列
  def integer?(str)
    case str
    when /\A-?\d+\z/
      true
    else
      false
    end
  end
end
