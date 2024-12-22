data {
    int<lower=1> N; // Number of datapoints
    array[N] real X; // Data
}

parameters {
    real mu; // Mean value of the normal distribution.
    real<lower=0> sigma; // Standard deviation of the normal distribution. We want to make sure that the standard deviation is positive.
}

model {
    // Define priors
    mu ~ normal(0, 1); // Prior for the mean value of the normal distribution.
    sigma ~ gamma(2,1); // Prior for the standard deviation of the normal distribution.

    X ~ normal(mu, sigma); // Likelihood
}

generated quantities {
   real log_likelihood = 0; // Log likelihood
    for (n in 1:N) {
        log_likelihood += normal_lpdf(X[n] | mu, sigma); // Calculate the log likelihood
    }
}
