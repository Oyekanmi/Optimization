#Maximum Compatibility Pairing 
using JuMP,Gurobi

#define the model
m =Model(Gurobi.Optimizer)

#Let n represents the number of cities to be paired
n=4   

#declaring variables
@variable(m, x[1:n,1:n]>=0)

#define the compatibility coefficients 
c =   [	80 65 83 77;
	54 87 61 66 ;
	92 45 53 59 ; 
	70 61 81 76 ]

#define the objective function
@objective(m, Max, sum(c[i,j]* x[i,j] for i in 1:n for j in 1: n)) #objective is to maximize total compatibility pairing

#define constraints
for j = 1: n
  @constraint(m ,sum(x[i,j] for i in 1: n) ==1)
end

for i = 1: n
  @constraint(m ,sum(x[i,j] for j in 1: n) ==1 )
end

print(m)

#Printing the optimal solutions obtained
println("Optimal Solutions:")
status = JuMP.optimize!(m)
println(" Objective value: ",JuMP.objective_value(m))

println("Decision variable values:")
println("x = ", JuMP.value.(x))
