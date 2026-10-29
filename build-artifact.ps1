# Baut aus index.html die Link-Version für claude.ai (ohne <html>/<head>/<body>-Gerüst, ohne PWA-Verweise).
$src = Join-Path $PSScriptRoot 'index.html'
$out = Join-Path $PSScriptRoot 'dist\gefluegelliste.html'
$t = [IO.File]::ReadAllText($src, [Text.Encoding]::UTF8)
$style = [regex]::Match($t, '(?s)<style>.*?</style>').Value
$body = [regex]::Match($t, '(?s)<body>(.*)</body>').Groups[1].Value
$html = "<title>Geflügelliste</title>`n<meta name=""claude:viewport-fit-sides"" content=""cover"">`n$style`n$body"
New-Item -ItemType Directory -Force (Split-Path $out) | Out-Null
[IO.File]::WriteAllText($out, $html, (New-Object Text.UTF8Encoding $false))
"gebaut: $out ($((Get-Item $out).Length) Bytes)"
