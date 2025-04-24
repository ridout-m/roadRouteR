#' Calculate and optionally plot a road route between two locations
#'
#' This function uses OpenStreetMap and OSRM to calculate a drivable
#' route between two locations (addresses, cities, or postcodes).
#'
#' @param origin A character string representing the starting location (e.g., "Paris", "SW1P 4DF, UK").
#' @param destination A character string representing the destination location (e.g., "Berlin, Germany", "YO10 5FR").
#' @param plot Logical. If TRUE, plots the route on an interactive leaflet map. Default is TRUE.
#' @param progress Logical. If TRUE, prints progress messages to the console. Default is FALSE.
#' @param method Character. Geocoding method. One of "osm" (default) or "arcgis".
#'
#' @return A list with the following elements:
#' \itemize{
#'   \item \code{distance_km}:  Distance in kilometers
#'   \item \code{duration_mins}:  Estimated travel time in minutes
#'   \item \code{route}:  An \code{sf} object representing the route geometry
#' }
#'
#' @examples
#' \dontrun{
#' # Internet connection required
#' try(getRoute("Brandenburg Gate, Berlin, Germany", "Paris", progress = TRUE))
#' }
#'
#' @importFrom utils flush.console
#' @importFrom sf st_coordinates
#' @importFrom geosphere distHaversine
#' @importFrom osrm osrmRoute
#' @importFrom leaflet leaflet leafletOptions addTiles addPolylines addMarkers addControl
#' @importFrom tidygeocoder geocode
#' @importFrom dplyr select rename
#' @importFrom tibble tibble
#' @importFrom magrittr %>%
#' @importFrom utils globalVariables
#'
#' @export




getRoute <- function(origin, destination, plot = TRUE, progress = FALSE, method = c("osm", "arcgis")) {


  method <- match.arg(method)


  prog <- function(msg) {
    message(msg)
    flush.console()
  }


  # Geocode
  if (progress){
    prog("~ Geocoding addresses")
  }
  postcodes <- tibble::tibble(id = c("origin", "dest"),
                      address = c(origin, destination))
  coords <- postcodes %>%
    tidygeocoder::geocode(address = address, method = method) %>%
    dplyr::select(-address) %>%
    dplyr::rename(lon = long)


  # Safe route fetch
  if (progress){
    prog("~ Fetching route from OSRM")
  }
  route <- tryCatch({
    osrm::osrmRoute(src = c(coords$lon[1], coords$lat[1]),
              dst = c(coords$lon[2], coords$lat[2]),
              overview = "full")
  }, error = function(e) {
    stop("Failed to fetch route. ", conditionMessage(e))
  })
  if (is.null(route) || is.na(route$distance)) {
    stop("No valid route found between: ", origin, " and ", destination)
  }


  # Handle routing over water
  if (progress){
    prog("~ Handling pathing issues")
  }
  coords_matrix <- sf::st_coordinates(route$geometry)[, 1:2]
  dists <- geosphere::distHaversine(coords_matrix[-nrow(coords_matrix), ], coords_matrix[-1, ])
  if (any(dists > 10000)) {
    stop("No driveable route found. Route likely contains disconnected segments")
  }


  # Output stats
  if (progress){
    prog("~ Calculating distance and duration")
  }
  distance <- paste(route$distance)
  duration <- paste0(floor(route$duration / 60), "h ", round(route$duration %% 60), "m")
  cat(paste(rep("-", 70), collapse = ""))
  cat("\n  Distance: ", distance)
  cat("\n  Duration: ", duration)
  cat("\n", paste(rep("-", 70), collapse = ""), "\n")


  # Plot
  if (plot) {

    if (progress){
      prog("~ Rendering map")
    }

    route_info <- paste0(
      "<b>Road Route</b><br>",
      origin, " to ", destination, "<br>",
      "Distance: ", distance, "<br>",
      "Duration: ", duration
    )

    map <- leaflet::leaflet(options = leaflet::leafletOptions(worldCopyJump = TRUE)) %>%
      leaflet::addTiles() %>%
      leaflet::addPolylines(data = route, color = "blue", weight = 4) %>%
      leaflet::addMarkers(lng = coords$lon[1], lat = coords$lat[1], label = "Origin") %>%
      leaflet::addMarkers(lng = coords$lon[2], lat = coords$lat[2], label = "Destination") %>%
      leaflet::addControl(html = route_info, position = "topright")

    print(map)

  }


  # Return the data
  invisible(list(distance_km = route$distance, duration_mins = route$duration, route = route))


}

utils::globalVariables(c("address", "long"))
