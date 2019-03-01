

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/compare_report_351_601.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure compare_report_351_601 ***

create or replace procedure compare_report_351_601
is
type o1 is table of credit_registry_601;
credit_nbu o1;
credit_cr o1;
result_check o1;
begin
bars_login.login_user(sys_guid(),1,null,null);
--collection credit data 601 form
execute immediate 'truncate table credit_nbu_601';
for i in  (select b.id,b.kf,a.reporting_date,a.data_type_id
                  from nbu_gateway.nbu_core_data_request a
                  join (select max(id) as id ,kf from nbu_gateway.nbu_core_data_request where data_type_id=15 and reporting_date=trunc(sysdate,'mm')
                       group by kf) b on a.id=b.id and a.kf=b.kf) loop
      insert into credit_nbu_601
       select cust.okpo, c.rnk,c.nd,c.r030,c.sumarrears,c.kf from nbu_gateway.core_credit c
             join (select distinct okpo,rnk from customer where CUSTTYPE=2) cust on cust.rnk=c.rnk
             where c.request_id=i.id and c.kf=i.kf;
      end loop;
------------------------
        execute immediate 'truncate table rez_cr_601';
        insert into rez_cr_601
        select cust.okpo,c.rnk,c.nd,c.kv, abs(sum(bv)) * 100 as s,c.kf 
                from bars.rez_cr c
                left join --загальна сума (ліміт кредитної лінії)
                            (select distinct cd.nd, (cd.sdog*100) as sum_zagal
                                             from bars.cc_deal cd) sumzagalcred on sumzagalcred.nd=c.nd
                left join --овердрафт
                (select na.nd,a.acc, min(a.dos) keep (dense_rank first order by a.fdat) as sum_zagal
                                  from bars.saldoa a, bars.accounts a1, bars.nd_acc na
                                  where a1.acc=na.acc and a.acc=a1.acc and a1.nbs=9129
                                  group by na.nd,a.acc)  sumzagal_over on sumzagal_over.nd=c.nd
                left join --БПК
                          (select w4.nd,a.acc,min(a.dos) keep (dense_rank first order by a.fdat) as sum_zagal
                                  from bars.saldoa a, bars.accounts a1, bars.w4_acc w4
                                  where a.acc=a1.acc and w4.acc_9129=a1.acc
                                  group by  w4.nd,a.acc) sumzagal_bpk on sumzagal_bpk.nd=c.nd

                join (select * from bars.customer where custtype=2) cust on cust.rnk=c.rnk
                where c.custtype=2 and fdat=trunc(sysdate,'mm')
                      and tipa<>15 and tip in ('SS ','SP ','SN ','SPN','SNO','SRR') and coalesce(sumzagalcred.sum_zagal,sumzagal_over.sum_zagal, sumzagal_bpk.sum_zagal)>=5000000
                group by cust.okpo,c.rnk,c.nd,c.kv,c.kf;

        commit;
------------------------
select credit_registry_601(okpo,rnk,nd,kv,sum_all,kf) bulk collect into credit_nbu from credit_nbu_601 ;
select credit_registry_601(okpo,rnk,nd,kv,sum_all,kf) bulk collect into credit_cr from rez_cr_601;
result_check:=credit_cr multiset except credit_nbu;
execute immediate 'truncate table result_comparison_601_rez';
for i in  1..result_check.count loop
   insert into result_comparison_601_rez(okpo,
                                             rnk,
                                             nd,
                                             kv,
                                             sum_all_cr,
                                             sum_all_601,
                                             difference,
                                             kf)
               values (result_check(i).okpo,
                       result_check(i).rnk,
                       result_check(i).nd,
                       result_check(i).kv,
                       result_check(i).sum_all,
                       null,
                       null,
                       result_check(i).kf);
   commit;
   update result_comparison_601_rez r set r.sum_all_601=(SELECT t.sum_all FROM credit_nbu_601 t where r.nd=t.nd);
   update result_comparison_601_rez r set r.difference=r.sum_all_cr-r.sum_all_601;
   --dbms_output.put_line (result_check(i).rnk ||'/'||result_check(i).nd);
  commit;
end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/compare_report_351_601.sql =========*** End *** ==
PROMPT ===================================================================================== 
