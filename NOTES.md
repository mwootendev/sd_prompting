



Samplers and Minimum Number of Steps for Basic Quality

| Sampler | DDIM | PLMS | K_LMS | K_HEUN | K_EULER | K_EULER_A | K_DPM_2 | K_DPM_2_A |
| -----   | ---- | ---- | ----- | ------ | ------- | --------- | ------- | --------- |
| Steps   | 8    | 32   | 50    | 16     | 8       | 8         | 32      | 32        |
| Unique  | No   | No   | No    | No     | No      | Yes       | No      | Yes       |

At a higher number of steps, DDIM, PLMS, K_LMS, K_HEUN, K_EULER, and K_DPM_2 will all produce a similar image with slight variations. The K_EULER_A and K_DPM_2_A sampers will present much greater variations.

K_EULER and K_EULER_A good for Fantasy art.
