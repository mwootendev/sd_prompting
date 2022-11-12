$SUBJECT="bubble-universe"
$OUTPUT_DIRECTORY="outputs\$SUBJECT"
$SAMPLES_DIRECTORY="$OUTPUT_DIRECTORY\samples"
$ARCHIVE_DIRECTORY="$OUTPUT_DIRECTORY\" + "$(Date +"%Y.%0m.%0d.%0H.%0M")"
$PROMPT='elven girl with light blue hair blowing bubbles, bubbles with a galaxies inside of them, elf girl blows bubbles to the side, beautiful digital artwork, fantastic, imaginative, trending on artstation'
#$PROMPT='godzilla wearing reading glasses'
$SCALES = "2.5", "7.5", "12.5", "17.5"
$STEPS = "50", "80"
$ETAS = "0.0","0.5","1.0"
$SEED_START = 1
$SEED_END = 5
$TOTAL_COUNT = ($SEED_START..$SEED_END).Length * $SCALES.Length * $STEPS.Length * $ETAS.Length
$current_image = 0
mkdir -p $ARCHIVE_DIRECTORY
Write-Host "Generating $TOTAL_COUNT images to $ARCHIVE_DIRECTORY"
$PROMPT | Out-File -FilePath "$ARCHIVE_DIRECTORY\prompt.txt"
foreach ($seed in ($SEED_START..$SEED_END)) {
  foreach ($scale in $SCALES) {  
    foreach ($steps in $STEPS) {  
      foreach ($eta in $ETAS) {   
        $random_seed = "$(Get-Random -Minimum 0 -Maximum 99999999)"
        Get-Random -Minimum 0.0 -Maximum 1.0 -OutVariable random_eta
        $random_eta = [Math]::Round($random_eta[0], 2)
        Get-Random -Minimum 2.0 -Maximum 18.0 -OutVariable random_scale
        $random_scale = [Math]::Round($random_scale[0], 1)
        (16, 24, 32, 50, 64, 80, 100) | Get-Random -OutVariable random_steps
        python scripts/custom_txt2img.py --n_iter 1 --n_samples 1 --prompt "$PROMPT" --plms --ddim_steps $steps --ddim_eta $eta --seed $random_seed --W 512 --H 512 --skip_grid --scale $scale --outdir $OUTPUT_DIRECTORY
        mv $SAMPLES_DIRECTORY\*.png $ARCHIVE_DIRECTORY\${SUBJECT}_${current_image}_${scale}_${steps}_${eta}-${random_seed}.png
        $current_image++
      }
    }
  }
}