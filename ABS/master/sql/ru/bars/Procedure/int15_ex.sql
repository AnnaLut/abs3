

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INT15_EX.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INT15_EX ***

  CREATE OR REPLACE PROCEDURE BARS.INT15_EX (p_dat date, p_dpt_id number)
is
l_s15 number :=0;
l_s15v number :=0;
l_tax_nls varchar2(14);
l_tax_nls_back varchar2(14);
l_tax number;
l_tax_date_begin date;
l_tax_date_end date;
l_bdat date := bankdate;
l_kv number;
l_ref number;
l_nlsa varchar2(14);

l_tax_sum number;
l_tax_sumv number;

l_opersum number;

l_tax_back number :=0;
l_branch varchar2(50);

begin

   select branch, kv
   into l_branch, l_kv
   from dpt_deposit
   where deposit_id = p_dpt_id;

   l_tax:= GetGlobalOption('TAX_INT');
   l_tax_date_begin := to_date(GetGlobalOption('TAX_DON'), 'dd.mm.yyyy');
   l_tax_date_end := to_date(nvl(GetGlobalOption('TAX_DOFF'),add_months(p_dat,1)), 'dd.mm.yyyy');
   l_tax_nls := nbs_ob22_null(3622,37,l_branch);
   l_tax_nls_back := nbs_ob22_null(3522,29,l_branch);

   if to_date(p_dat,'dd/mm/yyyy') between to_date(l_tax_date_begin,'dd/mm/yyyy') and to_date(l_tax_date_end,'dd/mm/yyyy')

   then

      BEGIN

        select min(o.ref), o.nlsa, sum(round(o.s*l_tax)), sum(p_icurval(o.kv,round(o.s*l_tax), p_dat)), sum(o.s)
        into l_ref, l_nlsa, l_tax_sum, l_tax_sumv, l_opersum
        from oper o
        where o.ref in (select ref from dpt_payments where dpt_id = p_dpt_id)
        and o.vdat = p_dat
        and o.tt = '%%1'
        and o.sos > 0
        and not exists (select 1 from opldok where ref = o.ref and tt = '%15' and sos >0)
        group by o.nlsa;
      EXCEPTION
       WHEN NO_DATA_FOUND THEN RETURN;
      END;

        l_s15:= l_opersum*l_tax;
        l_s15:=round(l_s15,0);
        l_s15v :=p_icurval(l_kv, l_s15, p_dat);
        if l_s15> 0 then
            gl.payv(1, l_ref, p_dat,'%15', 1, l_kv, l_nlsa, l_s15, 980,l_tax_nls, l_s15v);
        end if;

        insert into int15_log
        select l_ref, sysdate, l_opersum, l_kv, l_s15, to_char(l_s15v) from dual;

        l_s15:=0; l_s15v:=0;

 end if;

end int15_ex;
/
show err;

PROMPT *** Create  grants  INT15_EX ***
grant EXECUTE                                                                on INT15_EX        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INT15_EX.sql =========*** End *** 
PROMPT ===================================================================================== 
