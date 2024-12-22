data {
    int<lower=1> N; // Number of data points
    int<lower=0> J; // Number of subjects
    array[N] int<lower=1,upper=J> subject; // Array of subject indices
    vector[N] y; // Vector of response values
    vector[N] t; // Vector of time values
}

parameters {
    real<lower=0> C0; // Unknown initiual concentration
    vector<lower=0>[J] lambda; // Unknown decay rate for each subject
    real<lower=0> alpha; // Hyperparameter alpha
    real<lower=0> beta; // Hyperparameter beta
    real<lower=0> sigma; // Measurement error
}

model {
    alpha ~ gamma(3, 1); // Prior for alpha
    beta ~ gamma(3, 1); // Prior for beta
    lambda ~ gamma(alpha, beta); // Prior for lambda
    y ~ normal(C0 * exp(-lambda[subject] .* t), sigma); // Likelihood
}

generated quantities {
    vector[J] lambda_pop;
    for (n in 1:J) {
        lambda_pop[n] = gamma_rng(alpha, beta);
    }
}
