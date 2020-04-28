#https://jaist.dl.sourceforge.net/project/mplayer-win32/MPlayer%20and%20MEncoder/r38184%2Bg13171ad2e3/MPlayer-x86_64-r38184%2Bg13171ad2e3.7z
#wget https://www.7-zip.org/a/7za920.zip
Write-Output "Hello from BooksHorse"
md temp
attrib +h /d "temp"
$url = "https://jaist.dl.sourceforge.net/project/mplayer-win32/MPlayer%20and%20MEncoder/r38184%2Bg13171ad2e3/MPlayer-x86_64-r38184%2Bg13171ad2e3.7z"
$output = "$PSScriptRoot\temp\a.7z"
$start_time = Get-Date
Import-Module BitsTransfer
#
Start-BitsTransfer -Source $url -Destination $output

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
$url = "https://www.7-zip.org/a/7za920.zip"
$output = "$PSScriptRoot\temp\7z.zip"
$start_time = Get-Date

Start-BitsTransfer -Source $url -Destination $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

wget https://yt-dl.org/downloads/2020.03.24/youtube-dl.exe -O youtube-dl.exe
mv "youtube-dl.exe" "$PSScriptRoot\temp\youtube-dl.exe"
#
Write-Output "Hello again from BooksHorse"
Expand-Archive -Force -LiteralPath "$PSScriptRoot\temp\7z.zip" -DestinationPath "$PSScriptRoot\temp\7zunzip"
Start-Process -FilePath "$PSScriptRoot\temp\7zunzip\7za.exe" -ArgumentList "e","$PSScriptRoot\temp\a.7z","-o$PSScriptRoot\temp\mplayer","-y" -wait
Start-Process -FilePath "$PSScriptRoot\temp\7zunzip\7za.exe" -ArgumentList "e","$PSScriptRoot\temp\a.7z","-o$PSScriptRoot\temp\mplayer","-y" -wait
Start-Sleep -s 10
Start-Process -FilePath "$PSScriptRoot\temp\youtube-dl.exe" -ArgumentList "https://www.youtube.com/watch?v=DJfg39WkMvE"
Start-Sleep -s 5
Rename-Item -Path "Blend W-DJfg39WkMvE.mp4" -NewName "a.mp4"
mv "a.mp4" "$PSScriptRoot\temp\"
Start-Sleep -s 2
Write-Output "----------------------------------"
Start-Process -FilePath "$PSScriptRoot\temp\mplayer\mplayer.exe" -ArgumentList "-vo","caca","-hardframedrop","-cache 8192","-xy","1920","-geometry","0:0","$PSScriptRoot\temp\a.mp4"
