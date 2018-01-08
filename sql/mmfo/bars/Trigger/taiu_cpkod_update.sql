

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPKOD_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CPKOD_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CPKOD_UPDATE 
after insert or delete or update
 ON BARS.CP_KOD for each row
declare
   l_bankdate date;
   -- триггер предполагает только одну запись за один банковский день
   -- если в один банк. день было несколько изменений, то они перезаписывают пердидущее за этот банковский день
   l_chgaction char(1);
   l_idupd       number;
begin
   l_bankdate := gl.bd;
   if l_bankdate is null then
      select to_date(val,'dd/mm/yyyy') into l_bankdate from params$base where par= 'BANKDATE';
   end if;
   if  deleting   then
       l_chgaction:= 'D';
       insert into cp_kod_update(
              idupd, chgaction, effectdate, chgdate, doneby, amort, basey, cena,
              cena_kup, cena_kup0, cena_start, country, cp_id, datp, datvk,
              datzr, dat_em, dat_rr, dcp, dnk, dok, dox, emi, fin23, gs, id,
              idt, ir, k23, kat23, kv, ky, metr, name, period_kup, pr1_kup,
              pr_akt, pr_amr, quot_sign, rnk, tip, vncrr, zal_cp, pawn,expiry, hierarchy_id, fin_351, pd, fair_method_id, kf)
      values (bars_sqnc.get_nextval('s_cpkod_update') ,l_chgaction, l_bankdate, sysdate, user_id, :old.amort,  :old.basey,  :old.cena,
              :old.cena_kup, :old.cena_kup0, :old.cena_start, :old.country, :old.cp_id, :old.datp,  :old.datvk,
              :old.datzr, :old.dat_em, :old.dat_rr, :old.dcp, :old.dnk, :old.dok, :old.dox, :old.emi, :old.fin23, :old.gs, :old.id,
              :old.idt, :old.ir, :old.k23, :old.kat23, :old.kv, :old.ky, :old.metr, :old.name, :old.period_kup, :old.pr1_kup,
              :old.pr_akt, :old.pr_amr, :old.quot_sign, :old.rnk, :old.tip, :old.vncrr, :old.zal_cp, :old.pawn,:old.expiry, :old.hierarchy_id,
	      :old.fin_351, :old.pd, :old.fair_method_id, :old.kf            	 );
   else
       if  updating then
           l_chgaction:= 'U';
       else
          l_chgaction:= 'I';
       end if;
        insert into cp_kod_update(
               idupd, chgaction, effectdate, chgdate, doneby, amort, basey, cena,
               cena_kup, cena_kup0, cena_start, country, cp_id, datp, datvk,
               datzr, dat_em, dat_rr, dcp, dnk, dok, dox, emi, fin23, gs, id,
               idt, ir, k23, kat23, kv, ky, metr, name, period_kup, pr1_kup,
               pr_akt, pr_amr, quot_sign, rnk, tip, vncrr, zal_cp, pawn, expiry, hierarchy_id, fin_351, pd, fair_method_id, kf)
       values (bars_sqnc.get_nextval('s_cpkod_update') ,l_chgaction, l_bankdate, sysdate, user_id, :new.amort, :new.basey, :new.cena,
               :new.cena_kup, :new.cena_kup0, :new.cena_start, :new.country, :new.cp_id, :new.datp, :new.datvk,
               :new.datzr, :new.dat_em, :new.dat_rr, :new.dcp, :new.dnk, :new.dok, :new.dox, :new.emi, :new.fin23, :new.gs, :new.id,
               :new.idt, :new.ir, :new.k23, :new.kat23, :new.kv, :new.ky, :new.metr, :new.name, :new.period_kup, :new.pr1_kup,
               :new.pr_akt, :new.pr_amr, :new.quot_sign, :new.rnk, :new.tip, :new.vncrr, :new.zal_cp, :new.pawn,:new.expiry, :new.hierarchy_id,
               :new.fin_351, :new.pd, :new.fair_method_id, :new.kf);
   end if;
end;
/
ALTER TRIGGER BARS.TAIU_CPKOD_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPKOD_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
