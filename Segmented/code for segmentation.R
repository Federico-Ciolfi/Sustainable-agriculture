# create a linear model

my.lm <- lm(PST ~ year, data = Data)
summary(my.lm)


# Extract the coefficients from the overall model
my.coef <- coef(my.lm)

library(segmented)

# have to provide estimates for breakpoints.
# after looking a the data, 
my.seg <- segmented(my.lm, 
                    seg.Z = ~ year, 
                    psi = list(year = c(1986, 1993,2005,2015))) # Modify according to transition

# display the summary
summary(my.seg)

# get the breakpoints
my.seg$psi

# get the slopes
slope(my.seg)

# get the fitted data
my.fitted <- fitted(my.seg)
my.model <- data.frame(year = Data$year, PST = my.fitted)

# plot the fitted model
data <- ggplot(Data, aes(x = year, y = PST)) + geom_line() + ggtitle("Data") + theme(plot.title = element_text(hjust = 0.5))
model <- ggplot(my.model, aes(x = year, y = PST)) + geom_line() + ggtitle("Fitted model") + theme(plot.title = element_text(hjust = 0.5))

ggarrange(data, model,  ncol = 1)

