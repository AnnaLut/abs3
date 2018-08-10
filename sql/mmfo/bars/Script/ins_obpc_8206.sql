
insert into obpc_trans_out 
select 10, 'KK1',1,'PAYACC',1
  from dual
  where not exists (select 1 from obpc_trans_out where tt = 'KK1');

