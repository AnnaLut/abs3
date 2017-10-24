begin
  tuda;
  bpa.disable_policies('OW_SALARY_DATA');

  
  update OW_SALARY_DATA t
     set kf = sys_context('bars_context', 'user_mfo')
   where kf is null;
  bpa.enable_policies('OW_SALARY_DATA');             
  suda;
end;
/
commit;

