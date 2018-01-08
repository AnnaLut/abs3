

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZALOG_BY_COL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZALOG_BY_COL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZALOG_BY_COL ("ACCS", "DAT", "USERID", "S031_11_1", "S031_12_1", "S031_13_1", "S031_14_1", "S031_15_1", "S031_21_1", "S031_22_1", "S031_23_1", "S031_24_1", "S031_25_1", "S031_26_1", "S031_27_1", "S031_28_1", "S031_29_1", "S031_30_1", "S031_31_1", "S031_32_1", "S031_33_1", "S031_11_2", "S031_12_2", "S031_13_2", "S031_14_2", "S031_15_2", "S031_21_2", "S031_22_2", "S031_23_2", "S031_24_2", "S031_25_2", "S031_26_2", "S031_27_2", "S031_28_2", "S031_29_2", "S031_30_2", "S031_31_2", "S031_32_2", "S031_33_2", "S031_11_3", "S031_12_3", "S031_13_3", "S031_14_3", "S031_15_3", "S031_21_3", "S031_22_3", "S031_23_3", "S031_24_3", "S031_25_3", "S031_26_3", "S031_27_3", "S031_28_3", "S031_29_3", "S031_30_3", "S031_31_3", "S031_32_3", "S031_33_3") AS 
  select accs,dat,userid,
