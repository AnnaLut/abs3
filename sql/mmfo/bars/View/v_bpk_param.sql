

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_PARAM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_PARAM ***

create or replace view v_bpk_param as
select bpk.ND,trim(p.TAG)tag, txt as value,null as comm
 from
(select nd,rnk from (
       select nd,a.rnk from w4_acc w4a inner join accounts a on a.acc=w4a.acc_pk 
       union
       select nd,a.rnk from bpk_acc w4a  inner join accounts a on a.acc=w4a.acc_pk )) bpk
       join (
        select p.*
       ,case
          when p.tag='BUS_MOD' then  (select BUS_MOD_NAME from BUS_MOD where to_char(BUS_MOD_ID) =p.value )
          when p.tag='IFRS'    then  (select IFRS_name from IFRS where IFRS_id =p.value )
          when p.tag='SPPI'    then  (select SPPI_name from SPPI where SPPI_id =p.value )
          else p.value
        end txt
       from   bpk_parameters  p
             inner join bpk_tags l on l.tag=p.tag
       ) p on p.nd=bpk.nd
   union 
   select d.nd, trim(f.tag) tag, w.VALUE,
   case 
     when  f.tag ='CIGPO' then  (select txt  from CIG_D09   where to_char(ID) =w.value ) 
     when  f.tag ='EDUCA' then  (select name from EDUCATION where to_char(ID) =w.value )     
     when  f.tag ='STAT'  then  (select txt  from CIG_D08   where to_char(ID) =w.value )  
     when  f.tag ='TYPEW' then  (select name from EMPLOYER_TYPE where to_char(ID) =w.value )     
   end 
   from   CUSTOMER_FIELD f, v_customerw w, w4_deal d
   where  f.tag = w.tag
          and f.code in ('KRED', 'OTHERS')
          and d.cust_rnk = w.RNK;

PROMPT *** Create  grants  V_BPK_PARAM ***
grant SELECT                                                                 on V_BPK_PARAM     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_PARAM     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_PARAM.sql =========*** End *** ==
PROMPT ===================================================================================== 
