

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_SUB_GROUPS_PRIV.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_SUB_GROUPS_PRIV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_SUB_GROUPS_PRIV ("ID_GRP", "GROUP_NAME", "ID_PRC_QUALITY", "PRC_QUALITY_TXT", "PRC_QUALITY_NAME", "PRC_QUALITY_DESCR", "PRC_QUALITY_ORD") AS 
  select id_grp,
          group_name,
          id_prc_quality,
          case prc_quality_ord
          when 1 then 'Перша група'
          when 2 then 'Друга група'
          when 3 then 'Третя група'
          when 4 then 'Четверта група'
          when 5 then 'П''ята група'
          when 6 then 'Шоста група'
          when 7 then 'Сьома група'
          when 8 then 'Восьма група'
          when 9 then 'Дев''ята група'
          when 10 then 'Десята група'
          else
           prc_quality_ord||' група'
          end
          as prc_quality_txt,
          prc_quality_name,
          prc_quality_descr,
          prc_quality_ord
  from (
   select esg.id_grp,
          (select name
             from ebkc_groups
            where id = esg.id_grp and cust_type = 'L')
             as group_name,
          esg.id_prc_quality,
             count (1) over (partition by id_grp order by id_prc_quality)
          as prc_quality_ord,
          (select name
             from ebk_prc_quality
            where id = esg.id_prc_quality)
             as prc_quality_name,
          (select descr
             from ebk_prc_quality
            where id = esg.id_prc_quality)
             as prc_quality_descr
     from ebkc_sub_groups esg );

PROMPT *** Create  grants  V_EBKC_SUB_GROUPS_PRIV ***
grant SELECT                                                                 on V_EBKC_SUB_GROUPS_PRIV to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_SUB_GROUPS_PRIV to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_SUB_GROUPS_PRIV to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_SUB_GROUPS_PRIV.sql =========***
PROMPT ===================================================================================== 
