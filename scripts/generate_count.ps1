$SUBJECT="prompts"
#$PROMPT='tactical combat robot, tin man from wizard of oz, ultradetailed, detailed dark gritty sci-fi city background, 8k, art by artgerm beksinski greg rutkowski and alphonse mucha, cover art, trending on artstation, tim hildebrandt, wayne barlowe, bruce pennington, donato giancola, larry elmore, ray tracing'
# $PROMPT="badass android dorothy from wizard of oz dressed in blue and white, anime character design, manga cover art, wide angle view, dramatic pose, detailed, illustration, art by artgerm and greg rutkowski and alphonse mucha, trending on artstation, todd mcfarlane and joe quesada and jim lee"
$PROMPT="scarecrow death hybrid holding a scythe, burlap face with fiery glowing green eyes, highly detailed comic book cover, ultradetailed, 4k uhd, styles like mark silvestri todd mcfarlane alex ross, cover art, character design, trending on artstation"
$PROMPT_FILE="$SUBJECT.txt"
$WIDTH=448
$HEIGHT=640

$OUTPUT_DIRECTORY="outputs\$SUBJECT"
$SAMPLES_DIRECTORY="$OUTPUT_DIRECTORY\samples"
$PLMS=$false
$MIN_STEPS=150
$MAX_STEPS=250
$steps = 50

$MIN_SCALE=5
$MAX_SCALE=15

$TOTAL_COUNT = 1
$random_seed = "$(Get-Random -Minimum 0 -Maximum 99999999)"

$ARCHIVE_DIRECTORY="$OUTPUT_DIRECTORY\" + "$(Date +"%Y.%0m.%0d.%0H.%0M")"
  mkdir -p $ARCHIVE_DIRECTORY
  Write-Host "Generating $TOTAL_COUNT images to $ARCHIVE_DIRECTORY"

$prompt_index = 0
foreach($PROMPT in Get-Content $PROMPT_FILE) {
  $prompt_index++
  
  # if ($PROMPT_FILE) {
  #   $prompt_param="--from-file"
  #   $prompt_value=$PROMPT_FILE
  #   cp $PROMPT_FILE "$ARCHIVE_DIRECTORY\prompt.txt"
  # } else {
    $prompt_param="--prompt"
    $prompt_value=$PROMPT
    $PROMPT | Out-File -Append -FilePath  "$ARCHIVE_DIRECTORY\prompt.txt"
  # }

  foreach ($current_image in (1..$TOTAL_COUNT)) {
    # $random_seed = "$(Get-Random -Minimum 0 -Maximum 99999999)"

    if ($PLMS) {
      $eta = "--plms"
    } else {
      Get-Random -Minimum 0.0 -Maximum 1.0 -OutVariable random_eta
      $eta = "--ddim_eta $([Math]::Round($random_eta[0], 2))"
    }
    
    Get-Random -Minimum $MIN_SCALE -Maximum $MAX_SCALE -OutVariable random_scale
    # $scale = [Math]::Round($random_scale[0], 1)
    # Get-Random -Minimum $MIN_STEPS -Maximum $MAX_STEPS -OutVariable steps
    $scale = 1.0
    $eta = ""
    python scripts/custom_txt2img.py --n_iter 1 --n_samples 1 --ddim_steps $steps $eta --seed $random_seed --W $WIDTH --H $HEIGHT --skip_grid --scale $scale --outdir $OUTPUT_DIRECTORY $prompt_param "$prompt_value"
    
    # if ($PROMPT_FILE) {
    #   mkdir $ARCHIVE_DIRECTORY\${SUBJECT}_${current_image}_${scale}_${steps}_${eta}-${random_seed}
    #   mv $SAMPLES_DIRECTORY\*.png $ARCHIVE_DIRECTORY\${SUBJECT}_${current_image}_${scale}_${steps}_${eta}-${random_seed}
    # } else {
      mv $SAMPLES_DIRECTORY\*.png $ARCHIVE_DIRECTORY\${SUBJECT}_${prompt_index}_${current_image}_${scale}_${steps}_${eta}-${random_seed}.png
    # }  
    
    $current_image++
  }
}