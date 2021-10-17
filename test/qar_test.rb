# frozen_string_literal: true

require "test_helper"

class QarTest < Minitest::Test
  include QuantumException
  def test_that_it_has_a_version_number
    refute_nil ::Qar::VERSION
  end

  def test_it_does_something_useful
    # test that we are not a teapot... just 4 fun
    assert self != :i_am_a_teapot

    # test that no errors occur when importing the module
    assert_nothing_raised do
      require "qar"
    end
  end

  def test_qbit_constructor_integer

    assert_nothing_raised NormalizationException do
      Qbit.new(1, 0)
    end

    assert_raises NormalizationException do
      Qbit.new(1, 1)
    end

  end

  def test_qbit_constructor_real
    assert_nothing_raised NormalizationException do
      Qbit.new(Math.sqrt(2) / 2, Math.sqrt(2) / 2)
    end
  end

  def test_qbit_constructor_complex
    assert_raises NormalizationException do
      Qbit.new(-1i / 2, 2i)
    end
  end

  def test_qbit_measure_integer
    srand(1000)
    q = Qbit.new(1, 0)
    assert q.measure.zero?
  end

  def test_qbit_measure_real
    srand(1000)
    q = Qbit.new(Math.sqrt(2) / 2, Math.sqrt(2) / 2)
    assert (not q.measure.zero?)
  end

  def test_qbit_measure_complex
    srand(1000)
    q = Qbit.new((1 + 1i) / 2, 1i / Math.sqrt(2))
    assert q.measure == 1
  end

  def test_qbit_to_s
    q = Qbit.new(1, 0)
    assert q.to_s == "1|0>"
  end
  
  def test_qbit_to_s_real
    q = Qbit.new(Math.sqrt(2) / 2, Math.sqrt(2) / 2)

    assert q.to_s == "0.7071067812|0> + 0.7071067812|1>"
  end
  
  def test_qbit_to_s_complex
    q = Qbit.new((1 + 1i) / 2, 1i / Math.sqrt(2))

    assert q.to_s == "1/2+1/2i|0> + 0.0+0.7071067812i|1>"
  end

  def test_qbit_generator
    srand(Time.now.to_i)
    assert_nothing_raised do
      q = Qbit.generate
    end
  end
end
