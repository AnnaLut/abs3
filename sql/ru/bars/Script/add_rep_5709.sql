BEGIN
   INSERT INTO app_rep (codeapp,
                        coderep,
                        approve,
                        grantor)
        VALUES ('BVBB',
                5709,
                1,
                SYS_CONTEXT ('bars_global', 'user_id'));
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/
commit;