#16/04/21
#knitr

("C:/lab/")
install.packages("knitr")
library(knitr)

stitch("rcodegreenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
