



###### EXAMPLES OF HOW TO USE THE OKAAPI PACKAGE 


# This code contains examples of how to use the 'okaapi' R package.

# The code accompanies the paper 'okaapi: an R package for generating social networks based on trait preferences'.

# For further details about the examples, see the examples section in the paper.
# For simple examples of how to use the functions, see the 'brief okaapi demonstration' code and the function help pages.

# Contact: Josefine Bohr Brask (bohrbrask@gmail.com).



### Trait preferences used in the examples 


# For the examples, we focus on two trait preferences: 


# Preference for socializing with one's own sex 

  # We model this by a similarity preference combined with a categorical trait with two categories. 
  # We refer to it as the 'sex similarity preference'.

# Preference for socializing with individuals that have a large body size

  # We model this by a popularity preference combined with a continuous, normally distributed trait. 
  # We refer to it as the 'size popularity preference'.







##### CODE #####################################################################


# First we load the package.

library(okaapibeta)







#### EXAMPLE: VISUAL EXPLORATION OF TRAIT PREFERENCE NETWORKS #####


# In this example, we show how to use the okaapi package to explore trait preference networks visually.

# We want to visualize networks that are based on the two trait preferences of interest, 
# both when the preferences act together and separately.

# We can do this with the traitnet function.

# Our approach is to use the function with both preferences, and then just set the importance of one of them to zero,
# when we want to explore the effect of the other alone. This is more convenient than writing the function call multiple times.



### Function help page ###

# To familiarize ourselves with the function and make sure we set the arguments correctly, we first look at the function help page.

?traitnet


### Parameter settings ###

# We then set all the parameters (the function arguments).


## We use the wvals argument to set the importance of the two preferences.

# We can change the importance values again and again, to explore networks that are
# based on either preference separately or on the two preferences in different ratios. 

# For example:
# For networks that are strongly driven by only one of the preferences, we can set one number to 0 and the other to 0.99.
# For networks that are based on the two preferences with equal importance, we could set the two numbers to the same value, such as 0.5.

wvals <- c(0.5,0.5)                  


## We set the other trait preference parameters to fit with our two trait preferences of interest.

# These arguments need to contain two values each, because we are using two trait preferences.
# We make sure to put the entries in the same order for all the arguments.
# We choose to put the information concerning the sex similarity preference first, 
# and the information concerning the size popularity preference second.

traittypes <- c('cate', 'tnorm')   # We set the trait types to one categorical and one normally distributed trait.
allncats <- c(2,NA)                # We set the number of categories to two for the categorical trait, and to NA for the normally distributed (non-categorical) trait.
preftypes<- c('sim', 'pop')        # We set the trait types to similarity for the categorical trait, and to popularity for the normally distributed trait.


# We set the rest of the parameters to convenient values.

n <- 100                           # We set the number of individuals (network nodes) to 100.
k <- 10                            # We set the average degree (average number of links per individual) to 10.
linktype <- 'unw'                  # We set set the link type to unweighted.
onecomp <- TRUE                    # We set the component argument to TRUE, so that the network will necessarily have only one component.
visnet <- TRUE                     # We set the visualization argument to TRUE, so that we will get a plot of the network.



### Network generation ###

# To create a network, we call the function, using our set parameters.

# We can see the network plot in the Plots window.

traitnet(n=n, k=k, traittypes=traittypes, allncats=allncats, preftypes=preftypes, linktype=linktype, wvals=wvals, onecomp=onecomp, visnet=visnet)


# To create a network based on different importance settings for the trait preferences,
# we can change the numbers in the wvals argument above and run the code again.







#### EXAMPLE: MEASURING STRUCTURAL ASPECTS OF TRAIT PREFERENCE NETWORKS WITH METRICS THAT ARE AVAILABLE IN OKAAPI ####


# In this example, we show how to use the okaapi package to measure properties of trait preference networks 
# with metrics that are currently available in the package.

# We want to measure structural aspects of network ensembles, using network metrics that are available in the okaapi package.

# We can do this with the traitnetsmetrics function.

# We want to measure metrics on four network ensembles: 

  # One with networks based on the sex similarity preference
  # One with networks based on the size popularity preference
  # One with networks based on both preferences together
  # One with networks based on no preferences, i.e. random networks (for comparison)

