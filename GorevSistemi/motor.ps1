# Klasör yolunu otomatik tespit et
$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $PSScriptRoot

$HavuzDosyası = "havuz.txt"
$GunlukDosya = "gunluk_gorevler.json"
$IlerlemeDosyası = "ilerleme.json"

# 1. İlerleme Dosyası Yoksa Sıfırdan Oluştur (Ödül Eşikleri Dahil)
if (-not (Test-Path $IlerlemeDosyası)) {
    $IlkIlerleme = @{
        ToplamPuan = 0
        SonGuncelleme = ""
        Oduller = @{
            "Aylik_Kahve_Market" = $false  # 500 Puan
            "Ikinci_Ay_Bilgisayar" = $false # 2500 Puan
        }
    }
    $IlkIlerleme | ConvertTo-Json | Out-File $IlerlemeDosyası -Encoding utf8
}

$Ilerleme = Get-Content $IlerlemeDosyası -Raw | ConvertFrom-Json
$Bugun = (Get-Date).ToString("yyyy-MM-dd")

# 2. Bugün Zaten Bilgisayar Açıldı mı ve Görev Seçildi mi Kontrol Et
if ($Ilerleme.SonGuncelleme -ne $Bugun -or (-not (Test-Path $GunlukDosya))) {
    
    # Havuzdan görevleri oku
    if (Test-Path $HavuzDosyası) {
        $Gorevler = Get-Content $HavuzDosyası -Encoding utf8 | Where-Object { $_ -match '\|' }
        
        # Rastgele 3 tane seç
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
        
        # Günlük görevleri kaydet
        $GunlukListe | ConvertTo-Json | Out-File $GunlukDosya -Encoding utf8
        
        # Tarihi güncelle
        $Ilerleme.SonGuncelleme = $Bugun
        $Ilerleme | ConvertTo-Json | Out-File $IlerlemeDosyası -Encoding utf8
    }
}

# 3. Şık HTML Arayüzünü Windows Üzerinde Çalıştır
Start-Process "arayuz.html"