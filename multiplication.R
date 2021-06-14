#### Aim of prog: Generate funny figures from multiplication tables
## Comments
# This program is related to the book "Dictionnaire amoureux des mathÉmatiques", by André DELEDICQ, Mickaël LAUNAY
# https://www.lisez.com/livre-grand-format/dictionnaire-amoureux-des-mathematiques/9782259264860
# You can also watch Mickaël Launay's channel: https://www.youtube.com/channel/UC4PasDd25MXqlXBogBw9CAg

#### Load libraries and set options
library(data.table)
library(DescTools)

rm(list = ls())
options(max.print = 500)

#### Define variables
multiplication = 6
modulo = 450
radius = 2

theta_pos_orig = pi/2
delta_theta = 2*pi/modulo

printNames = FALSE

list_points = 0:(modulo - 1)

#### Draw multiplication table
## Circle
DescTools::Canvas(xlim = c(-2, 2), xpd = TRUE)

DrawCircle(x = 0, y = 0, r.out = radius,
	theta.1 = 0, theta.2 = 2*pi, lwd = 2, nv = 100)


## Compute polar coordinates of points
coords_points = data.table(id = list_points,
	x = radius*cos(delta_theta*list_points - theta_pos_orig),
	y = radius*sin(delta_theta*list_points + theta_pos_orig))

if (printNames) # To improve by deviding the circle into four sections
{
	points(coords_points[, x], coords_points[, y], pch = 20)
	text(x = coords_points[, x], y = coords_points[, y], labels = list_points, pos = 1)
}

## Link nodes
setkey(coords_points, id)
coords_points[, dest := (multiplication*list_points) %% modulo]
coords_points[, x_dest := coords_points[.(dest), x]]
coords_points[, y_dest := coords_points[.(dest), y]]

segments(x0 = coords_points[, x], y0 = coords_points[, y], x1 = coords_points[, x_dest], y1 = coords_points[, y_dest])
