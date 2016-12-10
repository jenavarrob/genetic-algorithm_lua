# geneticAlgorithm_lua

This project shows a simple implementation of genetic algorithm for finding the maximum of a given function.

## Genetic Algorithm (GA)

Evolutionary algorithms are computational methods to find optimal solutions based on evolution. In other words, this methods iteratively improve solutions applying biological evolutionary principles. Evolutionary algorithms relate to different methods like genetic algorithm, evolutionary strategies, genetic programming, etc. which use the same following evolutionary principles to obtain “good enough” solutions by:
  * creating a population of data structures that represent solutions
  * evolving populations by changing those solutions, combining them to create new ones, and, on average, 
  * making the better-suited survive and the worst-suited perish. 

Genetic algorithms (GAs) use the genetic operators selection, mutation, crossover and elitism. GAs were first introduced by John H. Holland in 1975. Sinde then, many researchers have made notably contributions to improve the theoretical foundations and applications of GAs. Among them, David Goldberg published in 1989 the book "Genetic Algorithms in search, optimization, and machine learning" and Zbigniew Michalewicz in 1998 published the book "Genetic Algorithms + Data Structures = Evolution Programs".
 
 GAs general methodology:
 1. Identification of a suitable representation scheme to solve the problem.
 2. Determine the fitness measure
 3. Determine the parameters and variables for controlling the algorithm, number of chromosomes (M), percentage of elitism (probability of reproduction pr), probabilities of crossover (pc) and mutation (pm), 
 4. Criterion for terminating the process: maximal number of generations (G) or threshold for convergence of the population

## GA lua-code



## How to run:
```
$ lua test_genetic_algorithm.lua 
1..6
# Started on Mon Dec  5 00:35:06 2016
# Starting class: TestGA
GA converged: 33 out of 100
Addition sol.:0.95222972517471,0.95971639592187
ok     1        TestGA.test_AdditionExample
Many genes opt. sol.:0.99939209269331,0.0026225773629838,0.99849518807535,0.00021617114553981,0.99677730211838
ok     2        TestGA.test_FiveGenesExample
Many genes opt. sol.:0.9982274319037,0.0026280647155959,0.99658994190236,0.0011837491771131
ok     3        TestGA.test_FourGenesExample
GA converged: 296 out of 2000
Func. with many peaks sol.0.50090982881417,0.50012778094976
ok     4        TestGA.test_FunctionManyPeaks
GA converged: 57 out of 100
Mult. sol.:0.99658286943873,0.97128472149898
ok     5        TestGA.test_MultiplyExample
GA converged: 39 out of 100
Subt. sol.:0.99454406136393,0.077648860438563
ok     6        TestGA.test_SubtractExample
# Ran 6 tests in 0.301 seconds, 6 successes, 0 failures
```
