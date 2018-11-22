PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARS/Script/customerw_update.sql =====*** Run *** ====
PROMPT ===================================================================================== 

declare
   l_lim            number        := 50000;
   type             tbl_rec       is record (rid rowid, effectdate date);
   type             t_tbl_rec     is table of tbl_rec;
   l_tbl            t_tbl_rec;
   l_min            date          := to_date('03.03.2000', 'dd.mm.yyyy');
   l_max            date          := bars.gl.bd;
   l_bd             date          := bars.gl.bd;
   cursor c_data is select /*+ full(u) parallel(16)*/ u.rowid rid,
                           case when chgdate between l_min and l_max then trunc(chgdate)
                                when chgdate < l_min then  l_min 
                                when chgdate > l_max then  l_bd end as effectdate
                           from bars.customerw_update u
                          where u.effectdate is null;

begin
    bpa.disable_policies('CUSTOMERW_UPDATE');

    open c_data;
    loop
       fetch c_data bulk collect into l_tbl limit l_lim;
       exit when l_tbl.count = 0;
       forall i in l_tbl.first .. l_tbl.last
          update bars.customerw_update
             set effectdate=l_tbl(i).effectdate
           where rowid = l_tbl(i).rid;
       commit;
    end loop;
    close c_data;
    
    bpa.enable_policies('CUSTOMERW_UPDATE');
    exception
      when others
           then bpa.enable_policies('CUSTOMERW_UPDATE'); raise;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARS/Script/customerw_update.sql =====*** End *** ====
PROMPT ===================================================================================== 
