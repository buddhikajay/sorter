function sm= histogram_intersection(h1, h2, bins)
 bins = numpy.diff(bins)
 sm = 0
 for i in range(len(bins)):
  sm=sm+ min(bins[i]*h1[i], bins[i]*h2[i])
 end