# Our approach is to use a loop that loops over the four ensembles, so that we avoid writing similar code four times.

# For a simpler example of how to use the traitnetsmetrics function (measuring metrics on a single ensemble),
# see the 'brief okaapi demonstration' R code.



### Function help page ###

# To familiarize ourselves with the function and make sure we set the arguments correctly, we first look at the function help page.

?traitnetsmetrics



### Parameter settings ###

# We then set all the parameters (function arguments).

# The four ensembles differ only in their importance parameter settings (the wvals argument).
# Instead of the normal wvals argument, we therefore make a matrix with all the wvals for the four ensembles, which we can loop over.

allwvals <- matrix(c(0,0.98,0, 0.5, 0, 0, 0.98, 0.5), nrow = 4) # A matrix with all our wvals for the four ensembles together.
colnames(allwvals) = c('sim', 'pop') # Column names for the matrix.


## We set the other trait preference parameters to fit with our two trait preferences of interest.

# These arguments need to contain two values each, because we are using two trait preferences.
# We make sure that we put the entries in the same order for all the arguments,
# and that the order is the same that we used for the allwvals matrix 
# (i.e. information about the sex similarity preference goes first).

traittypes <- c('cate', 'tnorm')   # We set the trait types to one categorical and one normally distributed trait.
allncats <- c(2,NA)                # We set the number of categories to two for the categorical trait, and to NA for the normally distributed (non-categorical) trait.
preftypes<- c('sim', 'pop')        # We set the trait types to similarity for the categorical trait, and to popularity for the normally distributed trait.


# We set the rest of the parameters to convenient values.

n <- 100                                   # We set the number of individuals (network nodes) to 100.
k <- 10                                    # We set the average degree (average number of links per individual) to 10.
linktype <- 'unw'                          # We set set the link type to unweighted.
onecomp <- TRUE                            # We set the component argument to TRUE, so that the network will necessarily have only one component.
nrepls <- 1000                             # we set the number of replicates (networks) in each ensemble to 1000.
metrics <- c('clust', 'path', 'degassort') # we set the metrics that we want to be measured (clustering, path length, degree assortativity).



### metric measurements ###

# We now measure the network metrics on the four ensembles with a loop.

# First we create some things that we need before looping.

nensemble <- nrow(allwvals) # the number of ensembles
nmetrics <- length(metrics) # the number of metrics
ensemblenames <- c('none','sim', 'pop', 'both') # a vector with names for the four ensembles
metricsresults <- matrix(NA, nrow = nensemble*nrepls, ncol = nmetrics) # storage for the results

# Then we loop over the four ensembles and store the measurements.

# This may take a minute or so. We can keep track of the progress with the 
# replication numbers that are shown in the console.

curplace <- 1 # counter to keep track of where we are in the storage matrix
for (curensemble in 1:nensemble){ # for each ensemble...
  curwvals <- allwvals[curensemble,] # get the wvals of the current ensemble
  metricsoutput <- traitnetsmetrics(n=n,k=k,traittypes=traittypes,allncats=allncats,preftypes=preftypes,linktype=linktype,wvals=curwvals, onecomp=onecomp,nrepls=nrepls,metrics=metrics) # measure metrics on the ensemble
  metricsresults[curplace:(curplace+999), 1:nmetrics]<- metricsoutput # store the metric measurements of the ensemble
  curplace <- curplace + 1000 # update the counter
} # end the loop



### plot ###

# Finally, we make a plot of the metric measurements.

# For convenience, we make a name translator that we can use to get the full names of the network metrics,
# so we can easily use them for the plotting instead of the short names.

namesbrief <- c('clust', 'clustw','path','pathw','avdeg','avdegw','degassort','degassortw','degvar','degvarw')
namesfull <- c('clustering', 'weighted clustering','path length','weighted path length','average degree','weighted average degree','degree assortativity','weighted degree assortativity','degree variation','weighted degree variation')
nametranslator <- namesfull
names(nametranslator)<- namesbrief

# Then we make the plot.

