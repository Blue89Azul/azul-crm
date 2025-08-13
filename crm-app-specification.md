# CRM Mobile App MVP仕様書
*8月末完成目標 - 転職ポートフォリオ第1弾*

## プロジェクト概要

**目標:** 確実に動作するシンプルなモバイルCRMアプリ
**完成期限:** 8月31日
**開発時間:** 毎日2.5時間 × 3週間 = 52.5時間
**技術スタック:** Flutter Mobile, Laravel API, Firebase Auth, MySQL
**コンセプト:** 完璧よりも確実な完成を優先

---

## MVP機能スコープ（最小限）

### ✅ 含む機能
- 🔐 認証（ログイン・ログアウト）
- 👥 顧客管理（CRUD）
- 💼 商談管理（CRUD）  
- 📊 シンプルダッシュボード
- 🔄 API連携

### ❌ 後回し機能（将来追加）
- ~~オフライン対応~~
- ~~プッシュ通知~~
- ~~電話・メール連携~~
- ~~音声入力~~
- ~~位置情報~~
- ~~カメラ機能~~
- ~~複雑な分析機能~~

---

## 画面構成（シンプル版）

### 1. 認証画面
```
📱 ログイン画面
+---------------------------+
| CRM App                   |
|                          |
| Email: [____________]     |
| Password: [__________]    |
|                          |
| [    ログイン    ]        |
|                          |
| 新規登録はこちら           |
+---------------------------+
```

### 2. ダッシュボード（ホーム）
```
📱 ダッシュボード
+---------------------------+
| 今月の実績                 |
| 👥 顧客数: 25              |
| 💼 商談数: 12              |
| 💰 売上: ¥2,400,000        |
+---------------------------+
| [顧客管理] [商談管理]        |
| [ログアウト]               |
+---------------------------+
```

### 3. 顧客一覧
```
📱 顧客一覧
+---------------------------+
| 🔍 [検索ボックス]          |
+---------------------------+
| 田中太郎                   |
| ABC商事 | HOT             |
+---------------------------+
| 佐藤花子                   |
| DEF株式会社 | WARM         |
+---------------------------+
| [+] 新規顧客               |
+---------------------------+
```

### 4. 顧客詳細・編集
```
📱 顧客詳細
+---------------------------+
| 田中太郎                   |
|                          |
| 会社: [ABC商事_______]     |
| 電話: [090-1234-5678]     |
| Email: [tanaka@abc.com]   |
| ステータス: [HOT ▼]       |
|                          |
| [保存] [削除]             |
+---------------------------+
```

### 5. 商談一覧
```
📱 商談一覧  
+---------------------------+
| ABC商事システム導入        |
| ¥1,200,000 | 交渉中        |
+---------------------------+
| DEF新規プロジェクト        |
| ¥800,000 | 見込み          |
+---------------------------+
| [+] 新規商談               |
+---------------------------+
```

### 6. 商談詳細・編集
```
📱 商談詳細
+---------------------------+
| タイトル: [_____________] |
| 顧客: [田中太郎 ▼]        |
| 金額: [¥1,200,000]       |
| ステータス: [交渉中 ▼]     |
| 期日: [2024/09/30]       |
|                          |
| [保存] [削除]             |
+---------------------------+
```

---

## データモデル（シンプル版）

### User（ユーザー）
```dart
class User {
  String id;
  String name;
  String email;
  DateTime createdAt;
}
```

### Customer（顧客）
```dart
class Customer {
  String id;
  String name;           // 顧客名
  String company;        // 会社名
  String phone;          // 電話番号
  String email;          // メールアドレス
  String status;         // hot/warm/cold
  DateTime createdAt;
  DateTime updatedAt;
}
```

### Deal（商談）
```dart
class Deal {
  String id;
  String title;          // 商談タイトル
  String customerId;     // 関連顧客ID  
  double amount;         // 金額
  String status;         // lead/negotiation/won/lost
  DateTime expectedDate; // 期日
  DateTime createdAt;
  DateTime updatedAt;
}
```

---

## 技術構成（MVP版）

### フロントエンド
```
Flutter Mobile
├── 状態管理: Bloc/Cubit（シンプル版）
├── 認証: Firebase Auth
├── HTTP通信: Dio
├── ローカル状態: SharedPreferences
└── UI: Material Design
```

### バックエンド
```
Laravel API
├── 認証: Firebase Admin SDK
├── データベース: MySQL
├── API: RESTful（基本CRUD）
└── 展開: 開発環境のみ（Docker）
```

