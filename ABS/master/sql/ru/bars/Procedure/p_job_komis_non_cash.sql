

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_KOMIS_NON_CASH.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_KOMIS_NON_CASH ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_KOMIS_NON_CASH 
is
l_tt varchar2(3) :='K26';
l_branch varchar2(32);
l_s number;
begin
for i in(select kf from mv_kf)
loop
BARS_CONTEXT.SUBST_MFO(i.kf);
for c in(select o.* from komis_non_cash k, oper o
         where o.ref=k.ref
           and substr(o.mfoa,1,1)!='8'
           and o.mfoa not in (select mfo from banks where mfou=300465)
           and o.kv=980
           and k.kf=i.kf
           )
  loop
    begin
     savepoint sp_before;
      select branch, F_TARIF(70, kv, nls, c.s )
        into l_branch, l_s
        from accounts where nls=c.nlsb and kv=980;
         if NEWNBS.GET_STATE = 0 then
            gl.payv(0, c.ref, c.vdat, l_tt, 1, 980, c.nlsb, l_s, 980, nbs_ob22_null ('6110','17', l_branch), l_s);
         else 
            gl.payv(0, c.ref, c.vdat, l_tt, 1, 980, c.nlsb, l_s, 980, nbs_ob22_null ('6510','17', l_branch), l_s);
         end if;
        
        gl.pay2(2, c.ref, gl.bd);
     delete from komis_non_cash where ref=c.ref;

    EXCEPTION
        WHEN no_data_found THEN

         delete from komis_non_cash where ref=c.ref;

        WHEN OTHERS THEN
           rollback to sp_before;
        logger.error('p_job_komis_non_cash: помилка оплати - '||sqlerrm);
     end;
    end loop;
BARS_CONTEXT.SET_CONTEXT;
end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_KOMIS_NON_CASH.sql =========
PROMPT ===================================================================================== 