preferences <- rep(ensemblenames,each = nrepls) # data on which ensemble the measurements belong to
preferences <- factor(preferences, levels = ensemblenames) # to get the boxes plotted in the order we want
plotcols <- c('grey','darkseagreen3', 'steelblue4', 'paleturquoise2') #colours for the plot
par(mfrow=c(1,nmetrics)) # plot layout
for (plotn in 1:nmetrics){ # loop over the four metrics to make the plot
  boxplot(metricsresults[,plotn]~preferences, main = nametranslator[metrics[plotn]], ylab = nametranslator[metrics[plotn]], col = plotcols, cex.main = 1.4, cex.lab = 1.3, cex.axis = 1.3) # draw boxplots
} # end plot loop
par(mfrow = c(1, 1)) # reset plot layout







#### EXAMPLE: MEASURING PROPERTIES OF TRAIT PREFERENCE NETWORKS WITH MEASURES THAT ARE NOT AVAILABLE IN OKAAPI ####


# Note, for this example you need to have the R package 'igraph' installed.


# In this example, we show how to use the okaapi package to measure properties of trait preference networks 
# with measures that are currently NOT available in the package.

# Here, we measure the modularity of network ensembles.
# We could use an approach similar to the below for other network properties that are not available in the package.

# We want to measure modularity on the following four network ensembles (the same as in the above example):

  # One with networks based on the sex similarity preference
  # One with networks based on the size popularity preference
  # One with networks based on both preferences together
  # One with networks based on no preferences, i.e. random networks (for comparison)

# Above, we used the traitnetsmetrics function to measure metrics on network ensembles, 
# but modularity is currently not available as a metric in the traitnetsmetrics function.
# Instead of using that function, our approach is therefore to use the traitnets function to generate networks, 
# and use a function from the igraph package to measure modularity.

# To measure modularity on the four ensembles, we use two nested loops:
# The inner one loops over the replicates in an ensemble (in each round it generates a network and measures its modularity),
# and the outer one loops over the four ensembles.



### Function help page ###

# To familiarize ourselves with the function and make sure we set the arguments correctly, we first look at the function help page.

?traitnet



### Parameter settings ###

# We then set all the parameters (the function arguments).

# As in the above example, we need a loop that loops over the four network ensembles.
# The four ensembles differ only in their importance settings (the wvals argument).
# Instead of the normal wvals argument, we therefore make a matrix with all the wvals for the four ensembles, which we can loop over.

allwvals <- matrix(c(0,0.98,0, 0.5, 0, 0, 0.98, 0.5), nrow = 4) # A matrix with all our wvals for the four ensembles together.
colnames(allwvals) = c('sim', 'pop') # Column names for the matrix.


## We set the other trait preference parameters to fit with our two trait preferences of interest.

# These arguments need to contain two values each, because we are using two trait preferences.
# We make sure that we put the entries in the same order for all the arguments,
# and that the order is the same that we used for the allwvals matrix 
# (i.e. information about the sex similarity preference goes first).

traittypes <- c('cate', 'tnorm')   # We set the trait types to one categorical and one normally distributed trait.
allncats <- c(2,NA)                # We set the number of categories to two for the categorical trait, and to NA for the normally distributed (non-categorical) trait.
preftypes<- c('sim', 'pop')        # We set the trait types to similarity for the categorical trait, and to popularity for the normally distributed trait.


# We set the rest of the parameters for the traitnet function to convenient values.

n <- 100              # We set the number of individuals (network nodes) to 100.
k <- 10               # We set the average degree (average number of links per individual) to 10.
linktype <- 'unw'     # We set set the link type to unweighted.
onecomp <- TRUE       # We set the component argument to TRUE, so that the network will necessarily have only one component.
visnet <- FALSE       # We set the network visualization to FALSE, as we do not want all the network replicates to be plotted.


# We also set the number of replicates in each ensemble.

nrepls <- 1000       # we set the number of replicates (networks) in each ensemble to 1000.



### Modularity measurement ###

# We now measure the modularity on the four ensembles with a douple loop.


# First we create some things that we need before looping.

library(igraph) # load the igraph package
nensemble <- nrow(allwvals) # the number of ensembles
ensemblenames <- c('none','sim', 'pop', 'both') # names of the four ensembles
modresults <- rep(NA, nrow = nensemble*nrepls) # storage for the modularity measurement results


