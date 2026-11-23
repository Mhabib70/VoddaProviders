<div dir="rtl">

# 💼 Vodda Providers — اپلیکیشن سمت خدمات‌دهنده

<p align="center">
  <img src="assets/images/splash.png" width="140" alt="Vodda Providers" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3-02569B?logo=flutter" alt="Flutter 3" />
  <img src="https://img.shields.io/badge/Dart-3.8-0175C2?logo=dart" alt="Dart" />
  <img src="https://img.shields.io/badge/GetX-state%20management-8A2BE2" alt="GetX" />
  <img src="https://img.shields.io/badge/version-1.0.0-blue" alt="version" />
  <img src="https://img.shields.io/badge/RTL-%D9%81%D8%A7%D8%B1%D8%B3%DB%8C-green" alt="Persian RTL" />
</p>

اپلیکیشن خدمات‌دهندگان پلتفرم **Vodda** 🛠 — ثبت‌نام با احراز مدارک، مدیریت خدمات و نوبت‌ها، پیام‌رسانی با مشتریان و مشاهدهٔ درآمد.

> 📱 این ریپو **سمت خدمات‌دهنده** است؛ اپلیکیشن سمت مشتری در ریپوی [VoddaOld](https://github.com/Mhabib70/VoddaOld) نگهداری می‌شود.

## 🆕 آخرین به‌روزرسانی (اکتبر ۲۰۲۶)

- 📚 مستندسازی کامل پروژه جایگزین README پیش‌فرض Flutter شد

---

## ✨ امکانات

- 📝 **ثبت‌نام خدمات‌دهنده (ویزارد کامل)** — فرم اطلاعات ← انتخاب تخصص‌ها ← تعیین موقعیت روی نقشه ← آپلود مدارک و تصاویر ← تایید
- 📋 **داشبورد مدیریت کار** — فهرست کارها (`my-works`)، جزئیات هر کار، اسناد سفارش‌ها و تصاویر
- 🗓 **زمان‌بندی هوشمند** — تعیین زمان‌های آزاد، زمان‌بندی هفتگی و تعطیلات (`MyTimes`)
- 🛠 **مدیریت خدمات** — لیست خدمات، سوالات متداول هر خدمت و گزینه‌های قیمت‌گذاری (`MyServices`)
- 💰 **مالی** — لیست پرداخت‌ها و تسویه‌ها (`payments-list`)
- 💬 **پیام‌رسانی داخلی** — صندوق پیام‌ها و گفتگوی متنی با مشتریان
- ⭐ **اعتبار حرفه‌ای** — رزومهٔ خدمات‌دهنده، نظرات و امتیازات مشتریان
- ⚡ **ارتباط لحظه‌ای** — Socket.IO برای دریافت سفارش‌ها و پیام‌های زنده + آپلود تکه‌تکهٔ فایل‌های حجیم (`chunked_uploader`)

## 🏗 معماری

ساختار لایه‌ای بر پایهٔ **GetX** با جداسازی کامل UI، منطق و مدل‌ها:

```
lib/
├── UI/
│   ├── Views/
│   │   ├── Register/    # ویزارد ثبت‌نام (فرم · تخصص · نقشه · آپلود · تایید)
│   │   ├── Main/        # داشبورد · کارها · پرداخت‌ها · پروفایل
│   │   ├── User/        # ورود · پیام‌ها · MyServices · MyTimes · نظرات
│   │   └── Components/  # ویجت‌های مشترک
│   └── ...
├── Logic/               # کنترلرهای GetX · Helpers · Models
└── main.dart
```

## 🛠 تکنولوژی‌ها

| لایه | ابزار |
| --- | --- |
| 📱 فریم‌ورک | Flutter 3 · Dart |
| 🧠 مدیریت حالت | GetX |
| 🌐 شبکه | dio · socket_io_client · chunked_uploader |
| 🗺 نقشه و مکان | flutter_map · geolocator · map_launcher |
| 🔔 پس‌زمینه و اعلان | flutter_background_service · awesome_notifications |
| 🖼 رسانه | image_picker · image_cropper · photo_view · assets_audio_player · flutter_svg |
| 💾 ذخیره‌سازی | shared_preferences · device_info_plus |

## 🚀 راه‌اندازی

```bash
git clone https://github.com/Mhabib70/VoddaProviders.git
cd VoddaProviders
flutter pub get
flutter run
```

</div>

---

<div dir="ltr">

## 🌍 English Summary

**Vodda Providers** — the provider-side Flutter app of the **Vodda** services marketplace (Persian, RTL). The customer-side app lives in [VoddaOld](https://github.com/Mhabib70/VoddaOld).

- 📝 **Provider onboarding wizard** — info form → specialties → map location → document/photo upload → approval.
- 📋 **Work dashboard** (`my-works`) with order documents and photos; 🗓 smart availability & weekly scheduling (`MyTimes`); 🛠 service management with FAQs and pricing options (`MyServices`).
- 💰 Payments & settlements list, 💬 in-app messaging with customers, ⭐ professional resume with customer reviews and ratings.
- ⚡ Real-time orders/messages over **Socket.IO** and chunked uploads for large files.
- 🧱 **Stack:** Flutter 3 · Dart · GetX (layered UI / Logic / Models) · dio · flutter_map + geolocator · flutter_background_service + awesome_notifications.

**Quick start:** `git clone` → `flutter pub get` → `flutter run`

</div>
