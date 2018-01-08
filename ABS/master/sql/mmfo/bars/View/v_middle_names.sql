

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MIDDLE_NAMES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MIDDLE_NAMES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MIDDLE_NAMES ("MIDDLEID", "MIDDLEUA", "MIDDLERU", "SEXID", "FIRSTID", "MIDDLEUAOF", "MIDDLEUAROD", "MIDDLEUADAT", "MIDDLEUAVIN", "MIDDLEUATVO", "MIDDLEUAPRE", "MIDDLERUROD", "MIDDLERUDAT", "MIDDLERUVIN", "MIDDLERUTVO", "MIDDLERUPRE") AS 
  select "MIDDLEID","MIDDLEUA","MIDDLERU","SEXID","FIRSTID","MIDDLEUAOF","MIDDLEUAROD","MIDDLEUADAT","MIDDLEUAVIN","MIDDLEUATVO","MIDDLEUAPRE","MIDDLERUROD","MIDDLERUDAT","MIDDLERUVIN","MIDDLERUTVO","MIDDLERUPRE" from MIDDLE_NAMES;

PROMPT *** Create  grants  V_MIDDLE_NAMES ***
grant SELECT                                                                 on V_MIDDLE_NAMES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MIDDLE_NAMES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MIDDLE_NAMES.sql =========*** End ***
PROMPT ===================================================================================== 
