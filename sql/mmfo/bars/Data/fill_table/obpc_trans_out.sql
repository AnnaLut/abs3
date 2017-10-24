delete from OBPC_TRANS_OUT where tt in('OW4','PKD','PKF');
Insert into OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('20', 'OW4', 0, 'PAYFACC4', 0);
Insert into OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('20', 'PKD', 0, 'PAYFACC4', 1);
Insert into OBPC_TRANS_OUT
   (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
 Values
   ('20', 'PKF', 0, 'PAYFACC4', 0);
update OBPC_TRANS_OUT set PAY_FLAG=1 where tt in('W4E','W4G','W4F','W42','W41','PKU','PKQ');
COMMIT;