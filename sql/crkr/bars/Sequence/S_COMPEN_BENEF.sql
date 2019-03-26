BEGIN
EXECUTE IMMEDIATE
'create sequence S_COMPEN_BENEF
minvalue 1000000000
maxvalue 9999999999999999999999999999
start with 1000000001
increment by 1
cache 20';
EXCEPTION WHEN OTHERS THEN
 IF (SQLCODE = -955)
   THEN NULL;
   ELSE RAISE;
 END IF;
END;
/