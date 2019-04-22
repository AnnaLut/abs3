begin
Insert into BARS.OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('10', 'RKP', 1, 'PAYACC', 0);
exception when dup_val_on_index then null;   
end;
/
begin
Insert into BARS.OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('20', 'F4W', 0, 'PAYFACC2', 0);
exception when dup_val_on_index then null;   
end;
/
begin
Insert into BARS.OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('20', 'G4W', 0, 'PAYFACC3', 1);
 exception when dup_val_on_index then null;  
end;
/  
COMMIT;
