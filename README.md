This script and data are based on an issue [JD Long](https://twitter.com/CMastication) mentioned [on twitter](https://twitter.com/CMastication/status/1255485823451045892).

[Eric Bickel](https://twitter.com/eric_bickel) created [this script](https://gist.github.com/ehbick01/a2d04e986a0a7ad9676fbeb5f5e74f2b) to download CSVs with series descriptions that FRED provides. Unfortunately, FRED stopped providing those CSVs in May-2000.

JD wrote a script to traverse the network of parent/child categories and create a list of all the available FRED series. Thanks to JD for sharing that with me. JD's script used the [fredr](https://CRAN.R-project.org/package=fredr) package, which has since been archived on CRAN. I replicated JD's script after removing the dependency on `fredr`.

My intention is to re-create this CSV once a week and host it in this repo. Please create an issue if you have ideas about how to improve the process and/or the data provided in the CSV.


