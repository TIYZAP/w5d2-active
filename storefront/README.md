# w5d2-active

#1) How many users are there?

`[1] pry(main)> User.count
   (0.3ms)  SELECT COUNT(*) FROM "users"
=> 50`

#2) What are the 5 most expensive items?

`[2] pry(main)> Item.order(price: :desc).limit(5)
  Item Load (0.7ms)  SELECT  "items".* FROM "items" ORDER BY "items"."price" DESC LIMIT ?  [["LIMIT", 5]]`

#3) What's the cheapest book?

`[3] pry(main)> Item.where(category: "Books").order(:price).first
  Item Load (0.3ms)  SELECT  "items".* FROM "items" WHERE "items"."category" = ? ORDER BY "items"."price" ASC LIMIT ?  [["category", "Books"], ["LIMIT", 1]]`

#4) Who lives at "6439 Zetta Hills, Willmouth, WY"? Do they have another address?

[4] pry(main)> Address.where(street: "6439 Zetta Hills")
  Address Load (0.2ms)  SELECT "addresses".* FROM "addresses" WHERE "addresses"."street" = ?  [["street", "6439 Zetta Hills"]]
=> [#<Address:0x007ff69fe3bc80 id: 43, user_id: 40, street: "6439 Zetta Hills", city: "Willmouth", state: "WY", zip: 15029>]

[5] pry(main)> User.where(id: "40")
  User Load (0.2ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ?  [["id", 40]]
=> [#<User:0x007ff69fd33a90 id: 40, first_name: "Corrine", last_name: "Little", email: "rubie_kovacek@grimes.net">]

[6] pry(main)> Address.joins(:user).where('users.first_name' => 'Corrine', 'users.last_name' => 'Little')
  Address Load (0.4ms)  SELECT "addresses".* FROM "addresses" INNER JOIN "users" ON "users"."id" = "addresses"."user_id" WHERE "users"."first_name" = ? AND "users"."last_name" = ?  [["first_name", "Corrine"], ["last_name", "Little"]]
=> [#<Address:0x007ff69fb19958 id: 43, user_id: 40, street: "6439 Zetta Hills", city: "Willmouth", state: "WY", zip: 15029>,
 #<Address:0x007ff69fb493b0 id: 44, user_id: 40, street: "54369 Wolff Forges", city: "Lake Bryon", state: "CA", zip: 31587>]

#5 Correct Virginie Mitchell's address to "New York, NY, 10108".

`[7] pry(main)> User.where(last_name: "Mitchell")
  User Load (0.2ms)  SELECT "users".* FROM "users" WHERE "users"."last_name" = ?  [["last_name", "Mitchell"]]
=> [#<User:0x007f81a734b7c0 id: 39, first_name: "Virginie", last_name: "Mitchell", email: "daisy.crist@altenwerthmonahan.biz">]
`
`[8] pry(main)> Address.where(id: "39")
  Address Load (0.4ms)  SELECT "addresses".* FROM "addresses" WHERE "addresses"."id" = ?  [["id", 39]]
=> [#<Address:0x007f81a7220eb8 id: 39, user_id: 37, street: "7503 Cale Grove", city: "Robertoshire", state: "PA", zip: 49744>]
`
`[9] pry(main)> Address.where(id: "39").update(city: "New York", state: "NY", zip: 10108)`

`[10] pry(main)> Address.where(id: "39")
  Address Load (0.1ms)  SELECT "addresses".* FROM "addresses" WHERE "addresses"."id" = ?  [["id", 39]]
=> [#<Address:0x007f81aab5f6e8 id: 39, user_id: 37, street: "7503 Cale Grove", city: "New York", state: "NY", zip: 10108>]`

#6) How much would it cost to buy one of each tool?

`[11] pry(main)> Item.where('category like ?', '%Tool%').sum :price
   (0.3ms)  SELECT SUM("items"."price") FROM "items" WHERE (category like '%Tool%')
=> 46477`

#7) How much was spent on books?


`[18] pry(main)> spent = Item.where('category like ?', '%Book%').collect do |item|
[18] pry(main)*   item.price * item.orders.sum(:quantity)
[18] pry(main)* end`


`[19] pry(main)> spent.inject(0, :+)
=> 1081352`

#8) Simulate buying an item by inserting a User for yourself and an Order for that User.


`[20] pry(main)> User.create(first_name: "Zachary", last_name: "Pinner", email: "zapinner@gmail.com")
   (0.1ms)  begin transaction
  SQL (2.6ms)  INSERT INTO "users" ("first_name", "last_name", "email") VALUES (?, ?, ?)  [["first_name", "Zachary"], ["last_name", "Pinner"], ["email", "zapinner@gmail.com"]]
   (3.4ms)  commit transaction
=> #<User:0x007ff69cc4e628 id: 51, first_name: "Zachary", last_name: "Pinner", email: "zapinner@gmail.com">
`

`[21] pry(main)> Order.create(user_id: "51", item_id: "21", quantity: "5", created_at: "2016-02-08 00:00:00.000000")
   (0.1ms)  begin transaction
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 51], ["LIMIT", 1]]
  Item Load (0.1ms)  SELECT  "items".* FROM "items" WHERE "items"."id" = ? LIMIT ?  [["id", 21], ["LIMIT", 1]]
  SQL (0.3ms)  INSERT INTO "orders" ("user_id", "item_id", "quantity", "created_at") VALUES (?, ?, ?, ?)  [["user_id", 51], ["item_id", 21], ["quantity", 5], ["created_at", 2016-02-08 00:00:00 UTC]]
   (2.7ms)  commit transaction
=> #<Order:0x007ff69ff40798 id: 378, user_id: 51, item_id: 21, quantity: 5, created_at: Mon, 08 Feb 2016 00:00:00 UTC +00:00>`
