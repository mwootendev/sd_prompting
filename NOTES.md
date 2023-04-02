



Samplers and Minimum Number of Steps for Basic Quality

| Sampler | DDIM | PLMS | K_LMS | K_HEUN | K_EULER | K_EULER_A | K_DPM_2 | K_DPM_2_A |
| -----   | ---- | ---- | ----- | ------ | ------- | --------- | ------- | --------- |
| Steps   | 8    | 32   | 50    | 16     | 8       | 8         | 32      | 32        |
| Unique  | No   | No   | No    | No     | No      | Yes       | No      | Yes       |

At a higher number of steps, DDIM, PLMS, K_LMS, K_HEUN, K_EULER, and K_DPM_2 will all produce a similar image with slight variations. The K_EULER_A and K_DPM_2_A sampers will present much greater variations.

K_EULER and K_EULER_A good for Fantasy art.


# DEFORUM

st=0.9 | noise = 0.00
st=0.8 | noise = 0.01
st=0.7 | noise = 0.02
st=0.6 | noise = 0.03
st=0.5 | noise = 0.04

## MATHs


### Noise
Alternates between 0.07 and 0.02 every 15 frames
Exponent controls how quick or gradual the change (1000 is drastic change)
0.07*(cos(3.141*t/15)**1000)+0.02

### Strength
Alternate between 0.5 and 0.65 every 50 frames, drastic quick change
(-0.15*(cos(3.141*t/50)**1000)+0.65)

### CONVERT RANGE, MAINTAINING RATIO (Not sure what this means)
NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin



 rotation_3d_x = "0: (0.25*sin(2*3.141*t/250))
 rotation_3d_y = "0: (0.25*sin(2*3.141*t/250))"#@param {type:"string"}

Switches back and forth between +0.25 and -0.25 every 250 frames

https://graphtoy.com/?f1(x,t)=(0.25*s...

 rotation_3d_z = "0: (0.5*sin(2*3.141*t/250))"#@param {type:"string"}

Switches back and forth between +0.25 and -0.25 every 250 frames

https://graphtoy.com/?f1(x,t)=(0.5*si...

 strength_schedule = "0:(-0.13*(cos(3.141*t/31)**100)+0.63)

 "noise_schedule":	"0:(((0.07-0.02)*sin(3.141*t/60)**10000)+0.02)",
"strength_schedule":	"0:(((0.7-0.2)*-sin(3.141*t/60)**10000)+0.7)",