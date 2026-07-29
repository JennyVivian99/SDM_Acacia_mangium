# MaxEnt correlation variables
####Install required packages####
#install.packages("ENMeval")
#install.packages("dismo")
#install.packages("raster")
#install.packages("sp")
#install.packages("ecospat")
#install.packages("terra")

# Space allocation for big raster data
options(java.parameters = "-Xmx10g")

####Load packages####
library(ENMeval)
library(dismo)
library(raster)
library(sp)
library(ecospat)
library(terra)
library(ggplot2)
library(spThin)

####Environment preparation####
# Define the directory where the layer files are stored
# In this folder is located also MaxEnt
climate_data_dir <- "YOUR DIRECTORY"

# List all files in the directory
all_files <- list.files(climate_data_dir)
print(all_files)
# List TIFF files in the directory
files <- list.files(climate_data_dir, pattern="\\.tif$", full.names=TRUE)
# Check if any .tif files were found
if (length(files) == 0) {
  stop("No .tif files found in the specified directory.")
} else {
  print(files)
}

####Analysis environmental variables####
# Load all layers into a stack
future_bioclim_data <- stack(files)
# Convert layers into terra format for modelling
future_bioclim_data <- terra::rast(future_bioclim_data)
# Verify that the layers were loaded correctly
print(future_bioclim_data)


####Spatial modelling####
# Remember to set the directory
# Load occurrence data
occurrence_data <-read.csv("Acacia_mangium_occurrence.csv")
# Remove datapoints without occurrence
occurrence_data<-as.data.frame(na.omit(occurrence_data))
# Spatial thinning. spThin requires a column with the species name 
# We create a temporary one just in case your CSV doesn't have it.
occurrence_data$Species <- "Acacia_mangium"

# Run the thinning algorithm (Ensuring points are at least 50 km apart)
# Ensure "latitude" and "longitude" exactly match the column headers in the CSV
thinned_results <- thin(
  loc.data = occurrence_data, 
  lat.col = "latitude",      
  long.col = "longitude",    
  spec.col = "Species", 
  thin.par = 50,           # Distance in km (adjust this if you want a wider/narrower gap)
  reps = 1, 
  locs.thinned.list.return = TRUE, 
  write.files = FALSE, 
  write.log.file = FALSE
)

# Replace occurrence_data with the newly thinned dataset
occurrence_data <- thinned_results[[1]]

# spThin alters column names, so we reset them to match your original script
colnames(occurrence_data) <- c("longitude", "latitude")

# Print how many records were retained so you can report it in your paper
print(paste("Number of points after thinning:", nrow(occurrence_data)))

# Select only coordinates (spThin already limits to coordinates, but keeping for safety)
occurrence_data <- occurrence_data[, c("longitude", "latitude")]

# Select only coordinates
#occurrence_data <- occurrence_data[,2:3]

# Check the loaded occurrence data
head(occurrence_data)

# Convert occurrence data to a spatial points object
coordinates(occurrence_data) <- ~longitude+latitude

# Verify that occurrence points were correctly loaded
print(occurrence_data)

# Define Maxent model tuning arguments
tune.args <- list(
  fc = "LQ",
  rm = 1
)

# Check the number of background points available, must be way higher than 10 000 to use 10 000 as background points
length(which(!is.na(values(subset(future_bioclim_data,1)))))

# Configure and run the model with ENMeval
#eval_results <- ENMevaluate(
#occs = occurrence_data, 
#envs = climate_layers, 
#partitions = "block", 
#tune.args = tune.args, 
#algorithm = "maxent.jar"
#)

# If still memory problems, try:
eval_results <- ENMevaluate(
  occs = occurrence_data,
  envs = future_bioclim_data,
  partitions = "block",
  tune.args = tune.args,
  algorithm = "maxnet"
)

# See the best retained result
res <- eval.results(eval_results)
model_evaluation<-eval.models(eval_results)

# Visualize
res
model_evaluation
plot(eval_results@predictions,  background="black")

# View the results table
results_df <- eval_results@results
results_df