# Then we measure the modularity of all the network replicates in the four ensembles.

curplace <- 1 # counter to keep track of where we are in the storage

for (curensemble in 1:nensemble){ # for each ensemble...
  
  curwvals <- allwvals[curensemble,] # get the wvals of the current ensemble
  modcurensemble <- rep(NA, nrepls)  # storage for modularity measurements of the current ensemble
  
  for (currepl in 1:nrepls){ # for each replicate (each network)...
    
    print(currepl) # write the current replicate number to the console to keep track of the progress
    
    traitnetoutput <- traitnet(n,k,traittypes,allncats,preftypes,linktype,wvals = curwvals,onecomp,visnet) # generate a network
    net <- traitnetoutput$net # get the network matrix from the traitnet output
    netigraph <- graph_from_adjacency_matrix(net, mode = 'undirected', diag = FALSE) # make an igraph version of the network
    modcurrepl <- modularity(cluster_louvain(netigraph)) # measure the modularity of the network
    modcurensemble[currepl] <- modcurrepl # store the modularity
    
  } # end the current replicate
  
  modresults[curplace:(curplace+999)]<- modcurensemble # store the modularity measurements of the current ensemble
  curplace <- curplace + 1000 # update the counter
  
} # end the current ensemble



### Plot  ###

# Finally, we make a plot of the modularity measurements.

preferences <- rep(ensemblenames,each = nrepls) # data on which ensemble the measurements belong to
preferences <- factor(preferences, levels = ensemblenames) # to get the boxes plotted in the order we want
plotcols <- c('grey','darkseagreen3', 'steelblue4', 'paleturquoise2') # colours for the plot
boxplot(modresults~preferences, main = 'modularity', ylab = 'modularity', col = plotcols, cex.main = 1.4, cex.lab = 1.3, cex.axis = 1.3) # draw boxplot







#### EXAMPLE: MEASURING STRUCTURAL ASPECTS OF TRAIT PREFERENCE NETWORKS USING USER-PROVIDED TRAIT VALUES ####


# In this example, we show how to use the okaapi package to measure properties of trait preference networks 
# with metrics that are currently available in the package, using user-provided trait values.

# As above, we want to measure structural aspects of network ensembles.

# We can do this with the traitnetsmetrics function.

# We want to measure metrics on four network ensembles: 

  # One with networks based on the sex similarity preference
  # One with networks based on the size popularity preference
  # One with networks based on both preferences together
  # One with networks based on no preferences, i.e. random networks (for comparison)

# Our approach is to use a loop that loops over the four ensembles, so that we avoid writing similar code four times.

# For a simpler example of how to use the traitnetsmetrics function (measuring metrics on a single ensemble),
# see the 'brief okaapi demonstration' R code.



### Function help page ###

# To familiarize ourselves with the function and make sure we set the arguments correctly, we first look at the function help page.

?traitnetsmetrics



### trait values ###

# We then make the trait values.
# (With trait values from real data, we would load them in and transform them to the required scales, which are described in the function help file).

nindis <- 105 # number of individuals
sexes <- sample(2,nindis, replace = TRUE, prob = c(0.25,0.75)) # sex values
bodysizes <- truncnorm::rtruncnorm(nindis, a = 0, b = 1, mean = 0.5, 0.25) # body size values
alltraitvals <- cbind(sexes, bodysizes) # all the trait values together



### Parameter settings ###

# We then set all the parameters (the function arguments).


# The four ensembles differ only in their importance settings (the wvals argument).
# Instead of the normal wvals argument, we therefore make a matrix with all the wvals for the four ensembles, which we can loop over.

allwvals <- matrix(c(0,0.98,0, 0.5, 0, 0, 0.98, 0.5), nrow = 4) # a matrix with all our wvals for the four ensembles together.
colnames(allwvals) = c('sim', 'pop') # column names for the matrix.


# We set all the other parameters.

# We input our trait values via the 'owntraitvals' argument, 
# and we set the 'owntraitclasses', 'traittypes', 'allncats' and 'n' arguments to fit with our input traits.

