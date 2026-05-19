# Klasor yolunu kesinlestiriyoruz
Set-Location "C:\GorevSistemi"

$HavuzDosyasi = "C:\GorevSistemi\havuz.txt"
$GunlukDosya = "C:\GorevSistemi\gunluk_gorevler.json"
$IlerlemeDosyasi = "C:\GorevSistemi\ilerleme.json"

# 1. Ilerleme Dosyasi Yoksa Sifirdan Olustur
if (-not (Test-Path $IlerlemeDosyasi)) {
    $IlkIlerleme = @{
        ToplamPuan = 0
        SonGuncelleme = ""
    }
    $IlkIlerleme | ConvertTo-Json | Out-File $IlerlemeDosyasi -Encoding utf8
}

$Ilerleme = Get-Content $IlerlemeDosyasi -Raw | ConvertFrom-Json
$Bugun = (Get-Date).ToString("yyyy-MM-dd")

# 2. Bugun Gorev Secilmediyse Havuzdan Rastgele 3 Tane Sec
if ($Ilerleme.SonGuncelleme -ne $Bugun -or (-not (Test-Path $GunlukDosya))) {
    if (Test-Path $HavuzDosyasi) {
        $Gorevler = Get-Content $HavuzDosyasi -Encoding utf8 | Where-Object { $_ -match '\|' }
        $Secilenler = $Gorevler | Get-Random -Count 3
        
        $GunlukListe = @()
        foreach ($g in $Secilenler) {
            $Parca = $g.Split('|')
            $GunlukListe += @{
                GorevAd = $Parca[0].Trim()
                Puan = [int]$Parca[1].Trim()
                Tamamlandi = $false
            }
        }
        $GunlukListe | ConvertTo-Json | Out-File $GunlukDosya -Encoding utf8
        $Ilerleme.SonGuncelleme = $Bugun
        $Ilerleme | ConvertTo-Json | Out-File $IlerlemeDosyasi -Encoding utf8
    }
}

# 3. Arayuzu Varsayilan Tarayici ile Baslat
Start-Process "C:\GorevSistemi\arayuz.html"