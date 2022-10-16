# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| first_name         | string              | null: false               |
| last_name          | string              | null: false               |
| first_name_k       | string              | null: false               |
| last_name_k        | string              | null: false               |
| date_of_birth      | date                | null: false               |

### Association

* has_many :items
* has_many :orders


## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| name                                | string     | null: false                    |
| text                                | text       | null: false                    |
| category_id                         | integer    | null: false                    |
| condition_id                        | integer    | null: false                    |
| delivery_fee_id                     | integer    | null: false                    |
| prefecture_id                       | integer    | null: false                    |
| delivery_day_id                     | integer    | null: false                    |
| price                               | integer    | null: false                    |
| user                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :category_id
- belongs_to :condition_id
- belongs_to :delivery_fee_id
- belongs_to :prefecture_id
- belongs_to :delivery_day_id
* has_one:order

## orders table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses table

| Column          | Type       | Options                        |
|---------------- |------------|--------------------------------|
| postal_cord     | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| building        | string     |                                |
| phone_number    | string     | null: false                    |
| order_id        | integer    | null: false, foreign_key: true |

### Association

- belongs_to :order