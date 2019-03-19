update teller_oper_define t
set t.sw_flag = 1
where t.oper_code in ('CN1','CN2','CUV','CNU','CN3','CN4');

update teller_oper_define 
  set need_req = 'IN'
  where oper_code = 'DPA';
