

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_PREPARE.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** DROP  view V_CP_PREPARE ***
begin
execute immediate 'DROP  view V_CP_PREPARE';
exception
when others then null;
end;
/
/*
PROMPT *** Create  view V_CP_PREPARE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_PREPARE ("RUNN", "ACC", "NMSA", "NLSA", "KVA", "ID_A", "NMSB", "NLSB", "KVB", "ID_B", "FDAT", "TDAT", "IR", "OSTT", "INT", "OST", "NAZN", "TT") AS 
  SELECT "RUNN","ACC","NMSA","NLSA","KVA","ID_A","NMSB","NLSB","KVB","ID_B","FDAT","TDAT","IR","OSTT","INT","OST","NAZN","TT"
     FROM TABLE (value_paper.make_int_prepare);

PROMPT *** Create  grants  V_CP_PREPARE ***
grant SELECT                                                                 on V_CP_PREPARE    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_PREPARE    to UPLD;
*/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_PREPARE.sql =========*** End *** =
PROMPT ===================================================================================== 
