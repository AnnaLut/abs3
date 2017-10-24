/* Formatted on 06.09.2016 9:52:54 (QP5 v5.265.14096.38000) */
BEGIN
   INSERT INTO app_rep (codeapp,
                        coderep,
                        approve,
                        grantor)
        VALUES ('BVBB',
                5707,
                1,
                SYS_CONTEXT ('bars_global', 'user_id'));
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/
commit;