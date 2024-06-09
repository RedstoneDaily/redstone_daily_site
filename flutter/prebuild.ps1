# 设置变量
$aegis_enabled = $false
$aegis_env_type = ""

for ($i = 0; $i -lt $args.Count; $i++) {
	if ($args[$i] -eq "--aegis") {
		$aegis_enabled = $true
		if ($i + 1 -lt $args.Count -and $args[$i + 1] -notlike "--*") {
			$aegis_env_type = $args[$i + 1]
		}
	} elseif ($args[$i] -like "--*") {
		Write-Host "Unknown argument: $($args[$i])"
	}
}

# 设置默认环境类型为 "others"
$aegis_env_types = "prod", "dev", "gray", "pre", "daily", "local", "test", "others"
if ( $aegis_env_type -notin $aegis_env_types){
	$aegis_env_type = "others"
}

$AEGIS_SCRIPT = ""
if ($aegis_enabled) {
    Write-Host "AEGIS is enabled, inserting script snippet into index.html"
    $AEGIS_SCRIPT = (Get-Content "web\aegis-script.html" -Raw -Encoding utf8).Replace('$ENV_TYPE', $aegis_env_type)
}

(Get-Content "web\template.html" -Raw -Encoding utf8).Replace('$AEGIS_SCRIPT', $AEGIS_SCRIPT) | Set-Content "web\index.html" -Encoding utf8