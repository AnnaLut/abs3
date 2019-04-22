update SW_TT_OPER t
  set t.id =2
where t.id=5
  and t.tt = 'CNU';

commit;
/