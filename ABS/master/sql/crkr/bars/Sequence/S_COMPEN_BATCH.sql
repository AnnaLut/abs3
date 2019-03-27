BEGIN
EXECUTE IMMEDIATE
'CREATE SEQUENCE  BARS.S_COMPEN_BATCH  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE';
EXCEPTION WHEN OTHERS THEN
 IF (SQLCODE = -955)
   THEN NULL;
   ELSE RAISE;
 END IF;
END;
/