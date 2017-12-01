PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_REFW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create or replace view V_CP_REFW ***
PROMPT Нотатка: після оновлення вьюхи потрібно перестворювати тріггер на неї

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_REFW ("REF", "TAG", "NAME", "DICT_NAME", "VALUE", "ID_CP", "NAME_OP") AS 
  select a.ref, t.tag, t.name, t.dict_name, (select substr(value,1,255) from  cp_refw where ref= a.ref and tag = t.tag),
         a.id, (select name from cp_op where op = a.op) name_op
from cp_arch a, v3_cp_tag t order by t.tag;

PROMPT *** Create  grants  V_CP_REFW ***
grant SELECT,UPDATE                                                          on V_CP_REFW       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_REFW       to START1;




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_REFW.sql =========*** End *** ====
PROMPT ===================================================================================== 
