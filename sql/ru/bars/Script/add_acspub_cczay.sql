begin
Insert into BARS.OPERLIST_ACSPUB
   (FUNCNAME, FRONTEND)
 Values
   ('/barsroot/credit/cck_zay.aspx\S*', 1);
EXCEPTION
  WHEN dup_val_on_index THEN
    NULL;
END;
/

commit;