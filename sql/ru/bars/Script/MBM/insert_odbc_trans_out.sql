-- Вставка на отправку в ПЦ
begin
  Insert into BARS.OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('19', 'CL5', 1, 'PAYSAL', 0);
exception when dup_val_on_index then null;
end;
/