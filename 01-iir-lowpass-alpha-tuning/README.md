# 01 — Fixed-α EMA / First-Order IIR Low-Pass Filter: Response Time vs. Noise Trade-off

## Aim
To implement a recursive (IIR) low-pass filter with a fixed smoothing parameter α, and characterize how α affects the trade-off between response time and noise suppression when estimating a noisy sensor measurement.

## Background

A real sensor rarely reports the exact value of a physical quantity — its output is corrupted by noise, causing the measured value to fluctuate around the true value:

```
Z_k = X_true + noise
```

A filter processes these noisy measurements to produce an estimate with reduced fluctuation.

**Recursive vs. non-recursive filters**
- A **recursive** filter uses its own previous output (estimate) to compute the next output.
- A **non-recursive** filter computes each output only from current/past *measurements*, never from its own past output.

This experiment uses a recursive filter — specifically, a fixed-α exponential moving average (EMA), which is mathematically identical to a first-order IIR low-pass filter.

## Recursive Filter Equation

$$X_k = (1-\alpha) X_{k-1} + \alpha Z_k$$

where:
- `X_k` — current filtered/estimated value
- `X_{k-1}` — previous filtered/estimated value
- `Z_k` — current sensor measurement
- `α` — filter parameter (0 < α < 1)

## Apparatus
- MATLAB R2022B
- Synthetic sensor data: `Z_k = X_true + noise`, `noise ~ N(0,1)` via `randn`
- N = 100 measurements, `X_true = 10`

## Procedure
1. **Single-α run** (`single_alpha_ema.m`) — filter the noisy signal with a fixed α = 0.8, and plot the sensor measurement, filtered estimate, and true value together.
2. **Multi-α comparison** (`alpha_comparison.m`) — repeat the filter for α = [0.1, 0.2, 0.5, 0.8] on the same noise realization (`rng(1)`), and compare the four responses side by side in a 2×2 grid.

## Observations

- Decreasing α (e.g. 0.1) → the estimate stays closer to the true value and further from the raw noisy measurement. Noise is suppressed more, but the filter's **response time is slower** — after a step change in the true value, the estimate takes longer to catch up.
- Increasing α (e.g. 0.8) → the estimate tracks the raw sensor measurement more closely. The filter's **response time is faster**, but more noise passes through into the estimate.
- Example — true value steps from 10 to 20:
  - α = 0.1: slow correction (e.g. 10.5 → 10.1 → ... → 20 over many steps), low noise
  - α = 0.8: fast correction (e.g. 10.5 → 19.15 → ... → 20 over few steps), higher noise

**The trade-off:** raising α *decreases* response time (faster tracking) but *increases* noise passthrough. Lowering α does the opposite. Response time and noise move in **opposite directions** as α changes — no single fixed α is optimal for both.

## Disadvantage of the Fixed-α EMA Filter

Because α is fixed, the filter cannot adapt to changing conditions. If the sensor noise level or the rate of change of the true value varies over time, a single α will always be a compromise — too noisy during quiet periods, or too slow during fast-changing periods. This limitation motivates the **Kalman filter**, which computes a *time-varying* optimal gain instead of using a fixed one.

## Files

| File | Description |
|---|---|
| `single_alpha_ema.m` | Single fixed-α (0.8) recursive filter run |
| `alpha_comparison.m` | α sweep (0.1, 0.2, 0.5, 0.8) comparison, 2×2 subplot |
| `plots/single_alpha_ema_result.png` | Result of the single-α run |
| `plots/alpha_comparison_grid.png` | Result of the 4-α comparison |

## Results

![Single alpha EMA filter result](./plots/single_alpha_ema_result.png)

![Alpha comparison grid](./plots/alpha_comparison_grid.png)

---
[← back to repo overview](../README.md)