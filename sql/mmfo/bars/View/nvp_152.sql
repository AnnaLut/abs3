

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NVP_152.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view NVP_152 ***

  CREATE OR REPLACE FORCE VIEW BARS.NVP_152 ("ND", "MDAT", "CDAT", "SS", "SP", "SN", "SPI", "SPN", "SDI", "SNO", "SNA", "REZ", "BV", "IR", "EPS1", "NR", "NOM1", "AR", "KV", "VIDD", "SE") AS 
  select "ND","MDAT","CDAT","SS","SP","SN","SPI","SPN","SDI","SNO","SNA","REZ","BV","IR","EPS1","NR","NOM1","AR","KV","VIDD","SE" from PRVN_BV_DETAILS 
 where MDAT= to_date('01.01.2016','dd.mm.yyyy') and ND=4307355 and kv=980;

PROMPT *** Create  grants  NVP_152 ***
grant SELECT                                                                 on NVP_152         to BARSREADER_ROLE;
grant SELECT                                                                 on NVP_152         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NVP_152         to START1;
grant SELECT                                                                 on NVP_152         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NVP_152.sql =========*** End *** ======
PROMPT ===================================================================================== 
