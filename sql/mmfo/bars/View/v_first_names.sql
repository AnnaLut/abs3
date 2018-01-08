

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIRST_NAMES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIRST_NAMES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIRST_NAMES ("FIRSTID", "FIRSTRU", "FIRSTUA", "SEXID", "MIDDLEUAM", "MIDDLEUAF", "MIDDLERUM", "MIDDLERUF", "FIRSTUAOF", "FIRSTUAROD", "FIRSTUADAT", "FIRSTUAVIN", "FIRSTUATVO", "FIRSTUAPRE", "FIRSTRUROD", "FIRSTRUDAT", "FIRSTRUVIN", "FIRSTRUTVO", "FIRSTRUPRE") AS 
  select "FIRSTID","FIRSTRU","FIRSTUA","SEXID","MIDDLEUAM","MIDDLEUAF","MIDDLERUM","MIDDLERUF","FIRSTUAOF","FIRSTUAROD","FIRSTUADAT","FIRSTUAVIN","FIRSTUATVO","FIRSTUAPRE","FIRSTRUROD","FIRSTRUDAT","FIRSTRUVIN","FIRSTRUTVO","FIRSTRUPRE" from FIRST_NAMES;

PROMPT *** Create  grants  V_FIRST_NAMES ***
grant SELECT                                                                 on V_FIRST_NAMES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FIRST_NAMES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIRST_NAMES.sql =========*** End *** 
PROMPT ===================================================================================== 
