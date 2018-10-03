gifiTransform <- function (data, target, basis, copies, degree, ordinal, ties, missing) {
    nobs <- nrow(as.matrix (data))
    h <- matrix(0, nobs, copies)
    if (degree == -1) {
      if (ordinal) {
        h[, 1] <- coneRegression(data = data, target = target[, 1], type = "c", ties = ties, missing = missing)
      }
      else {
        h[, 1] <- coneRegression(data = data, target = target[, 1], basis = basis, type = "s", missing = missing)
      }
    }
    if (degree >= 0) {
      if (ordinal) {
        h[, 1] <- coneRegression(data = data, target = target[, 1], basis = basis, type = "i", ties = ties, missing = missing)
      }
      else {
        h[, 1] <- coneRegression(data = data, target = target[, 1], basis = basis, type = "s", ties = ties, missing = missing)
      }
    }
    if (copies > 1) {
      for (l in 2:copies)
        h[, l] <- coneRegression(data = data, target = target[, l], basis = basis, type = "s", ties = ties, missing = missing)
    }
    return (h)
  }