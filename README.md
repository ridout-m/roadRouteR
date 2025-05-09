# roadRouteR

[![GitHub version](https://img.shields.io/github/v/tag/ridout-m/roadRouteR?label=version)](https://github.com/ridout-m/roadRouteR/releases)
[View on GitHub](https://github.com/ridout-m/roadRouteR)

Calculate and plot real road routes using OpenStreetMap and OSRM.

## Installation

You can install the development version of this package directly from GitHub:

```r
install.packages("pak")
library(pak)
pak::pak("ridout-m/roadRouteR")
library(roadRouteR)
```

## Usage

```r
getRoute("Paris, France", "Berlin, Germany")
getRoute("SW1P 4DF, UK", "YO1 7PX, UK", plot = FALSE)
```
- Works with postcodes, cities, full addresses, or landmarks
- Optional progress output
- Optional leaflet map route visualization

