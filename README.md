# roadRouteR

Calculate and plot real road routes using OpenStreetMap and OSRM.

## Installation

You can install the development version of this package directly from GitHub:

```r
# install.packages("devtools")  # if you don't already have it
devtools::install_github("ridout-m/roadRouteR")
```

## Usage

```r
library(roadRouteR)

getRoute("Paris, France", "Berlin, Germany")
getRoute("SW1P 4DF, UK", "YO1 7PX, UK", plot = FALSE)
```
- Works with postcodes, cities, full addresses, or landmarks
- Optional progress output
- Optional leaflet map route visualization

