PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/zp_central_upd_COBUMMFO_10243.sql =========*** Run *** 
PROMPT ===================================================================================== 

/* скрипт синхронізації ознаки централізації */
declare
  l_errm varchar2(4000);
begin
  bc.home;
  for c in (select * from zp_central_queue)
  loop
    begin
      -- установка ознаки централізації
      zp.set_central(p_mfo     => c.mfo,
                     p_nls     => c.nls,
                     p_central => c.central);
      -- видалення з черги на синхронізацію ознаки централізації
      delete zp_central_queue where nls = c.nls and central = c.central;
    exception
      when others then
        l_errm := substrb(dbms_utility.format_error_backtrace || ' ' || sqlerrm, 1, 4000);
        update zp_central_queue
           set error = l_errm
         where nls = c.nls and central = c.central and mfo = c.mfo;
    end;
  end loop;
  commit;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/zp_central_upd_COBUMMFO_10243.sql =========*** End *** 
PROMPT ===================================================================================== 
