
# clear history and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("lattice")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {install.packages(x)} )
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# parameter settings
nop = 30  # number of grid points (in the book = 31)
k   = nop
s   = 0.31/nop
q   = seq(0, by = s, length.out = k)
q   = as.matrix(q)

# computing grid
w = matrix(1, k^2, 2)
for (i in 1:k) {
    for (j in 1:k) {
        w[i + (j - 1) * k, 1] = q[i]
        w[i + (j - 1) * k, 2] = q[j]
    }
}

x = matrix(w, ncol = 2)
a = x[, 1]
b = x[, 2]

# kurtosis, formula from the book SFE: Fourth moment of a GARCH(1,1) process
f = 3 + 6 * a^2/(1 - b^2 - 2 * a * b - 3 * a^2)

# reshape
ff = matrix(f, 30, 30)

# plot
wireframe(ff, drape = T, main = "Kurtosis of GARCH(1,1) processes", screen = list(z = 40, 
    x = -70, y = 3), aspect = c(1, 1), scales = list(arrows = FALSE, x = list(labels = round(seq(0, 
    0.3, len = 7), digits = 2)), y = list(labels = seq(0, 0.3, len = 7)), z = list(labels = seq(round(min(f), 
    digits = 1), round(max(f), digits = 1), len = 7))), ylab = list("Beta", 
    rot = -34, cex = 1.2), xlab = list("Alpha", rot = 34, cex = 1.2), zlab = list("Kurtosis", 
    rot = 90, cex = 1.2)) 
