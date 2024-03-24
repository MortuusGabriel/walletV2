USE wallet;
insert into wallets (user_id, currency_id, name, `limit`, is_hide) values
(1, 1, 'wallet',  20000, false),
(1, 1, 'wallet2',  300000, false),
(2, 2, 'кошелок',  NULL, false),
(2, 1, 'кошелок2',  10000000, false),
(2, 1, 'кошелок3',  400, false);
SELECT * FROM wallet.wallets;
-- alter table wallets alter column is_hide SET DEFAULT false;
