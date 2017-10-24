begin 
  while BARS.GLB_BANKDATE() < trunc(sysdate) loop
    CHANGE_BANKING_DATE;
    commit; 
  end loop;
end;
/