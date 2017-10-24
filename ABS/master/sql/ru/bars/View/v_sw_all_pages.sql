 create or replace view v_sw_all_pages
 as           
select w.n, w.seq, w.tag, w.opt, w.value, j.trn
             from sw_operw w, sw_journal j 
            where w.swref = j.swref 
                          order by j.page, w.n;
grant select on v_sw_all_pages to bars_access_defrole
/
