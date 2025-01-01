# Fill GitHub contribution graph
$startDate     = [datetime]"2025-01-01"
$endDate       = [datetime]"2026-04-17"
$commitsPerDay = 4

$env:GIT_AUTHOR_NAME      = "sravanimadaka1"
$env:GIT_AUTHOR_EMAIL     = "sravanimadaka1@gmail.com"
$env:GIT_COMMITTER_NAME   = "sravanimadaka1"
$env:GIT_COMMITTER_EMAIL  = "sravanimadaka1@gmail.com"

$file    = "contributions.md"
$current = $startDate

Write-Host "Creating commits from $startDate to $endDate ..."

while ($current -le $endDate) {
    for ($i = 1; $i -le $commitsPerDay; $i++) {
        $hour      = Get-Random -Minimum 9 -Maximum 19
        $min       = Get-Random -Minimum 0  -Maximum 60
        $timestamp = $current.ToString("yyyy-MM-dd") + "T" + ("{0:D2}" -f $hour) + ":" + ("{0:D2}" -f $min) + ":00"

        Add-Content -Path $file -Value "commit $timestamp"

        git add $file

        $env:GIT_AUTHOR_DATE    = $timestamp
        $env:GIT_COMMITTER_DATE = $timestamp

        git commit -m "Update $($current.ToString('yyyy-MM-dd')) ($i)" --quiet
    }
    $current = $current.AddDays(1)
}

Remove-Item Env:GIT_AUTHOR_DATE    -ErrorAction SilentlyContinue
Remove-Item Env:GIT_COMMITTER_DATE -ErrorAction SilentlyContinue

Write-Host "Done! Now run:  git push origin main --force"
