BEGIN
  
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf) LOOP
    bc.go(cur.kf);
    delete from bars.int_ratn ir --удаляем все ставки
    where ir.bdat = to_date('26.04.2018','DD.MM.YYYY') -- установленные с 26 апреля
    and ir.br is not null -- не индивидуальные
    and ir.id = 1 -- установленные под барсом
    and ir.acc in (select acc from bars.tmp_int_ddpt tid where tid.kf = cur.kf); -- счета есть в таблице, которая отбирала и обрабатывала эти счета
    
    commit;
   END LOOP;
   
  bc.home;

end;
/
show error
