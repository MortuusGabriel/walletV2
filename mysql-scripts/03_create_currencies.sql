USE wallet;
insert into currencies (`name`, `value`, `is_up`, `icon`, `full_name`, `full_list_name`) values
('RUB', 0, true, 'asdasd', 'RUBLE', 'RUBLE'), 
('USD', 79.45, true, 'asdasdas', 'US DOLLAR', 'US DOLLAR'),
('EUR', 86.43, false, 'asdasddsa', 'EURO', 'EURO');
SELECT * FROM wallet.currencies;
-- alter table currencies modify column value float NULL;
