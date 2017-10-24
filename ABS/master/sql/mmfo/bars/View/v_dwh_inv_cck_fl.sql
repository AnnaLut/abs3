

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DWH_INV_CCK_FL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DWH_INV_CCK_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DWH_INV_CCK_FL ("ACC", "ACC2208", "ACC9129", "G00", "G01", "G02", "G03", "G04", "G05", "G06", "G07", "G08", "G09", "G10", "G11", "G12", "G13", "G13A", "G13B", "G13D", "G13E", "G13G", "G13I", "G13J", "G13V", "G13Z", "G14", "G15", "G16", "G17", "G18", "G19", "G20", "G21", "G22", "G23", "G24", "G25", "G26", "G27", "G28", "G29", "G30", "G31", "G32", "G33", "G34", "G35", "G36", "G37", "G38", "G39", "G40", "G41", "G42", "G43", "G44", "G45", "G46", "G47", "G48", "G49", "G50", "G51", "G52", "G53", "G54", "G55", "G56", "G57", "G58", "G59", "GR", "GT", "RNK") AS 
  select
   acc,   acc2208,   acc9129,
   g00,g01,g02,g03,g04,g05,g06,g07,g08,g09,g10,g11,g12,g13,g13a,g13b,g13d,g13e,g13g,g13i,g13j,g13v,g13z,
   g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g24,g25,g26,g27,g28,g29,g30,g31,g32,g33,g34,g35,g36,g37,g38,
   g39,g40,g41,g42,g43,g44,g45,g46,g47,g48,g49,g50,g51,g52,g53,g54,g55,g56,g57,g58,g59,gr,gt,rnk
     from (select acc,   acc2208,   acc9129,
                  g00,g01,g02,g03,g04,g05,g06,g07,g08,g09,g10,g11,g12,g13,g13a,g13b,g13d,g13e,g13g,g13i,g13j,g13v,g13z,
                  g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g24,g25,g26,g27,g28,g29,g30,g31,g32,g33,g34,g35,g36,g37,g38,
                  g39,g40,g41,g42,g43,g44,g45,g46,g47,g48,g49,g50,g51,g52,g53,g54,g55,g56,g57,g58,g59,gr,gt,rnk
             from inv_cck_fl
            where (g00, gt, gr, g59, g19) not in (select g00,gt,gr,g59,'2202' from  dwh_tmp_dblcredits  )
            union all
           select acc,   acc2208,   acc9129,
                  i.g00,g01,g02,g03,g04,g05,g06,g07,g08,g09,g10,g11,g12,g13,g13a,g13b,g13d,g13e,g13g,g13i,g13j,g13v,g13z,
                  g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g24,g25,g26,g27,g28,g29,g30,g31,g32,g33,g34,g35,g36,g37,g38,
                  g39,g40,g41,g42,g43,g44,g45,g46,g47,g48,g49,g50,g51,g52,g53,g54,g55,g56,g57,g58,
                  i.g59, 'i' gr, i.gt, rnk
             from inv_cck_fl i, dwh_tmp_dblcredits  d
            where g19 = '2202' and i.g00 = d.g00 and i.gt=d.gt and i.gr = d.gr and i.g59 = d.g59
          );

PROMPT *** Create  grants  V_DWH_INV_CCK_FL ***
grant SELECT                                                                 on V_DWH_INV_CCK_FL to BARSDWH_ACCESS_USER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DWH_INV_CCK_FL.sql =========*** End *
PROMPT ===================================================================================== 
