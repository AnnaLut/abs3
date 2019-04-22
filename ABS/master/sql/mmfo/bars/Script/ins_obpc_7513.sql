--
insert into obpc_trans_out 
select tran_type, 'W4I',dk,w4_msgcode,pay_flag
  from obpc_trans_out 
  where tt = 'W4X' and not exists (select 1 from obpc_trans_out where tt = 'W4I');


--