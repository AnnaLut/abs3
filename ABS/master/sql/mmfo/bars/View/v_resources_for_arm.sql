

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_ARM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RESOURCES_FOR_ARM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RESOURCES_FOR_ARM ("ARM_ID", "ARM_CODE", "ARM_FRONTEND", "ARM_NAME", "RESOURCE_ID", "RESOURCE_TYPE", "RESOURCE_CODE", "RESOURCE_NAME", "CURRENT_ACCESS_MODE_NAME", "NEW_ACCESS_MODE_NAME", "APPROVEMENT") AS 
  (select a.id arm_id,                                                                     -- мдентификатор АРМа
       a.codeapp arm_code,                                                              -- код АРМа
       a.frontend arm_frontend,                                                         -- признак использования АРМа в веб-интрефейсе (arm_frontend = 1) или в Центуре (arm_frontend = 0)
       a.name arm_name,                                                                 -- название АРМа
       t.resource_id,                                                                   -- идентификатор ресурса
       ort.resource_name resource_type,                                                 -- имя типа ресурса
       resource_utl.get_resource_code(t.resource_type_id, t.resource_id) resource_code, -- код ресурса
       resource_utl.get_resource_name(t.resource_type_id, t.resource_id) resource_name, -- название ресурса
       list_utl.get_item_name(rel.access_mode_list_id, nvl(r.access_mode_id, rel.no_access_item_id)) current_access_mode_name, -- текущий уровень доступа к данному ресурсу из АРМа
       list_utl.get_item_name(rel.access_mode_list_id, t.last_access_mode_id) new_access_mode_name,                            -- будущий уровень доступа к ресурсу
       case when t.last_resolution_type_id is null then 'Не підтверджений' else 'Підтверджений' end approvement                -- признак того, что текущий уровень доступа подтвержден
from   (select s.grantee_type_id, s.grantee_id, s.resource_type_id, s.resource_id,
               min(s.access_mode_id) keep (dense_rank last order by s.id) last_access_mode_id,
               min(s.resolution_type_id) keep (dense_rank last order by s.id) last_resolution_type_id
        from   adm_resource_activity s
        group by s.grantee_type_id, s.grantee_id, s.resource_type_id, s.resource_id) t
join   adm_resource_type art on art.id = t.grantee_type_id and
                                art.resource_code in ('ARM_CENTURA', 'ARM_WEB')
join   adm_resource_type ort on ort.id = t.resource_type_id
join   adm_resource_type_relation rel on rel.grantee_type_id = art.id and
                                         rel.resource_type_id = ort.id
join   applist a on a.id = t.grantee_id
                   -- and  a.codeapp in ('QWQW') -- фильтровать АРМы здесь
left join adm_resource r on r.grantee_type_id = t.grantee_type_id and
                            r.grantee_id = t.grantee_id and
                            r.resource_type_id = t.resource_type_id and
                            r.resource_id = t.resource_id
							);

PROMPT *** Create  grants  V_RESOURCES_FOR_ARM ***
grant SELECT                                                                 on V_RESOURCES_FOR_ARM to BARSREADER_ROLE;
grant SELECT                                                                 on V_RESOURCES_FOR_ARM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RESOURCES_FOR_ARM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_ARM.sql =========*** En
PROMPT ===================================================================================== 
