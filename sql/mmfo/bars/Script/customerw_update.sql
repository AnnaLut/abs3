PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARS/Script/customerw_update.sql =====*** Run *** ====
PROMPT ===================================================================================== 

declare
   l_lim            number        := 50000;
   type             tbl_rec       is record (rid rowid, effectdate date);
   type             t_tbl_rec     is table of tbl_rec;
   l_tbl            t_tbl_rec;
   l_kf             varchar2(6)   := null;
   l_min            date          := to_date('03.03.2000', 'dd.mm.yyyy');
   l_max            date          := bars.gl.bd;
   l_bd             date          := bars.gl.bd;
   v_count          number        := 0;
   cursor c_data is select /*+ full(u) parallel(16)*/ u.rowid rid,
                           case when chgdate between l_min and l_max then trunc(chgdate)
                                when chgdate < l_min then  l_min 
                                when chgdate > l_max then  l_bd end as effectdate
                           from bars.customerw_update u
                          where u.effectdate is null;
begin
  
    for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
    loop
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);
        v_count := 0;
        open c_data;
        loop
           fetch c_data bulk collect into l_tbl limit l_lim;
           exit when l_tbl.count = 0;
           forall i in l_tbl.first .. l_tbl.last
              update bars.customerw_update
                 set effectdate=l_tbl(i).effectdate
               where rowid = l_tbl(i).rid;
           v_count := v_count + l_lim;
           dbms_application_info.set_client_info('ROWS: ' || trim(to_char(v_count, '999G999G999G999G999'))||'/ '||l_kf);
           commit;
        end loop;
        close c_data;
    end loop;
    bars.bc.home;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARS/Script/customerw_update.sql =====*** End *** ====
PROMPT ===================================================================================== 
