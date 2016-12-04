#!/usr/bin/lua
-- ---------------------------------------------------------------- -*- Lua -*-
-- $LastChangedDate: 2016-03-15 14:46:14 +0100 (Di, 15 Mär 2016) $
-- $LastChangedBy: jesus $
--
-- ------------------------------------------------------------------------------

EXPORT_ASSERT_TO_GLOBALS = true
require('GeneticAlgorithm')
require('luaunit')

TestGA = {} 

-- ------------------------------------------------------------------------------
function TestGA:setUp()
end

-- ------------------------------------------------------------------------------
function TestGA:tearDown()
  collectgarbage()
end

-- ------------------------------------------------------------------------------
function TestGA:test_AdditionExample()
  local numChromosomes = 10
  local genesRangeValues = {{0,1}, {0,1}}
  local probMutation = 0.1
  local probCrossover = 0.7
  local elitismSize = 3

  function funcAdd2(xs)
    return xs[1] + xs[2]
  end

  local myGA = GeneticAlgorithm.new(numChromosomes, genesRangeValues, probMutation, probCrossover, elitismSize, funcAdd2)
  myGA.evolve(100)
  local optim = myGA.getBestChromosomes(1)

  print('Addition sol.:'..optim[1][1]..','..optim[1][2])
  assert(optim[1][1] > 0.9)
  assert(optim[1][2] > 0.9)
end

------------------------------------------------------------------------------
function TestGA:test_MultiplyExample()
  local numChromosomes = 10
  local genesRangeValues = {{0,1}, {0,1}}
  local probMutation = 0.1
  local probCrossover = 0.7
  local elitismSize = 3

  function funcMult2(xs)
    return xs[1] * xs[2]
  end

  local myGA = GeneticAlgorithm.new(numChromosomes, genesRangeValues, probMutation, probCrossover, elitismSize, funcMult2)
  myGA.evolve(100)
  local optim = myGA.getBestChromosomes(1)

  print('Mult. sol.:'..optim[1][1]..','..optim[1][2])
  assert(optim[1][1] > 0.9)
  assert(optim[1][2] > 0.9)
end

------------------------------------------------------------------------------
function TestGA:test_SubtractExample()
  local numChromosomes = 10
  local genesRangeValues = {{0,1}, {0,1}}
  local probMutation = 0.1
  local probCrossover = 0.7
  local elitismSize = 3

  function funcSubtract2(xs)
    return xs[1] - xs[2]
  end

  local myGA = GeneticAlgorithm.new(numChromosomes, genesRangeValues, probMutation, probCrossover, elitismSize, funcSubtract2)
  myGA.evolve(100)
  local optim = myGA.getBestChromosomes(1)

  print('Subt. sol.:'..optim[1][1]..','..optim[1][2])
  assert(optim[1][1] > 0.9 and optim[1][2] < 0.1)
end

-- ------------------------------------------------------------------------------
-- example taken from: codeproject.com/Articles/3172/A-Simple-C-Genetic-Algorithm
function TestGA:test_FunctionManyPeaks()
  local numChromosomes = 100
  local genesRangeValues = {{0,1}, {0,1}}
  local probMutation = 0.05
  local probCrossover = 0.8
  local elitismSize = 10

  function funcManyPeaks(xs)
    return math.pow(15 * xs[1] * xs[2] * (1 - xs[1]) * (1 - xs[2]) * math.sin(9 * math.pi * xs[1]) * math.sin(9 * math.pi * xs[2]), 2)
  end

  local myGA = GeneticAlgorithm.new(numChromosomes, genesRangeValues, probMutation, probCrossover, elitismSize, funcManyPeaks)
  myGA.evolve(2000)
  local optim = myGA.getBestChromosomes(1)
  
  print('Func. with many peaks sol.'..optim[1][1]..','..optim[1][2])
  assert(optim[1][1] > 0.49 and optim[1][1] < 0.51)
  assert(optim[1][2] > 0.49 and optim[1][2] < 0.51)
end


-- ------------------------------------------------------------------------------
function TestGA:test_FourGenesExample()
  local numChromosomes = 100
  local genesRangeValues = {{0,1}, {0,1}, {0,1}, {0,1}}
  local probMutation = 0.05
  local probCrossover = 0.8
  local elitismSize = 30

  function funcFourGenes(xs)
    if xs[1] == nil or xs[2] == nil or xs[3] == nil or xs[4] == nil then
      print('error input pars to GA are nil')
      return 0
    end

    return xs[1] - xs[2] + xs[3] - xs[4]
  end

  local myGA = GeneticAlgorithm.new(numChromosomes, genesRangeValues, probMutation, probCrossover, elitismSize, funcFourGenes)
  myGA.evolve(100)
  local optim = myGA.getBestChromosomes(1)

  print('Many genes opt. sol.:'..optim[1][1]..','..optim[1][2]..','..optim[1][3]..','..optim[1][4])
  assert(optim[1][1] > 0.9)
  assert(optim[1][2] < 0.1)
  assert(optim[1][3] > 0.9)
  assert(optim[1][4] < 0.1)
end

-- ------------------------------------------------------------------------------
function TestGA:test_FiveGenesExample()
  local numChromosomes = 100
  local genesRangeValues = {{0,1}, {0,1}, {0,1}, {0,1}, {0,1}}
  local probMutation = 0.05
  local probCrossover = 0.8
  local elitismSize = 30

  function funcFiveGenes(xs)
    if xs[1] == nil or xs[2] == nil or xs[3] == nil or xs[4] == nil or xs[5] == nil then
      print('error input pars to GA are nil')
      return 0
    end

    return xs[1] - xs[2] + xs[3] - xs[4] + xs[5]
  end

  local myGA = GeneticAlgorithm.new(numChromosomes, genesRangeValues, probMutation, probCrossover, elitismSize, funcFiveGenes)
  myGA.evolve(100)
  local optim = myGA.getBestChromosomes(1)

  print('Many genes opt. sol.:'..optim[1][1]..','..optim[1][2]..','..optim[1][3]..','..optim[1][4]..','..optim[1][5])
  assert(optim[1][1] > 0.9)
  assert(optim[1][2] < 0.1)
  assert(optim[1][3] > 0.9)
  assert(optim[1][4] < 0.1)
  assert(optim[1][5] > 0.9)
end

-- ------------------------------------------------------------------------------
argv = {}
lu = LuaUnit.new()
lu:setOutputType("tap")
os.exit(lu:runSuite())
