# This code estimates multilevel models using the MixedModels package and saves the estimation times to disk

using Feather, DataFrames, BenchmarkTools, MixedModels

try
  cd("F:/Dropbox/Forskning/Software tests/Multilevel")
catch
  cd("C:/Users/adria/Dropbox/Forskning/Software tests/Multilevel")
end


# Define function to save time values from benchmark
function get_times(res, levels, data)
  # Put time values in array
  times = []
  for i = 1:length(res)
    push!(times, time(res[i]))
  end

  # Convert to seconds
  times = times / 1000000000

  # Put in data frame
  return DataFrame(time = times, data = data, levels = levels, package = "MixedModels")
end


# Read test data
df_s = Feather.read("data_small.feather", nullable = false)
df_m = Feather.read("data_medium.feather", nullable = false)
df_l = Feather.read("data_large.feather", nullable = false)

# Convert to dummy variables
pool!(df_s, [:by, :gender])
pool!(df_m, [:by, :gender])
pool!(df_l, [:by, :gender])

## Small ##

# Run 2-level test
result_ml2 = @benchmark lmm_ml2 = fit!(lmm(y ~ by + gender + (1 | id2), df_s)) samples = 10 seconds = 300

# Put in data frame
small2 = get_times(result_ml2, 2, "Small")

# Run 3-level test
result_ml3 = @benchmark lmm_ml3 = fit!(lmm(y ~ by + gender + (1 | id3) + (1 | id2), df_s)) samples = 10 seconds = 300

# Put in data frame
small3 = get_times(result_ml3, 3, "Small")


## Medium ##

# Run 2-level test
result_ml2 = @benchmark lmm_ml2 = fit!(lmm(y ~ by + gender + (1 | id2), df_m)) samples = 10 seconds = 300

# Put in data frame
medium2 = get_times(result_ml2, 2, "Medium")

# Run 3-level test
result_ml3 = @benchmark lmm_ml3 = fit!(lmm(y ~ by + gender + (1 | id3) + (1 | id2), df_m)) samples = 10 seconds = 300

# Put in data frame
medium3 = get_times(result_ml3, 3, "Medium")


## Large ##

# Run 2-level test
result_ml2 = @benchmark lmm_ml2 = fit!(lmm(y ~ by + gender + (1 | id2), df_l)) samples = 10 seconds = 300

# Put in data frame
large2 = get_times(result_ml2, 2, "Large")

# Run 3-level test
result_ml3 = @benchmark lmm_ml3 = fit!(lmm(y ~ by + gender + (1 | id3) + (1 | id2), df_l)) samples = 10 seconds = 300

# Put in data frame
large3 = get_times(result_ml3, 3, "Large")


# Put test results into common data frame
df = [small2;small3;medium2;medium3;large2;large3]

Feather.write("julia_test_data.feather", df)
