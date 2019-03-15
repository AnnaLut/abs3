
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_oper_sep_comp.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view v_oper_sep_comp ***
/* View для звіту СЕП Повернуті платежі */
create or replace view v_oper_sep_comp as
select
t_in.ref   ref_in
,t_in.nazn nazn_in
,t_in.s/100    s_in
,t_out.nd  nd_out
,t_out.ref ref_out
,(select VALUE from operw where tag='OWCRN' and ref =t_out.ref) DRN
,t_out.nazn nazn_out
,t_out.s/100    s_out
,trunc(t_out.pdat) pdat_out
,case
 when t_out.nd is null             then 'Відповідність не знайдена'
 when t_in.s  != t_out.s           then 'Знайдена невідповідність по сумі документа'
 when t_in.dd != trunc(t_out.pdat) then 'Знайдена невідповідність по даті документа' 
 else 'Успішно'
end status
,t_in.nlsa nls_in
,o.nlsb    nls_out
from (
       select  t_in.ref,t_in.s, REGEXP_substr(t_in.nazn,'[0-9]{10}',1) nd,nlsa,
               to_date(REGEXP_substr(t_in.nazn,'\d{2}\/\d{2}\/\d{4}'),'dd/mm/yyyy') dd ,t_in.nazn
       from TMP_OPERSEP_REP t_in WHERE T_IN.TD='IN' 
     ) t_in
   left join   TMP_OPERSEP_REP  t_out on t_out.nd=t_in.nd and T_out.TD='OUT'
   left join oper o on o.ref=t_out.ref
;

PROMPT *** Create  grants v_oper_sep_comp  ***
grant SELECT                                                                 on v_oper_sep_comp          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on v_oper_sep_comp          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_oper_sep_comp.sql ==*** End ***  ====
PROMPT ===================================================================================== 
