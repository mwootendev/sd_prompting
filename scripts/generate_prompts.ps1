param ($subject, $inputFile, $artists, $outputFile, $count)

$SUBJECT=$subject
$PROMPT_INPUT_FILE=$inputFile
$ARTISTS_FILE=$artists
$PROMPT_OUTPUT_FILE=$outputFile

$WIDTH=448
$HEIGHT=640
$SIZES = "448", "512", "576", "640"#, "704", "768"

$SAMPLERS = "ddim" #, "k_euler_a", "plms", "k_dpm_2_a"
[string[]] $ARTISTS = Get-Content -Path "$ARTISTS_FILE"

$STEPS = "80"#, "150", "200", "250"

$MIN_SCALE=7
$MAX_SCALE=18

$TOTAL_COUNT = $count

Remove-Item -Path "$PROMPT_OUTPUT_FILE"
foreach($PROMPT in Get-Content $PROMPT_INPUT_FILE) {

  foreach ($current_image in (1..$TOTAL_COUNT)) {    
    $random_seed = "$(Get-Random -Minimum 0 -Maximum 99999999)"
    
    Get-Random -Minimum $MIN_SCALE -Maximum $MAX_SCALE -OutVariable random_scale
    $scale = [Math]::Round($random_scale[0], 1)
   
    $ARTISTS | Get-Random -OutVariable artist1
    $ARTISTS | Get-Random -OutVariable artist2

    $artist = "by $artist1, in the style of $artist2"

    $SIZES | Get-Random -OutVariable WIDTH
    $SIZES | Get-Random -OutVariable HEIGHT

    $STEPS | Get-Random -SetSeed $random_seed -OutVariable steps
    $SAMPLERS | Get-Random -SetSeed $random_seed -OutVariable sampler

    # $prompt_value="$PROMPT,by $artist1 -W$WIDTH -H$HEIGHT -A$sampler -C$scale -s$steps -S$random_seed -G1"
    # $prompt_value | Out-File -Append -Encoding "utf8" -FilePath  "$PROMPT_OUTPUT_FILE"

    $prompt_value="$PROMPT,$artist -W$WIDTH -H$HEIGHT -A$sampler -C$scale -s$steps -S$random_seed -G1"
    $prompt_value | Out-File -Append -Encoding "utf8" -FilePath  "$PROMPT_OUTPUT_FILE"
  }
}