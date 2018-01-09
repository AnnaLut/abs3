declare 
  l_cnt pls_integer := 0;
begin 
  logger.info('CP Script start');
  bc.go(300465); 
  for i in 2005..2017 loop
    logger.info('CP Script YEAR '||i);  
    for cur in (select * from bars.oper o where o.pdat between to_date('01.01.'||i,'DD.MM.YYYY') and to_date('31.12.'||i,'DD.MM.YYYY') and o.vob is null and o.tt = 'FX7' and o.kf = '300465') 
    loop
      l_cnt := l_cnt + 1;
      update bars.oper o set o.vob = decode(cur.kv, 980, 6, 16) where o.ref = cur.ref;
    end loop;    
    commit;
  end loop;  
  bc.home;  
  logger.info('CP Script end OK. oper.vob change '||l_cnt);  
  dbms_output.put_line('CP Script end OK. oper.vob change '||l_cnt);  
  exception
    when others then
      bc.home;
      logger.info('CP Script end with error: '||sqlerrm);  
      dbms_output.put_line('CP Script end with error: '||sqlerrm);
end;
/