BEGIN

   EXECUTE IMMEDIATE 'create table pfu.tmp_sec_log (sys_time timestamp,
                          log      varchar2(4000))';
EXCEPTION
   WHEN OTHERS
   THEN
      IF SQLCODE = 00955
      THEN
         NULL;
      END IF;
END;
/