### データベース
```sql
-- users テーブル
CREATE TABLE users (
    id VARCHAR(255) PRIMARY KEY,  -- Firebase UID
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- customers テーブル
CREATE TABLE customers (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    company VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255),
    status ENUM('hot', 'warm', 'cold') DEFAULT 'warm',
    user_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- deals テーブル
CREATE TABLE deals (
    id VARCHAR(36) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    customer_id VARCHAR(36) NOT NULL,
    amount DECIMAL(15,2) DEFAULT 0,
    status ENUM('lead', 'negotiation', 'won', 'lost') DEFAULT 'lead',
    expected_date DATE,
    user_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

---

## API設計（最小限）

### 認証
```
POST /api/auth/verify    # Firebase トークン検証
```

### 顧客管理
```
GET    /api/customers           # 顧客一覧取得
POST   /api/customers           # 顧客作成
GET    /api/customers/{id}      # 顧客詳細取得
PUT    /api/customers/{id}      # 顧客更新
DELETE /api/customers/{id}      # 顧客削除
```

### 商談管理
```
GET    /api/deals               # 商談一覧取得
POST   /api/deals               # 商談作成
GET    /api/deals/{id}          # 商談詳細取得  
PUT    /api/deals/{id}          # 商談更新
DELETE /api/deals/{id}          # 商談削除
```

### ダッシュボード
```
GET    /api/dashboard           # 統計情報取得
```

---

## アプリ構成（Flutter）

### ディレクトリ構造
```
lib/
├── main.dart
├── app/
│   ├── app.dart              # MaterialApp設定
│   └── routes.dart           # ルーティング
├── core/
│   ├── constants/
│   │   └── api_constants.dart
│   ├── services/
│   │   ├── api_service.dart   # HTTP通信
│   │   └── auth_service.dart  # Firebase認証
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── cubit/
│   │   │   ├── auth_cubit.dart
│   │   │   └── auth_state.dart
│   │   └── screens/
│   │       └── login_screen.dart
│   ├── dashboard/
│   │   ├── cubit/
│   │   │   ├── dashboard_cubit.dart
│   │   │   └── dashboard_state.dart
│   │   └── screens/
│   │       └── dashboard_screen.dart
│   ├── customers/
│   │   ├── cubit/
│   │   │   ├── customers_cubit.dart
│   │   │   ├── customer_detail_cubit.dart
│   │   │   └── customers_state.dart
│   │   └── screens/
│   │       ├── customers_screen.dart
│   │       └── customer_detail_screen.dart
│   └── deals/
│       ├── cubit/
│       │   ├── deals_cubit.dart
│       │   ├── deal_detail_cubit.dart
│       │   └── deals_state.dart
│       └── screens/
│           ├── deals_screen.dart
│           └── deal_detail_screen.dart
├── shared/
│   ├── models/
│   │   ├── user.dart
│   │   ├── customer.dart
│   │   └── deal.dart
│   └── widgets/
│       ├── loading_widget.dart
│       └── error_widget.dart
└── theme/
    └── app_theme.dart
```

### 主要Cubit実装例
```dart
// auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  
  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess(user.user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(AuthInitial());
  }
}

// customers_cubit.dart
class CustomersCubit extends Cubit<CustomersState> {
  final ApiService _apiService;
  
  CustomersCubit(this._apiService) : super(CustomersInitial());
  
  Future<void> loadCustomers() async {
    emit(CustomersLoading());
    try {
      final customers = await _apiService.getCustomers();
      emit(CustomersLoaded(customers));
    } catch (e) {
      emit(CustomersError(e.toString()));
    }
  }
}
```

---

## 開発スケジュール（3週間）

### Week 1 (8/8-8/14): 基盤構築
**目標:** 認証機能完成

**フロントエンド (1.5時間/日):**
- Flutter プロジェクト作成
- Firebase設定
- AuthCubit実装
- ログイン画面UI作成

**バックエンド (1時間/日):**
- Laravel プロジェクト作成
- Docker環境構築  
- データベース設計・Migration
- Firebase Admin SDK設定

**完成目安:** ログイン→ダッシュボード遷移まで動作

---

### Week 2 (8/15-8/21): 顧客・商談管理
**目標:** CRUD機能完成

**フロントエンド (1.5時間/日):**
- 顧客一覧・詳細画面
- CustomersCubit・CustomerDetailCubit
- 商談一覧・詳細画面  
- DealsCubit・DealDetailCubit

**バックエンド (1時間/日):**
- 顧客管理API実装
- 商談管理API実装
- バリデーション設定

**完成目安:** 全てのCRUD操作が動作

---

### Week 3 (8/22-8/31): 統合・調整・完成
**目標:** 完全動作版

**統合テスト (1時間/日):**
- フロントエンド⟷API連携確認
- エラーハンドリング
- データ整合性チェック

**UI/UX改善 (1時間/日):**
- ローディング表示
- エラーメッセージ表示
- 基本的なデザイン調整

**最終調整 (30分/日):**
- バグ修正
- パフォーマンス確認
- README作成

**完成目安:** デモ可能な完全版CRMアプリ

---

## 成功の定義

### ✅ 最低限の成功基準
- [x] 認証機能が動作する
- [x] 顧客の追加・表示・編集・削除ができる
- [x] 商談の追加・表示・編集・削除ができる
- [x] 基本的な統計がダッシュボードに表示される
- [x] クラッシュしない安定動作

### 🎯 理想的な完成レベル
- [x] 上記 + きれいなUI
- [x] 適切なエラーハンドリング
- [x] スムーズなアニメーション
- [x] 検索・フィルタ機能

### 📈 転職活動での価値
- **Flutter Mobile開発経験**: 実証済み
- **API統合経験**: Laravel連携
- **状態管理経験**: Bloc/Cubit活用
- **Firebase経験**: 認証システム
- **実用的なビジネスアプリ**: CRM領域

---

## 将来の拡張計画（9月以降）

### Phase 2: 機能強化版
- オフライン対応（SQLite）
- プッシュ通知
- 検索・フィルタ強化

### Phase 3: プロダクション版  
- 電話・メール連携
- 位置情報・カメラ
- 高度な分析機能
- GCP本番展開

**重要:** まずはMVPを確実に完成させ、その後段階的に機能追加していく戦略

このMVP版なら**確実に8月末完成**し、転職ポートフォリオとして十分な価値を持ちます！🎯