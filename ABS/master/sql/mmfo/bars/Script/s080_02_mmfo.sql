begin
   for k in (select * from mv_kf)
   LOOP
      bc.go(k.kf);
      for k in ( select r.fdat,r.rnk,r.acc, r.nd, r.nls,r.kv,r.tipa, r.rowid RI ,r.fin,r.tip_fin t_fin_rez_cr,r.s080 s080_rez_cr, 
                        f_get_nd_val_n('TIP_FIN', nd, fdat,  
                                       decode(tipa,90,10,9,(select tipa  from nd_val  where fdat = r.fdat and rnk = r.rnk and nd = r.nd and rownum=1), TIPA), RNK) tip_fin,  
                        f_get_s080 (r.fdat, f_get_nd_val_n('TIP_FIN', nd, fdat,  
                                    decode(tipa,90,10,9,(select tipa  from nd_val  where fdat = r.fdat and rnk = r.rnk and nd = r.nd and rownum=1), TIPA), RNK) , r.fin) s080 
                 from rez_cr r 
                 where fdat = to_date('01-02-2018','dd-mm-yyyy') and rnk in (select rnk from customerw where tag='ISSPE' and nvl(trim(value),'0') <> '1' ) and tip_fin=1
               )
      LOOP
         update rez_cr set tip_fin= k.tip_fin, s080=k.s080 where rowid=k.RI;
         update nbu23_rez set s080 = k.s080 where fdat= k.fdat and acc=k.acc;
      end loop;
      commit;
   end loop;
end;
/