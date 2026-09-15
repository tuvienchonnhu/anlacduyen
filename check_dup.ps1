Get-ChildItem "sm-shop\src\main\webapp\pages\shop\templates" -Recurse -Filter search.jsp | ForEach-Object {
  $f = $_.FullName
  $lines = Get-Content $f
  for ($i=1; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Trim() -eq '</script>' -and $lines[$i-1].Trim() -eq '</script>') {
      Write-Output "${f}: line $($i+1)"
    }
  }
}
