

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/INV_FL_23.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view INV_FL_23 ***

  CREATE OR REPLACE FORCE VIEW BARS.INV_FL_23 ("G01", "G02", "G03", "G04", "G05", "G05I", "G06", "G07", "G08", "G09", "G10", "G11", "G12", "G13", "G13A", "G13B", "G13V", "G13G", "G13D", "G13E", "G13J", "G13Z", "G13I", "G14", "G15", "G16", "G17", "G18", "G19", "G20", "G21", "G22", "G23", "G24", "G25", "G26", "G27", "G28", "G29", "G30", "G31", "G32", "G33", "G34", "G35", "G36", "G37", "G38", "G39", "G40", "G41", "G42", "G43", "G44", "G45", "G46", "G47", "G48", "G49", "G50", "G51", "G52", "G53", "G54", "G55", "G56", "G57", "G58", "G59", "G60", "G61", "G62", "G63", "G64", "G65", "G00", "GT", "GR", "ACC", "RNK") AS 
  (select G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
              G13 , G13a, G13b, G13v, G13g, G13d, G13e, G13j, G13z, G13i,
	      G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
              G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
              G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
              G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 ,
              G60 , G61 , G62 , G63 , G64 , G65 ,
              G00 , GT, GR, ACC, RNK from INV_CCK_FL_23 where GR <> 'R' and gt = 1
       union all
       select G01 , G02 , G03 , G04 , G05 , G05I, G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
              G13 , G13a, G13b, G13v, G13g, G13d, G13e, G13j, G13z, G13i,
	      G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
              G25 , G26 , G27 , G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
              G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
              G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 ,
              G60 , G61 , G62 , G63 , G64 , G65 ,
              G00 , GT, GR, ACC, RNK from INV_CCK_FL_BPKK_23 where gt = 1);

PROMPT *** Create  grants  INV_FL_23 ***
grant SELECT,UPDATE                                                          on INV_FL_23       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on INV_FL_23       to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/INV_FL_23.sql =========*** End *** ====
PROMPT ===================================================================================== 
