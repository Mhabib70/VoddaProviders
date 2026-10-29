<div dir="rtl">

# Vodda Providers — اپلیکیشن سمت خدمات‌دهنده

<p align="center">
  <img src="assets/images/splash.png" width="140" alt="Vodda Providers" />
</p>

اپلیکیشن خدمات‌دهندگان پلتفرم **Vodda** — ثبت‌نام با احراز مدارک، مدیریت خدمات و نوبت‌ها، پیام‌رسانی با مشتریان و مشاهده درآمد.

> 📱 این ریپو **سمت خدمات‌دهنده** است؛ اپلیکیشن سمت مشتری در ریپوی [VoddaOld](https://github.com/Mhabib70/VoddaOld) نگهداری می‌شود.

---

## ✨ امکانات

- **ثبت‌نام خدمات‌دهنده (ویزارد کامل)** — فرم اطلاعات ← انتخاب تخصص‌ها ← تعیین موقعیت روی نقشه ← آپلود مدارک و تصاویر ← تایید
- **داشبورد مدیریت کار** — فهرست کارها (`my-works`)، جزئیات هر کار، اسناد سفارش‌ها و تصاویر
- **زمان‌بندی هوشمند** — تعیین زمان‌های آزاد، زمان‌بندی هفتگی و تعطیلات (`MyTimes`)
- **مدیریت خدمات** — لیست خدمات، سوالات متداول هر خدمت و گزینه‌های قیمت‌گذاری (`MyServices`)
- **مالی** — لیست پرداخت‌ها و تسویه‌ها (`payments-list`)
- **پیام‌رسانی داخلی** — صندوق پیام‌ها و گفتگوی متنی با مشتریان
- **اعتبار حرفه‌ای** — رزومه خدمات‌دهنده، نظرات و امتیازات مشتریان
- **ارتباط لحظه‌ای** — Socket.IO برای دریافت سفارش‌ها و پیام‌های زنده + آپلود تکه‌تکه فایل‌های حجیم (`chunked_uploader`)

## 🏗 معماری

ساختار لایه‌ای بر پایه **GetX**:

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
| فریم‌ورک | Flutter 3 · Dart |
| مدیریت حالت | GetX |
| شبکه | dio · socket_io_client · chunked_uploader |
| نقشه و مکان | flutter_map · geolocator · map_launcher |
| پس‌زمینه و اعلان | flutter_background_service · awesome_notifications |
| رسانه | image_picker · image_cropper · photo_view · assets_audio_player · flutter_svg |
| ذخیره‌سازی | shared_preferences · device_info_plus |

## 🚀 راه‌اندازی

```bash
git clone https://github.com/Mhabib70/VoddaProviders.git
cd VoddaProviders
flutter pub get
flutter run
```

</div>
