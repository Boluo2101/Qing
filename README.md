<div align="center">

# Qing App

**一个功能丰富的跨平台 Flutter 应用 | A Feature-Rich Cross-Platform Flutter Application**

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?logo=flutter&logoColor=white)](https://flutter.dart.cn/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Riverpod](https://img.shields.io/badge/Riverpod-^2.6.1-00B894)](https://riverpod.dev/)
[![GoRouter](https://img.shields.io/badge/GoRouter-^12.1.0-FF6B6B)](https://github.com/flutter/packages/tree/main/packages/go_router)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20Android%20%7C%20Web%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux-9B59B6)](#)
[![License](https://img.shields.io/badge/License-Private-red.svg)](LICENSE)

<p align="center">
  <b><a href="#中文">中文</a> | <a href="#english">English</a></b>
</p>

</div>

---

<a name="中文"></a>
# 🇨🇳 中文

## 📖 项目简介

**Qing App (清)** 是一个基于 Flutter 构建的跨平台综合应用，集**学习、娱乐、3D 展示**于一体。从词汇闯关到 3D 模型展示，从音乐播放到数据可视化统计，Qing App 致力于提供多元化的移动端体验。

## ✨ 核心功能

### 📝 词汇学习 (Words)
- 基于书籍分类的词汇学习系统
- 支持滚动视差效果的书页切换
- 学习进度本地持久化存储
- 可自定义词汇书籍与分类

### 🎮 汽车游戏 (Game)
- 基于 160×80 网格开发的汽车主题小游戏
- 流畅的动画与交互体验
- 碰撞检测与游戏状态管理

### 🚗 3D 模型展示 (Car Showcase)
- 支持 GLB 格式 3D 模型渲染
- 炫酷载具合集：UFO、隐形战机、霸王锤、摩托车
- 模型旋转、缩放等交互控制

### 🎵 音乐播放 (Music)
- 基于 `just_audio` 的音频播放引擎
- 播放列表管理与播放控制

### 📊 数据统计 (Statistics)
- 多维度图表展示：折线图、饼图、柱状图、雷达图、堆叠柱状图
- 学习数据可视化分析
- 基于 `fl_chart` 的强大数据渲染

### 📅 日历 (Calendar)
- 学习打卡日历
- 每日学习记录与回顾

### 🏆 勋章系统 (Medal)
- 成就勋章解锁
- 学习里程碑激励

### 📚 书籍管理 (Books)
- 书籍分类管理
- 书籍详情与收藏功能

### 📷 摄像头 (Camera)
- 实时摄像头预览
- 基于 `camera` 插件的拍照功能

### 👤 个人中心 (Mine)
- 累计学习天数统计
- 铜板积分系统(233 铜板)
- 我的日历、学习记录、能量值
- 我的收藏、勋章展示
- 设置与反馈入口

### 🏅 排行榜 (Ranking)
- 学习排名展示
- 好友/用户间竞争机制

## 🛠 技术栈

| 类别 | 技术选型 |
|------|---------|
| **框架** | Flutter 3.8.1+ / Dart 3.0+ |
| **状态管理** | Riverpod ^2.6.1 (含 riverpod_generator) |
| **路由管理** | GoRouter ^12.1.0 |
| **数据持久化** | SharedPreferences |
| **网络请求** | http ^1.1.0 |
| **图表** | fl_chart ^0.65.0 |
| **3D 渲染** | model_viewer_plus ^1.8.0 |
| **音频播放** | just_audio ^0.9.30 |
| **视频播放** | video_player ^2.10.1 |
| **相机** | camera ^0.10.5+5 |
| **图片缓存** | cached_network_image ^3.4.1 |
| **日期处理** | jiffy ^5.0.0 |
| **唯一标识** | uuid ^4.5.1 |

## 📁 项目结构

```
lib/
├── main.dart                 # 应用入口、路由配置、底部导航
├── components/               # 通用组件
│   ├── footer_tabs.dart      # 底部导航栏
│   ├── header_bar.dart       # 顶部导航栏
│   ├── tabs.dart             # 标签组件
│   └── business/             # 业务组件
│       └── book_item.dart    # 书籍卡片
├── configs/                  # 配置文件
│   └── configs.dart          # 全局配置
├── providers/                # Riverpod 状态管理
│   └── books.dart            # 书籍数据状态
├── routes/                   # 路由配置
│   └── index.dart            # 路由定义
├── services/                 # 服务层
│   └── books_service.dart    # 书籍 API 服务
├── tools/                    # 工具类
│   ├── shared_preferences_util.dart  # 本地存储工具
│   ├── custom_colors.dart    # 自定义颜色
│   └── color_extractor.dart  # 颜色提取工具
└── views/                    # 页面视图
    ├── words/                # 词汇学习
    ├── game/                 # 汽车游戏
    ├── car/                  # 3D 模型展示
    ├── music/                # 音乐播放
    ├── statistics/           # 数据统计(图表)
    ├── calendar/             # 日历
    ├── medal/                # 勋章系统
    ├── books/                # 书籍管理
    ├── camera/               # 摄像头
    ├── mine/                 # 个人中心
    ├── ranking/              # 排行榜
    ├── cars/                 # 汽车列表/视频
    ├── course/               # 课程详情
    ├── settings/             # 设置
    ├── feedback/             # 反馈
    └── common/               # 通用页面(404)
```

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 3.8.1
- Dart SDK >= 3.0
- iOS: Xcode 15+ (iOS 12+)
- Android: Android Studio Hedgehog+ (API 21+)

### 安装运行

```bash
# 克隆项目
git clone git@github.com:Boluo2101/Qing.git
cd Qing

# 安装依赖
flutter pub get

# 代码生成 (Riverpod generator)
flutter pub run build_runner build --delete-conflicting-outputs

# 运行项目
flutter run

# 构建 Web 版本
flutter build web --release \
  --base-href "/qing/" \
  --dart-define=FLUTTER_WEB_CANVASKIT_URL=/qing/canvaskit/
```

## 🌐 平台支持

| 平台 | 状态 |
|------|------|
| iOS | ✅ |
| Android | ✅ |
| Web | ✅ |
| macOS | ✅ |
| Windows | ✅ |
| Linux | ✅ |

## 📄 许可证

Private License - 保留所有权利

---

<a name="english"></a>
# 🇺🇸 English

## 📖 Overview

**Qing App (清)** is a cross-platform comprehensive application built with Flutter, integrating **learning, entertainment, and 3D visualization**. From vocabulary challenges to 3D model showcases, from music playback to data visualization, Qing App is dedicated to providing a diverse mobile experience.

## ✨ Core Features

### 📝 Vocabulary Learning (Words)
- Book-based vocabulary learning system
- Parallax scrolling effect for page transitions
- Local persistence of learning progress
- Customizable vocabulary books and categories

### 🎮 Car Game (Game)
- Car-themed mini-game built on a 160×80 grid
- Smooth animations and interactive experience
- Collision detection and game state management

### 🚗 3D Model Showcase (Car Showcase)
- GLB format 3D model rendering
- Stunning vehicle collection: UFO, Stealth Fighter, War Hammer, Motorcycle
- Interactive model rotation and zoom controls

### 🎵 Music Player (Music)
- Audio playback engine powered by `just_audio`
- Playlist management and playback controls

### 📊 Statistics (Statistics)
- Multi-dimensional chart displays: Line, Pie, Bar, Radar, Stacked Bar
- Learning data visualization and analysis
- Powered by `fl_chart` for robust data rendering

### 📅 Calendar (Calendar)
- Study check-in calendar
- Daily learning records and reviews

### 🏆 Medal System (Medal)
- Achievement medal unlocking
- Learning milestone incentives

### 📚 Book Management (Books)
- Book category management
- Book details and favorites

### 📷 Camera (Camera)
- Real-time camera preview
- Photo capture powered by `camera` plugin

### 👤 Profile (Mine)
- Cumulative study days tracking
- Copper coin points system (233 coins)
- My calendar, study records, energy points
- My favorites and medal display
- Settings and feedback entry

### 🏅 Leaderboard (Ranking)
- Study ranking display
- Competition mechanism among friends/users

## 🛠 Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter 3.8.1+ / Dart 3.0+ |
| **State Management** | Riverpod ^2.6.1 (with riverpod_generator) |
| **Routing** | GoRouter ^12.1.0 |
| **Persistence** | SharedPreferences |
| **Networking** | http ^1.1.0 |
| **Charts** | fl_chart ^0.65.0 |
| **3D Rendering** | model_viewer_plus ^1.8.0 |
| **Audio** | just_audio ^0.9.30 |
| **Video** | video_player ^2.10.1 |
| **Camera** | camera ^0.10.5+5 |
| **Image Cache** | cached_network_image ^3.4.1 |
| **Date/Time** | jiffy ^5.0.0 |
| **UUID** | uuid ^4.5.1 |

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry, routing, bottom navigation
├── components/               # Shared components
│   ├── footer_tabs.dart      # Bottom navigation bar
│   ├── header_bar.dart       # Top navigation bar
│   ├── tabs.dart             # Tab component
│   └── business/             # Business components
│       └── book_item.dart    # Book card
├── configs/                  # Configuration
│   └── configs.dart          # Global config
├── providers/                # Riverpod state management
│   └── books.dart            # Books data state
├── routes/                   # Routing
│   └── index.dart            # Route definitions
├── services/                 # Service layer
│   └── books_service.dart    # Books API service
├── tools/                    # Utilities
│   ├── shared_preferences_util.dart  # Local storage utility
│   ├── custom_colors.dart    # Custom colors
│   └── color_extractor.dart  # Color extraction tool
└── views/                    # Page views
    ├── words/                # Vocabulary learning
    ├── game/                 # Car game
    ├── car/                  # 3D model showcase
    ├── music/                # Music player
    ├── statistics/           # Statistics (charts)
    ├── calendar/             # Calendar
    ├── medal/                # Medal system
    ├── books/                # Book management
    ├── camera/               # Camera
    ├── mine/                 # Profile
    ├── ranking/              # Leaderboard
    ├── cars/                 # Car list / video
    ├── course/               # Course detail
    ├── settings/             # Settings
    ├── feedback/             # Feedback
    └── common/               # Common pages (404)
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.8.1
- Dart SDK >= 3.0
- iOS: Xcode 15+ (iOS 12+)
- Android: Android Studio Hedgehog+ (API 21+)

### Installation & Run

```bash
# Clone the repository
git clone git@github.com:Boluo2101/Qing.git
cd Qing

# Install dependencies
flutter pub get

# Code generation (Riverpod generator)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Build for Web
flutter build web --release \
  --base-href "/qing/" \
  --dart-define=FLUTTER_WEB_CANVASKIT_URL=/qing/canvaskit/
```

## 🌐 Platform Support

| Platform | Status |
|----------|--------|
| iOS | ✅ |
| Android | ✅ |
| Web | ✅ |
| macOS | ✅ |
| Windows | ✅ |
| Linux | ✅ |

## 📄 License

Private License - All Rights Reserved

---

<div align="center">

**Made with ❤️ using Flutter**

</div>
