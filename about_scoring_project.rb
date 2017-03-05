# require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:

  def score
    return score = 0
    score = 0
    score += 1000 if dice.count(1) >= 3
    score += 200 if dice.count(2) == 3
    score += 300 if dice.count(3) == 3
    score += 400 if dice.count(4) == 3
    score += 500 if dice.count(5) >= 3
    score += 600 if dice.count(6) == 3  # Los de  2, 3, 4, 5 y 6  se tienen que poder unificar !!!!!!
    score += 50 * (dice.count(5) % 3)
    score += 100 * (dice.count(1) % 3)
      
 
  # si todas las dice son diferentes entre si  y no hay ni unos  ni cincos saca un cero
# si tienes 3 unos anota 1000 puntos, 
# si tienes 3 iguales, que no son unos, multiplica ese numero por 100
# si tienes un 1 (a parte de los otros 3) sumas 100
# si tienes dos 1 (a parte de los otros 3) sumas 200
# si tienes un 5 (a parte de los otros 3) sumas 50
  # You need to write this method
  end

# class AboutScoringProject < Neo::Koan
#   def test_score_of_an_empty_list_is_zero
#     assert_equal 0, score([])
#   end

#   def test_score_of_a_single_roll_of_5_is_50
#     assert_equal 50, score([5])
#   end

#   def test_score_of_a_single_roll_of_1_is_100
#     assert_equal 100, score([1])
#   end

#   def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
#     assert_equal 300, score([1,5,5,1])
#   end

#   def test_score_of_single_2s_3s_4s_and_6s_are_zero
#     assert_equal 0, score([2,3,4,6])
#   end

#   def test_score_of_a_triple_1_is_1000
#     assert_equal 1000, score([1,1,1])
#   end

#   def test_score_of_other_triples_is_100x
#     assert_equal 200, score([2,2,2])
#     assert_equal 300, score([3,3,3])
#     assert_equal 400, score([4,4,4])
#     assert_equal 500, score([5,5,5])
#     assert_equal 600, score([6,6,6])
#   end

#   def test_score_of_mixed_is_sum
#     assert_equal 250, score([2,5,2,2,3])
#     assert_equal 550, score([5,5,5,5])
#     assert_equal 1100, score([1,1,1,1])
#     assert_equal 1200, score([1,1,1,1,1])
#     assert_equal 1150, score([1,1,1,5,1])
#   end

# end
