data {
  int<lower=1> N; // Number of data points (1 or more points)
  array[N] real<lower=0> t; // Time points
  array[N] real<lower=0> P_meas; // Measured population sizes
  real<lower=0> P0; // Initial population size
}

parameters {
  real<lower=0> K; // Carrying capacity
  real<lower=0> r; // Growth rate
  real<lower=0> sigma; // Measurement error
}

model {
  array[N] real P_pred; // Predicted population sizes
  // Now define the priors for K, r and sigma
  K ~ normal(0.5, 0.25); // When we look at the dataset column E4, we have values somewhere between -0.25 and 0.5. But we are looking at the positive values here, why we use 0.5 and 0.25.
  r ~ normal(0.3, 0.1); // The growth rate per hour is somewhere between 0.1 and 0.3, so we use 0.3 and 0.1.
  sigma ~ exponential(1);

  // Growth model and likelihood
  for (n in 1:N) {
    P_pred[n] = K / (1 + (K / P0 - 1) * exp(-r * t[n]));
    P_meas[n] ~ normal(P_pred[n], sigma);
  }
}
