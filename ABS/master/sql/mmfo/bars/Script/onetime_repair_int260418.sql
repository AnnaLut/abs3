PROMPT =============== *** start repair_int260418  *** ==========================

declare
  p_dat       DATE := to_date('26.04.2018','DD.MM.YYYY'); --trunc(sysdate);
  l_err varchar2(200);
BEGIN
  
  
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf) LOOP
    
    bc.go(cur.kf);
    bars_audit.info('Repair int_ratn on 26-04-18. kf = '||to_char(cur.kf));
    
   For i in (select * from tmp_repair_int260418 tri
        where tri.kf = cur.kf
        and nvl(trim(tri.note),'-') <> 'OK') loop
       BEGIN
       
       insert into bars.Int_Ratn (acc, id, bdat, ir, br, op)
          values(i.acc, 1, p_dat, i.old_ir, i.old_br, i.old_op);

       update tmp_repair_int260418
       set new_ir = i.old_ir,
           new_br = i.old_br,
           new_op = i.new_op,
           note   = 'OK'
       where acc = i.acc;       

       exception when dup_val_on_index then
         update tmp_repair_int260418
         set note   = 'Error. Ошибка восстановления ставки. На эту дату есть уже запись в таблице ставок'
         where acc = i.acc;              
       when others then
         l_err := substr(l_err ||' - '||sqlerrm, 1,200);
         
         update tmp_repair_int260418
         set note   = 'Error. '||l_err
         where acc = i.acc;              
       end;
   end loop;
  commit;
  bars_audit.info('Repair int_ratn on 26-04-18. Ставки для kf = '||to_char(cur.kf)||' восстановлены ');
  end loop;
  bc.home;

end;
/
show error

PROMPT =============== *** finish onetime set bonus  *** ==========================
