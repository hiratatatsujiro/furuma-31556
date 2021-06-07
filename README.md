# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル
| Column             | Type    | Options     |
|--------------------|---------|-------------|
| nickname           | string  | null: false |
| email              | string  | null: false |
| password           | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_reading  | string  | null: false |
| first_name_reading | string  | null: false |
| birthday_year      | integer | null: false |
| birthday_month     | integer | null: false |
| birthday_day       | integer | null: false |

### Association
- has_many :items
- has_many :purchases

## items テーブル
| Column              | Type       | Options           |
|---------------------|------------|-------------------|
| name                | string     | null: false       |
| introduce           | text       | null: false       |
| category_id         | integer    | null: false       |
| status_id           | integer    | null: false       |
| pay_for_shopping_id | integer    | null: false       |
| delivery_area_id    | integer    | null: false       |
| days_to_ship_id     | integer    | null: false       |
| price               | integer    | null: false       |
| user                | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## purchases テーブル
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| user               | references | foreign_key: true |
| item               | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_information

## shipping_informations テーブル
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| postal_code        | string     | null: false       |
| prefecture_id      | integer    | null: false       |
| city               | string     | null: false       |
| house_number       | string     | null: false       |
| building           | string     |                   |
| phone_number       | integer    | null: false       |
| purchase           | references | foreign_key: true | 

### Association
- belongs_to :purchase