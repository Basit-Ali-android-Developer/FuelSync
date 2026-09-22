<h1 align="center">⛽ FuelSync</h1>
<p align="center">Enterprise-grade fuel station management app — digitizing shift reconciliation, tank dip auditing, and sales reporting.</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-1F3864?style=flat" />
  <img src="https://img.shields.io/badge/State-BLoC%2FCubit-purple?style=flat" />
  <img src="https://img.shields.io/badge/Offline--First-yes-brightgreen?style=flat" />
</p>

FuelSync replaces manual paper logbooks at fuel stations with guided, high-accuracy digital workflows — tracking fuel inventory, meter readings, shift reconciliation, and sales reporting in real time.

---

## 📱 Screenshots

<!--
Drag and drop your screenshots directly into this file while editing it on GitHub's
web editor — keep all images at a consistent width (e.g. width="200").
-->

<p align="center">
  <img src="screenshots/screenshot1.png" width="200" />
  <img src="screenshots/screenshot2.png" width="200" />
  <img src="screenshots/screenshot3.png" width="200" />
</p>

---

## ✨ Core Functionality

### 🔐 Authentication & Access Control
- Role-based access: Station Managers, Shift Operators/Attendants, Admin/Owners
- Station setup & configuration — assigned stations, active pumps, tanks, nozzles

### 🔄 Shift Management
**Opening:**
- Mandatory opening timestamp and operator registration
- Opening meter/totalizer reading per nozzle, with photo/numerical verification
- Initial cash drawer and float balance logging

**Closing & handover:**
- Closing meter/totalizer readings across all active nozzles
- Automatic gross volume calculation (closing − opening reading)
- Cash, card, POS, and credit account collections entry
- **Over/short (variance) calculation** — flags discrepancies between meter sales and logged collections

### ⛽ Tank Dip & Inventory Tracking
- Manual/digital dip readings (opening, mid-day, closing) per underground tank
- Automatic conversion of dip height → net volume using calibrated tank chart algorithms
- **Loss & gain auditing** — reconciles pump dispatch volume against physical tank drop to catch leaks, temperature expansion, or fuel theft

### 💰 Pricing & Sales Reporting
- Dynamic per-liter rate management across product categories (Super, Premium, Diesel, Auto Gas)
- Automated shift summary dashboard — total volume, gross revenue, collection breakdown, net profitability
- Exportable audit logs (PDF export / backend sync)

---

## 🏗️ Architecture

Clean Architecture with BLoC/Cubit for predictable, unidirectional data flow:

```
Presentation Layer   — Widgets, Screens, Cubits (Loading/Success/Failure/ValidationErr states)
        │
        ▼
Domain Layer         — Entities, Use Cases (CalculateVarianceUseCase, ConvertDipToVolumeUseCase),
        │               Repository interfaces
        ▼
Data Layer           — Repository implementations, local/remote data sources, JSON models
```

**UI/UX:** custom Material Design components, high-contrast responsive layouts built for outdoor/sunlight readability at the pump. Step-by-step guided wizard forms with strict validation (e.g. rejects a closing meter reading lower than the opening reading).

---

## 🌐 Networking & Offline-First Storage

- **Dio** for REST API communication — custom interceptors handle JWT auth, request retries, and unified error catching
- **Offline-first**: local caching (Room/SQLite or Hive/Isar) lets operators complete full shift openings, dip entries, and closings with zero internet connectivity
- **Background sync**: queued operations automatically sync once connectivity returns — critical for forecourts with unreliable signal

---

## 🛠️ Tech Stack

- **Framework:** Flutter (Dart) — Android & iOS
- **Architecture:** Clean Architecture
- **State Management:** BLoC / Cubit
- **Networking:** Dio, REST APIs, JWT
- **Local Storage:** Offline-first (Room/SQLite or Hive/Isar)
- **Sync:** Background queueing & auto-sync

---

## 🚀 Getting Started

```bash
git clone https://github.com/Basit-Ali-android-Developer/FuelSync.git
cd FuelSync
flutter pub get
flutter run
```

---

<p align="center"><i>Built and maintained by <a href="https://github.com/Basit-Ali-android-Developer">Basit Ali</a></i></p>
