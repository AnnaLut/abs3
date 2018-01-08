

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_TYPES_OBU.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_TYPES_OBU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_TYPES_OBU ("TYPE_ID", "TYPE_NAME", "OLD_TYPE_ID", "GROUP_ID", "DETAIL_TABLE_ID", "NBS", "S031", "KV", "TP", "KL", "KZ", "KN") AS 
  select p.pawn as type_id,
       p.name as type_name,
       to_number(substr(p.name, 1, instr(p.name, '.') - 1)) as old_type_id,
       null as group_id,
       case
       -- 1 GRT_VEHICLES Транспортні засоби
         when p.pawn in (30, 38, 301, 302, 304) then
          1
       -- 2 GRT_DEPOSITS Майнові права
         when p.pawn in (15,
                         26,
                         29,
                         56,
                         131,
                         132,
                         133,
                         150,
                         151,
                         152,
                         153,
                         154,
                         155,
                         156,
                         161,
                         162,
                         231,
                         232,
                         233,
                         234,
                         235,
                         244,
                         245,
                         246,
                         247,
                         321,
                         322,
                         323) then
          2
       -- 3 GRT_PRODUCTS Пром. товари
         when p.pawn in (16, 17, 27, 28, 303, 305, 306, 307, 308) then
          3
       -- 4 GRT_VALUABLES Цінності
         when p.pawn in (21, 22, 23, 241, 242, 243) then
          4
       -- 5 GRT_MORTGAGE Іпотека
         when p.pawn in (25, 37, 50, 251, 252, 312, 313) then
          5
       -- 6 GRT_MORTGAGE_LAND Земля
         when p.pawn in (311) then
          6
       -- 7 DUAL Поручитель
         when p.pawn in (11, 12, 13, 14, 24, 31, 32, 33, 34) then
          7
       -- 0 DUAL Немає додаткових параметрів
         else
          0
       end as detail_table_id,
       p.nbsz as nbs,
       p.s031 as s031,
       null as kv,
       null as tp,
       null as kl,
       null as kz,
       null as kn
  from cc_pawn p
 where p.d_close is null
 order by p.name;

PROMPT *** Create  grants  V_GRT_TYPES_OBU ***
grant SELECT                                                                 on V_GRT_TYPES_OBU to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRT_TYPES_OBU to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRT_TYPES_OBU to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_TYPES_OBU.sql =========*** End **
PROMPT ===================================================================================== 
