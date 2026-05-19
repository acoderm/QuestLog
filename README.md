# 🎯 QuestLog.exe - RPG Style Daily Task Manager

QuestLog.exe, günlük rutinlerinizi ve hedeflerinizi bir rol yapma oyununa (RPG) dönüştüren, tamamen yerel (local) ve dinamik bir görev yönetim sistemidir. Bilgisayarınızı her açtığınızda sizi karşılar, havuzunuzdan rastgele 3 görev seçer ve tamamladıkça size XP kazandırır!

---

## 🚀 Özellikler (Features)

* **Dinamik Görev Havuzu:** Kodlama yapmadan, arayüzdeki "Ayarlar" sekmesinden kendi görevlerinizi ekleyebilir, silebilir ve XP puanlarını belirleyebilirsiniz.
* **Rastgele Görev Seçimi:** Her gün havuzunuzdan rastgele 3 görev seçilir, böylece rutinleriniz monotonlaşmaz.
* **Görünmez Arka Plan Motoru:** PowerShell scripti sayesinde sistem Windows başlangıcında tamamen sessiz ve sorunsuz çalışır.
* **Kişiselleştirilmiş İlerleme:** Kazandığınız XP'ler ve görev havuzunuz tarayıcınızın `localStorage` alanında, tamamen size özel ve izole olarak saklanır.

---

## 🛠️ Kurulum ve Çalıştırma (Setup Instructions)

Projeyi kendi bilgisayarınızda çalıştırmak için aşağıdaki adımları sırasıyla uygulamanız yeterlidir:

### 1. Dosyaları Konumlandırma
Bu repodaki tüm dosyaları indirin ve bilgisayarınızda doğrudan **`C:\GorevSistemi`** klasörünün içine yapıştırın.
> *Not: Kodların kararlı çalışması için klasör yolunda Türkçe karakter veya OneDrive senkronizasyonu olmamasına dikkat edilmelidir.*

### 2. Windows Başlangıcına Ekleme (Oto-Start)
Bilgisayarınız her açıldığında uygulamanın otomatik gelmesi için:
1. `Windows + R` tuşlarına basarak çalıştır penceresini açın.
2. `shell:startup` yazıp Enter'a basın (Başlangıç klasörü açılacaktır).
3. Açılan klasörün içinde boş bir yere **Sağ Tıkla -> Yeni -> Kısayol** deyin.
4. Konum kutusuna aynen şu komutu yapıştırın:
   ```text
   powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\GorevSistemi\motor.ps1"
