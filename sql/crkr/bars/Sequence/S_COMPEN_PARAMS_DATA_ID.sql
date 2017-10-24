BEGIN
EXECUTE IMMEDIATE
'create sequence S_COMPEN_PARAMS_DATA_ID
minvalue 3
maxvalue 9999999999999999999999999999
start with 10
increment by 1
cache 20';
EXCEPTION WHEN OTHERS THEN
 IF (SQLCODE = -955)
   THEN NULL;
   ELSE RAISE;
 END IF;
END;
/