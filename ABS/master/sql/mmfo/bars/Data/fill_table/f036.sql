begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (0, 'Єдина - У разі якщо застосовується один тип процентної ставки протягом всього терміну дії договору', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (1, 'Перша - У разі якщо протягом всього терміну дії договору застосовуються два розміри процентної ставки (перша ставка)', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (2, 'Друга - У разі якщо протягом всього терміну дії договору застосовуються два розміри процентної ставки (друга ставка)', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (3, 'Інше - У разі якщо протягом всього терміну дії договору застосовуються декілька процентних ставок (надаються усі відповідно до періодів зазначених НРП 10_1 та НРП 10_2)', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;