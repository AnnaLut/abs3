begin
Insert into BARS.OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('10', 'OWS', 1, 'PAYACC1', 0);
  exception
    when dup_val_on_index then null;
end;
/
COMMIT;
