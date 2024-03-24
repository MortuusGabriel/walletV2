-- drop trigger `wallet`.`insert_update_amount`;

DELIMITER $$
create trigger `wallet`.`insert_update_amount` after insert on wallet.transactions for each row
BEGIN
select category_type into @type from wallet.categories where category_id = new.category_id limit 1;

select `value` into @trans_currency from wallet.currencies where currency_id = new.currency_id limit 1;
select `currency_id` into @wallet_currency_id from wallet.wallets where wallet_id = new.wallet_id limit 1;
select `value` into @wallet_currency from wallet.currencies where currency_id = @wallet_currency_id limit 1;

if @type = 1 then begin
update wallet.wallets set amount = (amount - new.value * (@trans_currency / @wallet_currency)), expense = (expense + new.value * (@trans_currency / @wallet_currency)) where wallet_id = new.wallet_id;
end; else begin
update wallet.wallets set amount = (amount + new.value * (@trans_currency / @wallet_currency)), income = (income + new.value * (@trans_currency / @wallet_currency)) where wallet_id = new.wallet_id;
end; end if;
END$$    
DELIMITER ;

-- drop trigger `wallet`.`delete_update_amount`;

DELIMITER $$
create trigger `wallet`.`delete_update_amount` after delete on wallet.transactions for each row
BEGIN
select category_type into @type from wallet.categories where category_id = old.category_id limit 1;

select `value` into @trans_currency from wallet.currencies where currency_id = old.currency_id limit 1;
select `currency_id` into @wallet_currency_id from wallet.wallets where wallet_id = old.wallet_id limit 1;
select `value` into @wallet_currency from wallet.currencies where currency_id = @wallet_currency_id limit 1;

if @type = 1 then begin
update wallet.wallets set amount = (amount + old.value * (@trans_currency / @wallet_currency)), expense = (expense - old.value * (@trans_currency / @wallet_currency)) where wallet_id = old.wallet_id;
end; else begin
update wallet.wallets set amount = (amount - old.value * (@trans_currency / @wallet_currency)), income = (income - old.value * (@trans_currency / @wallet_currency)) where wallet_id = old.wallet_id;
end; end if;
END$$    
DELIMITER ;

-- drop trigger `wallet`.`update_update_amount`;

DELIMITER $$
create trigger `wallet`.`update_update_amount` after update on wallet.transactions for each row
BEGIN
select category_type into @old_type from wallet.categories where category_id = old.category_id limit 1;

select `value` into @old_trans_currency from wallet.currencies where currency_id = old.currency_id limit 1;
select `currency_id` into @old_wallet_currency_id from wallet.wallets where wallet_id = old.wallet_id limit 1;
select `value` into @old_wallet_currency from wallet.currencies where currency_id = @old_wallet_currency_id limit 1;


select category_type into @new_type from wallet.categories where category_id = new.category_id limit 1;

select `value` into @trans_currency from wallet.currencies where currency_id = new.currency_id limit 1;
select `currency_id` into @wallet_currency_id from wallet.wallets where wallet_id = new.wallet_id limit 1;
select `value` into @wallet_currency from wallet.currencies where currency_id = @wallet_currency_id limit 1;

if @old_type = 1 then begin
update wallet.wallets set amount = (amount + old.value * (@old_trans_currency / @old_wallet_currency)), expense = (expense - old.value * (@old_trans_currency / @old_wallet_currency)) where wallet_id = old.wallet_id;
end; elseif @old_type = 0 then begin
update wallet.wallets set amount = (amount - old.value * (@old_trans_currency / @old_wallet_currency)), income = (income - old.value * (@old_trans_currency / @old_wallet_currency)) where wallet_id = old.wallet_id;
end; end if;

if @new_type = 1 then begin
update wallet.wallets set amount = (amount - new.value * (@trans_currency / @wallet_currency)), expense = (expense + new.value * (@trans_currency / @wallet_currency)) where wallet_id = new.wallet_id;
end; elseif @new_type = 0 then begin
update wallet.wallets set amount = (amount + new.value * (@trans_currency / @wallet_currency)), income = (income + new.value * (@trans_currency / @wallet_currency)) where wallet_id = new.wallet_id;
end; end if;
END$$
DELIMITER ;
