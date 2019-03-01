Begin
   INSERT INTO OW_MSGCODE(MSGCODE,DK,SYNTHCODE) VALUES ('PAYSUB',1,'PAYSUB');
    exception when dup_val_on_index then null;
end;
/
COMMIT;

Begin
   INSERT INTO OBPC_TRANS_OUT(TRAN_TYPE,TT,DK,W4_MSGCODE,PAY_FLAG) VALUES ('1X','PXS',1,'PAYSUB',0);
    exception when dup_val_on_index then null;
end;
/
COMMIT;

Begin
   INSERT INTO SOCIAL_FILE_TYPES(TYPE_ID,TYPE_NAME,SK_ZB,TT) VALUES (6,'Субсидія',87,'PXS');
    exception when dup_val_on_index then null;
end;
/
COMMIT;



Begin
   INSERT INTO SOCIAL_AGENCY_TYPE(TYPE_ID,TYPE_NAME,TARIF_ID) VALUES (8,'Пенсійний Фонд (СУБСИДІЯ)',null);
    exception when dup_val_on_index then 
       UPDATE SOCIAL_AGENCY_TYPE 
          SET TYPE_NAME = 'Пенсійний Фонд (СУБСИДІЯ)'
        WHERE TYPE_ID = 8;
end;
/
COMMIT;

Begin
   INSERT INTO SOCIAL_AGENCY_ACCTYPES(AGNTYPE,ACCTYPE,ACCMASK,ACCNAME) VALUES (8,'C','2909','Кред.заборг.');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SOCIAL_AGENCY_ACCTYPES(AGNTYPE,ACCTYPE,ACCMASK,ACCNAME) VALUES (8,'K','2909','Кред.заборг.');
    exception when dup_val_on_index then null;
end;
/
COMMIT;