
$fileA = "C:\Users\like0\work\sampleA.txt"
$fileB = "C:\Users\like0\work\sampleB.txt"
$fileDiff="C:\Users\like0\work\diff.txt"
# ファイルBが存在するかどうか確認
if (!(Test-Path $fileB)) {
	    Write-Output "File B does not exist."
		    exit
}

# ファイルAが存在する場合、差分をチェック
if (Test-Path $fileA) {
    # ファイルAとファイルBの内容を読み込む
    $contentA = Get-Content $fileA
    $contentB = Get-Content $fileB

    # 差分（BにはあるがAにはない行）を見つける
    $diff = Compare-Object $contentA $contentB | Where-Object { $_.SideIndicator -eq '=>' } | ForEach-Object { $_.InputObject }
						    
    # 差分がある場合、表示
    if ($diff) {
       Write-Output $diff
	   $diff | Out-File -FilePath $fileDiff
	    }
} else {
	    Write-Output "File A does not exist. Creating from File B."
}