# We make sure that we put the entries in the same order for all the arguments that contain values for the two trait preferences,
# and that the order is the same that we used for the allwvals matrix and the alltraitvals matrix
# (i.e. information about the sex similarity preference goes first).

owntraitvals <- alltraitvals          # We input our traitvalues.
traittypes <- c('own', 'own')         # We set the trait type to 'own' for both traits, because we use our own traitvalues for both traits.        
owntraitclasses = c('cate', 'cont')   # To provide information on the classes of our two input traits (the first is categorical, the second is continuous).
allncats <- c(2,NA)                   # We set the number of categories to fit with our two input traits.
n <- 105                              # We set the number of individuals (network nodes) so that it fits with the number of trait values that we input.


# We set the preference types to fit with our two trait preferences of interest.

preftypes<- c('sim', 'pop')     # We set the trait types to similarity for the categorical trait, and to popularity for the normally distributed trait.


# We set the rest of the parameters to convenient values.

k <- 10                                    # We set the average degree (average number of links per individual) to 10.
linktype <- 'unw'                          # We set set the link type to unweighted.
onecomp <- TRUE                            # We set the component argument to TRUE, so that the network will necessarily have only one component.
nrepls <- 1000                             # we set the number of replicates (networks) in each ensemble to 1000.
metrics <- c('clust', 'path', 'degassort') # we set the metrics that we want to be measured (clustering, path length, degree assortativity).



### Metric measurements ###

# We now measure the network metrics on the four ensembles with a loop.

# First we create some things that we need before looping.

nensemble <- nrow(allwvals) # the number of ensembles
nmetrics <- length(metrics) # the number of metrics
ensemblenames <- c('none','sim', 'pop', 'both') # names of the four ensembles
metricsresults <- matrix(NA, nrow = nensemble*nrepls, ncol = nmetrics) # storage for the metric results

# Then we loop over the four ensembles and store the measurements.

# This may take a minute or so. We can keep track of the progress with the 
# replication numbers that are shown in the console.

curplace <- 1 # counter to keep track of where we are in the storage matrix
for (curensemble in 1:nensemble){ # for each ensemble...
  curwvals <- allwvals[curensemble,] # get the wvals of the current ensemble
  metricsoutput <- traitnetsmetrics(n=n,k=k,traittypes=traittypes, allncats=allncats, preftypes=preftypes, linktype=linktype, wvals=curwvals, onecomp=onecomp, nrepls=nrepls, metrics=metrics, owntraitclasses=owntraitclasses, owntraitvals=owntraitvals) # measure metrics on the ensemble
  metricsresults[curplace:(curplace+999), 1:nmetrics]<- metricsoutput # store the metric measurements of the ensemble
  curplace <- curplace + 1000 # update the counter
} # end the loop



### plot ###

# Finally, we make a plot of the metric measurements.

# For convenience, we make a name translator that we can use to get the full names of the network metrics,
# so we can easily use them for the plotting instead of the short names.

namesbrief <- c('clust', 'clustw','path','pathw','avdeg','avdegw','degassort','degassortw','degvar','degvarw')
namesfull <- c('clustering', 'weighted clustering','path length','weighted path length','average degree','weighted average degree','degree assortativity','weighted degree assortativity','degree variation','weighted degree variation')
nametranslator <- namesfull
names(nametranslator)<- namesbrief


# Then we make the plot.

preferences <- rep(ensemblenames,each = nrepls) # data on which ensemble the measurements belong to
preferences <- factor(preferences, levels = ensemblenames) # to get the boxes plotted in the order we want
plotcols <- c('grey','darkseagreen3', 'steelblue4', 'paleturquoise2')# colours for the plot
par(mfrow=c(1,nmetrics)) # plot layout
for (plotn in 1:nmetrics){ # loop over the four metrics to make the plot
  boxplot(metricsresults[,plotn]~preferences, main = nametranslator[metrics[plotn]], ylab = nametranslator[metrics[plotn]], col = plotcols, cex.main = 1.4, cex.lab = 1.3, cex.axis = 1.3) # draw boxplots
} # end plot loop
par(mfrow = c(1, 1)) # reset plot layout










