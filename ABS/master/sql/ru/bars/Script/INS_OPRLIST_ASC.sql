BEGIN
   INSERT INTO BARS.OPERLIST_ACSPUB (FUNCNAME, FRONTEND)
        VALUES ('/barsroot/customerlist/custacc.aspx\S*', 1);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
     NULL;
END;
/

COMMIT;