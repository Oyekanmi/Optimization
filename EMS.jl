#Minimum cover EMS method
using JuMP,Gurobi

#define the model
m =Model(Gurobi.Optimizer)

#Let n represents the number of decision variables
n=10 

#declaring variables
@variable(m, x[1:n], Bin) # binary constraint 

#define the objective function
@objective(m , Min, sum(x[i] for i =1:n)) # objective is to minimize the coverage

#Since decision variables x2,x3,x8 and x10>=1, I declared them in a for-loop together
for i in [2,3,8,10]
	@constraint(m,x[i]>=1)    #(x[i] for i in [2,3,8,10]) >=1) 
end


#additional constraint
@constraint(m, x[1]+x[2]>=1)    #district 2
@constraint(m, x[1]+x[3]>=1)    #district 3
@constraint(m, x[2]+x[4]>=1)	#district 7
@constraint(m, x[3]+x[4]>=1)	#district 8
@constraint(m, x[4]+x[6]>=1)	#district 10
@constraint(m, x[4]+x[5]>=1)	#district 11
@constraint(m, x[4]+x[5]+x[7]>=1)	#distict 13
@constraint(m, x[4]+x[5]+x[6]>=1)	#distict 12
@constraint(m, x[8]+x[9]>=1)		#distict 14, district 18
@constraint(m, x[6]+x[9]>=1)		#distict 15
@constraint(m, x[5]+x[6]>=1)		#distict 16
@constraint(m, x[5]+x[7]+x[10]>=1)	#distict 17
@constraint(m, x[8]+x[10]>=1)		#distict 19

print(m)

#Printing the optimal solutions obtained
println("Optimal Solutions:")
status = JuMP.optimize!(m)
println(" Objective value: ",JuMP.objective_value(m))

println("Decision variable values:")
for i=1:10
  println("x[$i] = ",   JuMP.value(x[i]))
end
