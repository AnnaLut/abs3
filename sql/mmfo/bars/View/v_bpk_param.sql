PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_PARAM.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_PARAM ***

create or replace view v_bpk_param as
select bpk.ND,p.TAG,p.VALUE
 from
(select nd from (
       select nd from w4_acc
       union
       select nd from bpk_acc)) bpk
       join (select * from bpk_parameters where tag in('BUS_MOD','SPPI','IFRS')) p on p.nd=bpk.nd;
	   

PROMPT *** Create  grants  V_BPK_PARAM ***
grant SELECT on V_BPK_PARAM   to BARS_ACCESS_DEFROLE;
grant SELECT on V_BPK_PARAM   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_PARAM.sql =========*** End *** ==========
PROMPT ===================================================================================== 