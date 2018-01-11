

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PARTNER_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PARTNER_TYPES ("PARTNER_ID", "PARTNER_NAME", "PARTNER_RNK", "PARTNER_INN", "PARTNER_ACTIVE", "TYPE_ID", "TYPE_NAME", "OBJECT_TYPE", "TARIFF_ID", "FEE_ID", "LIMIT_ID", "ACTIVE", "TARIFF_NAME", "FEE_NAME", "LIMIT_NAME") AS 
  select t."PARTNER_ID",t."PARTNER_NAME",t."PARTNER_RNK",t."PARTNER_INN",t."PARTNER_ACTIVE",t."TYPE_ID",t."TYPE_NAME",t."OBJECT_TYPE",t."TARIFF_ID",t."FEE_ID",t."LIMIT_ID",t."ACTIVE",
       tar.name as tariff_name,
       f.name   as fee_name,
       l.name   as limit_name
  from (select p.partner_id,
               p.name        as partner_name,
               p.rnk         as partner_rnk,
               p.inn         as partner_inn,
               p.active      as partner_active,
               t.id          as type_id,
               t.name        as type_name,
               t.object_type,
               pt.tariff_id,
               pt.fee_id,
               pt.limit_id,
               pt.active
          from ins_partner_types pt, v_ins_partners p, ins_types t
         where pt.partner_id = p.partner_id
           and pt.type_id = t.id
        union
        select p.partner_id,
               p.name        as partner_name,
               p.rnk         as partner_rnk,
               p.inn         as partner_inn,
               p.active      as partner_active,
               t.id          as type_id,
               t.name        as type_name,
               t.object_type,
               p.tariff_id   as tariff_id,
               p.fee_id      as fee_id,
               p.limit_id    as limit_id,
               0             as active
          from v_ins_partners p, ins_types t
         where not exists (select 1
                  from ins_partner_types pt
                 where pt.partner_id = p.partner_id
                   and pt.type_id = t.id)) t,
       ins_tariffs tar,
       ins_fees f,
       ins_limits l
 where t.tariff_id = tar.id(+)
   and t.fee_id = f.id(+)
   and t.limit_id = l.id(+)
 order by t.partner_id, t.active desc, t.type_id;

PROMPT *** Create  grants  V_INS_PARTNER_TYPES ***
grant SELECT                                                                 on V_INS_PARTNER_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_PARTNER_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PARTNER_TYPES.sql =========*** En
PROMPT ===================================================================================== 
