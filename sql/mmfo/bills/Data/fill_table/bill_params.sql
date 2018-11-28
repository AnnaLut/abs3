
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_BILL_PARAMS.sql =========***
PROMPT ===================================================================================== 

Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('ACN_2620','262038','Продукт для поточного рахунка клієнта для погашення векселів');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('ACN_2909','290985','Продукт для транзитного рахунка ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('ACN_9819','9819O4','Продукт для рахунка обліку векселів');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('BILL_SERVICE_URL','http://10.10.10.108:1036','URL сервиса для отправки в Казначейство');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('CRYPTO_URL','http://10.10.10.88:8001/bars.security/rest/','URL сервиса криптографических преобразований');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('LAST_STATUS_UPD_DATE','2018-07-20','Дата последнего обновления статусов от ДКСУ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('SIGN_STATUS','1','1 - робота з ЕЦП, 0 - ні');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('TREASURY_USER','TestBank1','Имя банковского пользователя в системе ДКСУ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('WALLET_PATH','//','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('WALLET_PWD','12345','');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_BILL_PARAMS.sql =========***
PROMPT ===================================================================================== 
