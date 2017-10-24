

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3800_TABVAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V3800_TABVAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V3800_TABVAL ("COIN", "KV", "GRP", "NAME", "LCV", "NOMINAL", "SV", "DIG", "DENOM", "UNIT", "COUNTRY", "BASEY", "GENDER", "PRV", "D_CLOSE", "FX_BASE", "SKV", "S0000", "S3800", "S3801", "S3802", "S6201", "S7201", "S9282", "S9280", "S9281", "S0009", "G0000") AS 
  select "COIN","KV","GRP","NAME","LCV","NOMINAL","SV","DIG","DENOM","UNIT","COUNTRY","BASEY","GENDER","PRV","D_CLOSE","FX_BASE","SKV","S0000","S3800","S3801","S3802","S6201","S7201","S9282","S9280","S9281","S0009","G0000" from tabval t
  where exists (select kv from accounts where nbs ='3800' and dazs is null and kv = t.kv) and kv <> 980 ;

PROMPT *** Create  grants  V3800_TABVAL ***
grant SELECT                                                                 on V3800_TABVAL    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3800_TABVAL.sql =========*** End *** =
PROMPT ===================================================================================== 
