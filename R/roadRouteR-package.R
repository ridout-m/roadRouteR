#' roadRouteR: Route Calculation and Mapping
#'
#' A lightweight wrapper for calculating and visualizing realistic road routes using OSRM and OpenStreetMap.
#'
#' @section Functions:
#' \itemize{
#'  \item \code{getRoute()}:  Calculate and optionally plot a road route between two places
#' }
#'
#' @section Dependencies:
#' \itemize{
#'   \item \code{osrm}:  Communicates with the OSRM backend
#'   \item \code{tidygeocoder}:  Converts place names/postcodes to coordinates using OSM
#'   \item \code{sf}:  Handles spatial data and geometry
#'   \item \code{leaflet}:  Plots interactive web maps
#'   \item \code{geosphere}:  Detects route jumps or broken segments
#'   \item \code{dplyr}:  Light data wrangling
#' }
#'
#' @author
#' Mackenzie Ridout \url{https://github.com/ridout-m}
#'
#' @docType package
#' @name roadRouteR
#' @keywords package
"_PACKAGE"
