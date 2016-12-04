#!/usr/bin/lua
-- ---------------------------------------------------------------- -*- Lua -*-
--$LastChangedDate: 2016-03-15 14:46:14 +0100 (Di, 15 Mär 2016) $
--$LastChangedBy: jesus $
--
-- ------------------------------------------------------------------------------

require('utils')

GeneticAlgorithm = {}

-- -----------------------------------------------------------------------------
GeneticAlgorithm.new = function(numChromosomes, rangeValues, probMutation, probCrossover, elitismSize, fn)
  local _convergenceThres = 0.01  
  local _fitnessFunction = fn
  local _genesRangeValues = rangeValues
  local _numChromosomes = numChromosomes

  local _elitismSize  = elitismSize
  if _elitismSize > _numChromosomes then
    print('elitism size equals the number of chromosomes, the same chromosomes will be kept over generations!')
    _elitismSize = _numChromosomes  
  end

  local _numGenes = Table.count(rangeValues)
  local _probMutation = probMutation
  local _probCrossover = probCrossover  
  local _numChildren = 2 -- 2 parents -> 2 children

  local _chromosomes = Table.getMinMaxRandomTable(_genesRangeValues, _numChromosomes)
  if _chromosomes == nil then return nil end
  local _fitness = {}
  local _prevSumFitness = 0

  --math.randomseed( os.time() ) -- Initialize the pseudo random number generator

  -- ...........................................................................
  local api = {}

  api.evolve = function(numGenerations)
    for countGenerations = 1, numGenerations do      
      --initialize new population
      local newChromosomes = {}      

      -- get the fitness of the current population
      _fitness = computeFitness(_chromosomes)
      local mySortedIndex = Table.getKeysSortedByValue1D(_fitness, function(a, b) return b < a end)    

      --check for convergence of the GA
      local sum = Table.reduce(_fitness,
        function (a, b)
          return a + b
        end)
      if math.abs(_prevSumFitness - sum) < _convergenceThres then
        print('GA converged: '..countGenerations..' out of '..numGenerations)        
        break
      else
        _prevSumFitness = sum
      end

      --apply elitism   
      for i=1, _elitismSize do
        table.insert(newChromosomes, _chromosomes[mySortedIndex[i]])        
      end

      --fill out new population with new solutions applying genetic operators crossover and mutation
      while true do
        -- tournament selection
        local chroms = doTournamentSelection()

        local newChroms = doCrossover(chroms)

        for _,chrom in pairs(newChroms) do
          doMutation(chrom)
          table.insert(newChromosomes, chrom)
          if Table.count(newChromosomes) == _numChromosomes then
            goto stop
          end
        end
        ::nextChroms::
      end

      ::stop::
      for j=1, _numChromosomes do
        _chromosomes[j] = newChromosomes[j]
      end
    end
  end

-- ...........................................................................
  api.getBestChromosomes = function(numBestChromosomes)
    _fitness = computeFitness(_chromosomes)
    local mySortedIndex = Table.getKeysSortedByValue1D(_fitness, function(a, b) return b < a end)

    if numBestChromosomes > _numChromosomes then 
      numBestChromosomes = _numChromosomes
    end

    local topChromosomes = {}
    for i=1, numBestChromosomes do
      topChromosomes[i] = _chromosomes[mySortedIndex[i]]
    end    

    return topChromosomes
  end

-- ...........................................................................
  function computeFitness(chromos)    
    local fitness = {}
    for k,v in pairs(chromos) do
      fitness[k] = _fitnessFunction(v)
    end
    return fitness
  end

-- ...........................................................................
  function doCrossover(chroms)          
    local newChroms = {}
    if math.random() < _probCrossover then      
      local startPos = 1      
      local endPos = math.random(1,_numGenes-1)

      local ini = endPos + 1
      local fini = (_numGenes - startPos) + 1

      if math.random() > 0.5 then --right part
        ini = startPos
        fini = endPos
        startPos = endPos + 1
        endPos = _numGenes      
      end

      local keys = {}
      for key, chrom in pairs(chroms) do
        table.insert(keys, key)
      end

      for i = 1, _numChildren do
        newChroms[i] = {}
        for j = ini, fini do
          newChroms[i][j] = chroms[keys[i]][j]
        end
      end

      for i = 1, (_numChildren - 1) do
        local j = i +1        
        for k = startPos, endPos do
          newChroms[j][k] = chroms[keys[i]][k]        
          newChroms[i][k] = chroms[keys[j]][k]
        end
      end
      return newChroms
    end
    return chroms
  end

-- ...........................................................................
  function doMutation(chrom1)
    local isTrue = false
    for k,v in ipairs(_genesRangeValues) do
      if math.random() < _probMutation then
        isTrue = true
        chrom1[k] = math.random() * (v[2] - v[1]) + v[1]
      end
    end
    return isTrue
  end
-- ...........................................................................
  function doTournamentSelection()    
    local chs = {}

    repeat      
      local allDifferent = true

      for i=1, _numChildren do      
        local index, chrom = getRandomBestChromosome()
        if chs[index] then 
          allDifferent = false       
          break
        else
          chs[index] = chrom
        end
      end            
    until allDifferent

    return chs
  end

  -- ...........................................................................
  function getRandomBestChromosome()    
    local rindex1 = math.random(1,_numChromosomes)
    local rindex2 = math.random(1,_numChromosomes)

    if _fitness[rindex1] > _fitness[rindex2] then
      return rindex1, _chromosomes[rindex1]
    else
      return rindex2, _chromosomes[rindex2]
    end
  end

  return api
end

--end of class Genetic Algorithm