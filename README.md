# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| id                 | string              | null: false, unique: true |
| name               | string              | null: false, unique: true |
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| name               | string              | null: false               |
| introduction       | text                | null: false               |
| address            | text                | null: false               |
| date of birth      | text                | null: false               |

### Association

* has_many :items
* has_many :comments
* has_many :tags

## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| name                                | string     | null: false                    |
| postage                             | text       | null: false                    |
| shopping                            | text       | null: false                    |
| price                               | text       | null: false                    |
| region                              | text       | null: false                    |
| saler_id                            | references | null: false, foreign_key: true |
| buyer_id                            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :tags

## comments table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| content     | text       | null: false                    |
| item        | references | null: false, foreign_key: true |
| saler_id    | references | null: false, foreign_key: true |
| buyer_id    | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user

## tags table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| content     | text       | null: false                    |
| item        | references | null: false, foreign_key: true |
| saler_id    | references | null: false, foreign_key: true |
| buyer_id    | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user