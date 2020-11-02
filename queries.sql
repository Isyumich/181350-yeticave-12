--Заполнение таблицы category
INSERT INTO category (name, symbol_code) VALUES ('Доски и лыжи','boards');
INSERT INTO category (name, symbol_code) VALUES ('Крепления','attachment');
INSERT INTO category (name, symbol_code) VALUES ('Ботинки','boots');
INSERT INTO category (name, symbol_code) VALUES ('Одежда','clothing');
INSERT INTO category (name, symbol_code) VALUES ('Инструменты','tools');
INSERT INTO category (name, symbol_code) VALUES ('Разное','other');

--Заполнение таблицы пользователей
insert INTO user (register_date, email, name, password, contact) VALUES
('2020-10-27 12 −00 −00','user1@gmail.com','user1','qwerty1','+79991112233');
insert INTO user (register_date, email, name, password, contact) VALUES
('2020-10-26 12 −00 −00','user2@gmail.com','user2','qwerty2','+79991112233');

--Заполнение таблицы пользователей
insert INTO lot (create_date, name, description, picture, start_price,
 end_date, bid_step, author, winner, category_id) VALUES
 ('2020-10-10 12 −00 −00', '2014 Rossignol District Snowboard', 'Шаблон описания',
 'img/lot-1.jpg', 10999, '2020-10-23', 10, select id from user where name = 'user1',
 select id from user where name = 'user2', select id from category where name = 'Доски и лыжи');

--Заполнение таблицы с лотами
insert INTO lot (create_date, name, description, picture, start_price,
 end_date, bid_step, author, winner, category_id) VALUES
 ('2020-10-11 12 −00 −00', 'DC Ply Mens 2016/2017 Snowboard',
 'img/lot-2.jpg', 159999, '2020-10-24', 10, select id from user where name = 'user1',
 select id from user where name = 'user2', select id from category where name = 'Доски и лыжи');

 insert INTO lot (create_date, name, description, picture, start_price,
 end_date, bid_step, author, winner, category_id) VALUES
 ('2020-10-12 12 −00 −00', 'Крепления Union Contact Pro 2015 года размер L/XL', 'Шаблон описания',
 'img/lot-3.jpg', 8000, '2020-10-25', 10, select id from user where name = 'user1',
 select id from user where name = 'user2', select id from category where name = 'Крепления');

 insert INTO lot (create_date, name, description, picture, start_price,
 end_date, bid_step, author, winner, category_id) VALUES
 ('2020-10-13 12 −00 −00', 'Ботинки для сноуборда DC Mutiny Charocal', 'Шаблон описания',
 'img/lot-4.jpg', 10999, '2020-10-26', 10, select id from user where name = 'user1',
 select id from user where name = 'user2', select id from category where name = 'Ботинки');

 insert INTO lot (create_date, name, description, picture, start_price,
 end_date, bid_step, author, winner, category_id) VALUES
 ('2020-10-14 12 −00 −00', 'Куртка для сноуборда DC Mutiny Charocal', 'Шаблон описания',
 'img/lot-5.jpg', 7500, '2020-10-27', 10, select id from user where name = 'user1',
 select id from user where name = 'user2', select id from category where name = 'Одежда');

 insert INTO lot (create_date, name, description, picture, start_price,
 end_date, bid_step, author, winner, category_id) VALUES
 ('2020-10-15 12 −00 −00', 'Маска Oakley Canopy', 'Шаблон описания',
 'img/lot-6.jpg', 5400, '2020-10-28', 10, select id from user where name = 'user1',
 select id from user where name = 'user2', select id from category where name = 'Разное');

--Заполнение таблицы со ставками
insert INTO bid (date, amount, user_id, lot_id) VALUES ('2020-10-10 14 −00 −00',
11009, select id from user where name = 'user2', select id from lot where name =
'Маска Oakley Canopy');
insert INTO bid (date, amount, user_id, lot_id) VALUES ('2020-10-10 15 −00 −00',
11019, select id from user where name = 'user1', select id from lot where name =
'Маска Oakley Canopy');

--Получение всех категорий
select name from category;

--Получение новых лотов
select l.name, l.start_price, l.picture, b.amount, c.name
from lot l join bid b on b.lot_id = l.id join category c on c.id = l.category_id
where l.end_date > sysdate;

--Показать лот по его id
select l.*, c.name from lot l join category c on c.id = l.category_id
where id = 1;

--Обновить название лота по его идентификатора
update lot
set name = 'New name'
where id = 1;

--Получить список ставок для лота
select * from bid
where lot_id = 1
order by date;


/*
Вопросы:
1) Правильно ли я сделал заполнение внешних ключей в таблицах? Ничего толкового про инсерт в таких случаях я не нашел,
может быть есть какая-то статья про это, с удовольствием бы почитал.

2) В запросе получения новых лотов. Текущая цена - это либо стартовая цена, либо цена из таблицы ставок по этому товару,
 если они есть. Я так понимаю, тут нужно будет использовать case. И вот вопрос, как написать в запросе так, чтобы
 программа проверяла в таблице ставок именно этот лот, который отобрался сейчас?
 */