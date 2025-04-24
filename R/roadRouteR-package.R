#' roadRouteR: Route Calculation and Mapping
#'
#' A lightweight wrapper for calculating and visualizing realistic road routes using OSRM and OpenStreetMap.
#'
#' @section Functions:
#' - `getRoute()`: Calculate and optionally plot a road route between two places.
#'
#' @section Dependencies:
#' - `osrm`: Communicates with the OSRM backend
#' - `tidygeocoder`: Converts place names/postcodes to coordinates using OSM
#' - `sf`: Handles spatial data and geometry
#' - `leaflet`: Plots interactive web maps
#' - `geosphere`: Detects route jumps or broken segments
#' - `dplyr`: Light data wrangling
#'
#' @author
#' Mackenzie Ridout \url{https://github.com/ridout-m}
#'
#' @docType package
#' @name roadRouteR
#' @keywords package
"_PACKAGE"
