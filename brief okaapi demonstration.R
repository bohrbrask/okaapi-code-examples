



###### BRIEF OKAAPI DEMONSTRATION


# This code gives a brief demonstration of how to use the two main functions in the okaapi package.

# The 'traitnet' function generates and visualizes a single trait preference network.
# The 'traitnetsmetrics' function generates a set of trait preference networks and measures network metrics on them.

# The code accompanies the paper
# 'okaapi: an R package for generating social networks based on trait preferences'.

# For more information about the function and the package (including more extensive code examples), 
# see the above paper and the function help pages.


# Contact: Josefine Bohr Brask (bohrbrask@gmail.com)







##### INSTALL THE PACKAGE #####


# To install the package, first install the 'remotes' or 'devtools' package (if you don't have them already).

# Then we can install the package by running the following code:

install_github("bohrbrask/okaapibeta")







##### LOAD THE PACKAGE #####


# We load the package:

library(okaapibeta)







##### CREATE AND VISUALIZE A NETWORK WITH THE TRAINET FUNCTION #####


# To create and visualize a single network, we can use the traitnet function. 



### Check the function help page ####

# To familiarize ourselves with the function and make sure we use it correctly, we first take a look at the function help page.
# Among other things, we can here see the options and criteria for the parameters (function arguments).

?traitnet



### Set the function arguments ####

# We then set all the parameters (function arguments).

# For convenience, we create all the arguments before using them in the function.
# We could alternatively set the arguments within the function call below,
# but having them separately like this is convenient, as it is easier to change them here
# than in the parenthesis, and we can keep this part at the top of our script for easy access.

# We here make a network that is based on two trait preferences:
# similarity preferences for a categorical trait with two categories (such as preference for socializing with own sex)
# and popularity preference for a normally distributed trait (such as preference for socializing with individuals of large body size).

# We make sure that arguments that contain multiple values all have them in the same order.
# That is, the values at the first place all have to do with the same trait preference.

n <- 100                           # number of individuals (nodes)
k <- 10                            # average degree (average number of links per node)
traittypes <- c('cate', 'tnorm')   # trait types 
allncats <- c(2,NA)                # number of categories for categorical traits (NA for non-categorical traits)
preftypes<- c('sim', 'pop')        # preference types
linktype <- 'stow'                 # link type 
wvals <- c(0.70, 0.30)             # importance of each trait preference 
onecomp <- TRUE                    # whether the network should necessarily consist of a single component
visnet <- TRUE                     # whether the network should be visualized



### Generate the network ####

# To generate a network, we run the traitnet function and save the output in a variable, 
# which we have here called 'traitnetoutput'.

traitnetoutput <- traitnet(n=n, k=k, traittypes=traittypes, allncats=allncats, preftypes=preftypes, linktype=linktype, wvals=wvals, onecomp=onecomp, visnet=visnet)



### View the network plot ####

# We can see the network visualization in the Plots window.



### Extract and view the function output ####

# The traitnet function outputs the network matrix, as well as the trait values for all the individuals,
# and the social attraction values of all pairs (explained in the reference above). The output is given in a list.

# It can be convenient to extract the network matrix from the output and save it in a separate variable:

netmat <- traitnetoutput$net

# Let us have a look at the network matrix:

View(netmat)

# We can extract and view the other output in a similar way:

traitvalues <- traitnetoutput$traitvals
View(traitvalues)

sociatvalues <- traitnetoutput$sociatvals
View(sociatvalues)



### Create a network with user-provided trait values ####

# Instead of letting okaapi generate trait values (as we did above), 
# we can input our own (which could be from a real-world population or simulated).
# A demonstration of how to do this is included in the code with more extensive examples.







##### MEASURE NETWORK METRICS ON A SET OF NETWORKS WITH THE TRAITNETSMETRICS FUNCTION #####


# To create a set of networks and measure their structure, we use the traitnetsmetrics function. 



### Check the function help page ####

# To familiarize ourselves with the function and make sure we use it correctly, we first take a look at the function help page.
# Among other things, we can here see the options and criteria for the function arguments (parameters).

?traitnetsmetrics



### Set the function arguments ####

# We then set all the function arguments (parameters).

# We make networks based on the same trait preferences as above,
# and we again set the arguments outside of the function call for convenience.

n <- 100                           # number of individuals (network nodes)
k <- 10                            # average degree (average number of links per node)
traittypes <- c('cate', 'tnorm')   # trait types 
allncats <- c(2,NA)                # number of categories for categorical traits (NA for non-categorical traits)
preftypes<- c('sim', 'pop')        # preference types
linktype <- 'stow'                 # link type 
wvals <- c(0.00,0.95)              # importance of each trait preference
onecomp <- TRUE                    # whether the network should necessarily consist of a single component
nrepls <- 100                      # number of networks to be generated
metrics <- c('clust', 'path', 'degassort','degvar')    # network metrics to be measured



### Generate the networks and measure their structure ####

# To generate the networks and measure their structure, 
# we run the traitnetsmetrics function and save the output in a variable, 
# which we have here called 'metricsoutput'.

# Note: for practical reasons, the network matrices are not kept; 
# only the metric measurements are given as output.

metricsoutput <- traitnetsmetrics(n=n, k=k, traittypes=traittypes, allncats=allncats, preftypes=preftypes, linktype=linktype, wvals=wvals, onecomp=onecomp, nrepls=nrepls, metrics=metrics)



### View the function output ####

# The output consists of a matrix with the metric values.

# Let us take a look at the measured metric values:

View(metricsoutput)

# Usually we would probably want to compare our results to those of a set of networks 
# generated with other settings (such as random networks) and plot the results together.
# See the more extensive examples in the above-mentioned paper for how to do that.






