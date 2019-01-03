### Calculate normal approximation in a strip

https://stats.stackexchange.com/questions/385454/when-why-to-use-the-normal-approximation-inside-a-vertical-strip

![normal approx in vertical strip](https://i.stack.imgur.com/EImVs.png)


```
# Calculate normal approximation in a strip
#
# https://stats.stackexchange.com/questions/385454/when-why-to-use-the-normal-approximation-inside-a-vertical-strip

x_avg  = 162
x_sd   = 6
y_avg = 68
y_sd  = 10

r = 0.60

# of the students who scored 165 on the lsat, about what percentage
# had first-year scores over 75?

x_score = 165
predicted_score = 75

## Calculate new average

SDs_above_average = (x_score - x_avg)/x_sd
# 0.5

new_average = y_avg + (r * SDs_above_average * y_sd)
# 71

## Calculate new SD

new_sd = sqrt(1 - r^2) * y_sd
# 8

## Calculate percentage

z = (predicted_score - new_average) / new_sd
# 0.5

pct = 1 - pnorm(z)
# 31

```
