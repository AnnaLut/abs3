

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_KOMIS_NON_CASH.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_KOMIS_NON_CASH ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_KOMIS_NON_CASH 
is
l_tt varchar2(3) :='K26';
l_branch varchar2(32);
l_rnk customer.rnk%type;
l_segment number;
l_s number;
l_nbs  accounts.nbs%type;
l_ob22 accounts.ob22%type;
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
      select branch, F_TARIF(70, kv, nls, c.s ), rnk, nbs, ob22
        into l_branch, l_s, l_rnk, l_nbs, l_ob22
        from accounts where nls=c.nlsb and kv=980;

	l_segment := bars.attribute_utl.get_number_value ( l_rnk, 'CUSTOMER_SEGMENT_FINANCIAL', bankdate);

	if  l_segment in (1, 2)  /*[ Пн 28.11.2016 16:07:08 - Рибалко Наталія Іванівна - Призначено ]: VIP клиент определяется по признаку в "закладке" СЕГМЕНТ КЛИЕНТА - СЕГМЕНТ ФИНАНСОВЫЙ - Прайвет или Премиум*/
	        then logger.info('p_job_komis_non_cash: REF='||to_char(c.ref)||' NOT COMIS2620 CUSTOMER_SEGMENT_FINANCIAL='||bars.list_utl.get_item_name ('CUSTOMER_SEGMENT_FINANCIAL',l_segment) );
    elsif (l_nbs = '2620' and l_ob22 = '34')   --COBUSUPABS-5211
            then logger.info('p_job_komis_non_cash: REF='||to_char(c.ref)||' блокування Спеціальних рахунків (2620/34) на здійснення видаткових операцій(комісія) NLS ='||c.nlsb );

	else
	     logger.financial('p_job_komis_non_cash: REF='||to_char(c.ref)||' COMIS2620 CUSTOMER_SEGMENT_FINANCIAL='||bars.list_utl.get_item_name ('CUSTOMER_SEGMENT_FINANCIAL',l_segment) );
         if NEWNBS.GET_STATE = 0 then
            gl.payv(0, c.ref, c.vdat, l_tt, 1, 980, c.nlsb, l_s, 980, nbs_ob22_null ('6110','17', l_branch), l_s);
         else
            gl.payv(0, c.ref, c.vdat, l_tt, 1, 980, c.nlsb, l_s, 980, nbs_ob22_null ('6510','17', l_branch), l_s);
         end if;
         gl.pay2(2, c.ref, gl.bd);
	end if;


     delete from komis_non_cash where ref=c.ref;


     exception
        when others then
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
