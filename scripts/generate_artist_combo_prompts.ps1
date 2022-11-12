$SUBJECT="godzilla"
$PROMPT_INPUT_FILE="$SUBJECT.txt"
$ARTISTS_FILE="$SUBJECT-artists.txt"
$PROMPT_OUTPUT_FILE="$SUBJECT-prompts.txt"

$WIDTH=448
$HEIGHT=640
$SIZES = "448", "512", "576", "640", "704", "768"

$SAMPLERS = "ddim", "k_euler_a", "plms", "k_dpm_2_a"
[string[]] $ARTISTS = Get-Content -Path "$ARTISTS_FILE"

$STEPS = "50", "80"

$MIN_SCALE=10
$MAX_SCALE=15

$TOTAL_COUNT = 1

Remove-Item -Path "$PROMPT_OUTPUT_FILE"
foreach($PROMPT in Get-Content $PROMPT_INPUT_FILE) {

  $random_seed = "$(Get-Random -Minimum 0 -Maximum 99999999)"
        
  Get-Random -Minimum $MIN_SCALE -Maximum $MAX_SCALE -OutVariable random_scale
  $scale = [Math]::Round($random_scale[0], 1)
  $STEPS | Get-Random -OutVariable steps
  $SAMPLERS | Get-Random -OutVariable sampler
  
  $SIZES | Get-Random -OutVariable WIDTH
  $SIZES | Get-Random -OutVariable HEIGHT

  foreach($artist1 in $ARTISTS) {

    foreach ($artist2 in $ARTISTS) {

      foreach ($current_image in (1..$TOTAL_COUNT)) {        
        $artist = "by $artist1, in the style of $artist2"
        $prompt_value="$PROMPT,$artist -W$WIDTH -H$HEIGHT -A$sampler -C$scale -s$steps -S$random_seed -G1"
        $prompt_value | Out-File -Append -Encoding "utf8" -FilePath  "$PROMPT_OUTPUT_FILE"
      }
    }
  }
}