class FibonaccisController < ApplicationController

  # GET /fib
  def show
    # 整数でない場合
    unless is_integer?(n_params)
      render json: { status: 400, message: "Bad request." }, status: 400
      return
    end

    n = n_params.to_i - 1
    if n < 0 # 負の整数の場合
      render json: { status: 400, message: "Bad request." }, status: 400
    else
      render json: { result: Fibonacci.value(position: n).to_i }, status: 200
    end
  end

  private

  def n_params
    params.require(:n)
  end

  def is_integer?(n)
    case n
    when /\A-?\d+\z/
      true
    else
      false
    end
  end
end
