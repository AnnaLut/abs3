
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_BILL_PARAMS.sql =========***
PROMPT ===================================================================================== 

Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('ACN_2620','262038','������� ��� ��������� ������� �볺��� ��� ��������� �������');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('ACN_2909','290985','������� ��� ����������� ������� ');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('ACN_9819','9819O4','������� ��� ������� ����� �������');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('BILL_SERVICE_URL','http://10.10.10.108:1036','URL ������� ��� �������� � ������������');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('CRYPTO_URL','http://10.10.10.88:8001/bars.security/rest/','URL ������� ����������������� ��������������');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('LAST_STATUS_UPD_DATE','2018-07-20','���� ���������� ���������� �������� �� ����');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('SIGN_STATUS','1','1 - ������ � ���, 0 - �');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BILL_PARAMS(PAR,VAL,COMM) VALUES ('TREASURY_USER','TestBank1','��� ����������� ������������ � ������� ����');
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