sum(s031_11_1)/100 s031_11_1,
sum(s031_12_1)/100 s031_12_1,
sum(s031_13_1)/100 s031_13_1,
sum(s031_14_1)/100 s031_14_1,
sum(s031_15_1)/100 s031_15_1,
sum(s031_21_1)/100 s031_21_1,
sum(s031_22_1)/100 s031_22_1,
sum(s031_23_1)/100 s031_23_1,
sum(s031_24_1)/100 s031_24_1,
sum(s031_25_1)/100 s031_25_1,
sum(s031_26_1)/100 s031_26_1,
sum(s031_27_1)/100 s031_27_1,
sum(s031_28_1)/100 s031_28_1,
sum(s031_29_1)/100 s031_29_1,
sum(s031_30_1)/100 s031_30_1,
sum(s031_31_1)/100 s031_31_1,
sum(s031_32_1)/100 s031_32_1,
sum(s031_33_1)/100 s031_33_1,
sum(s031_11_2)/100 s031_11_2,
sum(s031_12_2)/100 s031_12_2,
sum(s031_13_2)/100 s031_13_2,
sum(s031_14_2)/100 s031_14_2,
sum(s031_15_2)/100 s031_15_2,
sum(s031_21_2)/100 s031_21_2,
sum(s031_22_2)/100 s031_22_2,
sum(s031_23_2)/100 s031_23_2,
sum(s031_24_2)/100 s031_24_2,
sum(s031_25_2)/100 s031_25_2,
sum(s031_26_2)/100 s031_26_2,
sum(s031_27_2)/100 s031_27_2,
sum(s031_28_2)/100 s031_28_2,
sum(s031_29_2)/100 s031_29_2,
sum(s031_30_2)/100 s031_30_2,
sum(s031_31_2)/100 s031_31_2,
sum(s031_32_2)/100 s031_32_2,
sum(s031_33_2)/100 s031_33_2 ,
sum(s031_11_3)/100 s031_11_3,
sum(s031_12_3)/100 s031_12_3,
sum(s031_13_3)/100 s031_13_3,
sum(s031_14_3)/100 s031_14_3,
sum(s031_15_3)/100 s031_15_3,
sum(s031_21_3)/100 s031_21_3,
sum(s031_22_3)/100 s031_22_3,
sum(s031_23_3)/100 s031_23_3,
sum(s031_24_3)/100 s031_24_3,
sum(s031_25_3)/100 s031_25_3,
sum(s031_26_3)/100 s031_26_3,
sum(s031_27_3)/100 s031_27_3,
sum(s031_28_3)/100 s031_28_3,
sum(s031_29_3)/100 s031_29_3,
sum(s031_30_3)/100 s031_30_3,
sum(s031_31_3)/100 s031_31_3,
sum(s031_32_3)/100 s031_32_3,
sum(s031_33_3)/100 s031_33_3
from (
select t.ACCS,t.DAT, userid,
case when p.s031 = '11' then t.S else 0 end s031_11_1,
case when p.s031 = '12' then t.S else 0 end s031_12_1,
case when p.s031 = '13' then t.S else 0 end s031_13_1,
case when p.s031 = '14' then t.S else 0 end s031_14_1,
case when p.s031 = '15' then t.S else 0 end s031_15_1,
case when p.s031 = '21' then t.S else 0 end s031_21_1,
case when p.s031 = '22' then t.S else 0 end s031_22_1,
case when p.s031 = '23' then t.S else 0 end s031_23_1,
case when p.s031 = '24' then t.S else 0 end s031_24_1,
case when p.s031 = '25' then t.S else 0 end s031_25_1,
case when p.s031 = '26' then t.S else 0 end s031_26_1,
case when p.s031 = '27' then t.S else 0 end s031_27_1,
case when p.s031 = '28' then t.S else 0 end s031_28_1,
case when p.s031 = '29' then t.S else 0 end s031_29_1,
case when p.s031 = '30' then t.S else 0 end s031_30_1,
case when p.s031 = '31' then t.S else 0 end s031_31_1,
case when p.s031 = '32' then t.S else 0 end s031_32_1,
case when p.s031 = '33' then t.S else 0 end s031_33_1,
case when p.s031 = '11' then t.SPRIV else 0 end s031_11_2,
case when p.s031 = '12' then t.SPRIV else 0 end s031_12_2,
case when p.s031 = '13' then t.SPRIV else 0 end s031_13_2,
case when p.s031 = '14' then t.SPRIV else 0 end s031_14_2,
case when p.s031 = '15' then t.SPRIV else 0 end s031_15_2,
case when p.s031 = '21' then t.SPRIV else 0 end s031_21_2,
case when p.s031 = '22' then t.SPRIV else 0 end s031_22_2,
case when p.s031 = '23' then t.SPRIV else 0 end s031_23_2,
case when p.s031 = '24' then t.SPRIV else 0 end s031_24_2,
case when p.s031 = '25' then t.SPRIV else 0 end s031_25_2,
case when p.s031 = '26' then t.SPRIV else 0 end s031_26_2,
case when p.s031 = '27' then t.SPRIV else 0 end s031_27_2,
case when p.s031 = '28' then t.SPRIV else 0 end s031_28_2,
case when p.s031 = '29' then t.SPRIV else 0 end s031_29_2,
case when p.s031 = '30' then t.SPRIV else 0 end s031_30_2,
case when p.s031 = '31' then t.SPRIV else 0 end s031_31_2,
case when p.s031 = '32' then t.SPRIV else 0 end s031_32_2,
case when p.s031 = '33' then t.SPRIV else 0 end s031_33_2,
case when p.s031 = '11' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_11_3,
case when p.s031 = '12' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_12_3,
case when p.s031 = '13' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_13_3,
case when p.s031 = '14' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_14_3,
case when p.s031 = '15' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_15_3,
case when p.s031 = '21' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_21_3,
case when p.s031 = '22' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_22_3,
case when p.s031 = '23' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_23_3,
case when p.s031 = '24' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_24_3,
case when p.s031 = '25' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_25_3,
case when p.s031 = '26' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_26_3,
case when p.s031 = '27' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_27_3,
case when p.s031 = '28' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_28_3,
case when p.s031 = '29' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_29_3,
case when p.s031 = '30' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_30_3,
case when p.s031 = '31' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_31_3,
case when p.s031 = '32' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_32_3,
case when p.s031 = '33' then decode(t.proc,0,0,null,0,round(t.s*100/t.proc)) else 0 end s031_33_3
from tmp_rez_risk2 t, cc_pawn p
where t.PAWN=p.pawn)
group by accs,dat,userid
 ;

PROMPT *** Create  grants  V_ZALOG_BY_COL ***
grant SELECT                                                                 on V_ZALOG_BY_COL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZALOG_BY_COL  to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ZALOG_BY_COL  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZALOG_BY_COL.sql =========*** End ***
PROMPT ===================================================================================== 
