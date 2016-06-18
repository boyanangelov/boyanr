library(ggplot2)
require(gridExtra)
library(ggthemes)

outliersDetect <- function(dt, var) {
  var_name <- eval(substitute(var),eval(dt))
  tot <- sum(!is.na(var_name))
  na1 <- sum(is.na(var_name))
  m1 <- mean(var_name, na.rm = T)

  plot1 <- ggplot(dt, aes(factor(1), var_name)) +
    geom_boxplot() +
    ggtitle("With outliers") +
    ylab("Variable") +
    theme(axis.title.x=element_blank(), axis.text.x=element_blank()) +
    theme_fivethirtyeight()

  plot2 <- ggplot(dt, aes(x = var_name)) +
    geom_histogram() +
    ggtitle("With outliers") +
    theme(axis.title.x=element_blank()) +
    theme_fivethirtyeight()

  outlier <- boxplot.stats(var_name)$out
  mo <- mean(outlier)
  var_name2 <- ifelse(var_name %in% outlier, NA, var_name)

  plot3 <- ggplot(dt, aes(factor(1), var_name2)) +
    geom_boxplot() +
    ggtitle("Without outliers") +
    ylab("Variable") +
    theme(axis.title.x=element_blank(), axis.text.x=element_blank()) +
    theme_fivethirtyeight()

  plot4 <- ggplot(dt, aes(x = var_name2)) +
    geom_histogram() +
    ggtitle("Without outliers") +
    theme(axis.title.x=element_blank()) +
    theme_fivethirtyeight()

  grid.arrange(plot1, plot2, plot3, plot4, ncol = 2)

  na2 <- sum(is.na(var_name2))
  cat("Outliers identified:", na2 - na1, "\n")
  cat("Propotion (%) of outliers:", round((na2 - na1) / tot*100, 1), "\n")
  cat("Mean of the outliers:", round(mo, 2), "\n")
  m2 <- mean(var_name2, na.rm = T)
  cat("Mean without removing outliers:", round(m1, 2), "\n")
  cat("Mean if we remove outliers:", round(m2, 2), "\n")
  response <- readline(prompt="Do you want to remove outliers and to replace with NA? [yes/no]: ")
  if(response == "y" | response == "yes"){
    dt[as.character(substitute(var))] <- invisible(var_name2)
    assign(as.character(as.list(match.call())$dt), dt, envir = .GlobalEnv)
    cat("Outliers successfully removed", "\n")
    return(invisible(dt))
  } else{
    cat("Nothing changed", "\n")
    return(invisible(var_name2))
  }
}