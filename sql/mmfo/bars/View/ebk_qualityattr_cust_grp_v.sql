

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_QUALITYATTR_CUST_GRP_V.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_QUALITYATTR_CUST_GRP_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_QUALITYATTR_CUST_GRP_V ("GROUP_ID", "ID_PRC_QUALITY", "QUALITY_GROUP", "QUALITY_GROUP_DESC") AS 
  select eg.id             as group_id,
       esg.id_grp        as id_prc_quality,
       eqg.qg_name       as quality_group,
       decode (eqg.qg_name, 'default', 'Група ідентифікації', eqg.qg_name) as quality_group_desc
  from ebk_groups          eg
      ,ebk_sub_groups      esg
      ,ebk_quality_groups  eqg
 where eqg.qg_name <> 'card';

PROMPT *** Create  grants  EBK_QUALITYATTR_CUST_GRP_V ***
grant SELECT                                                                 on EBK_QUALITYATTR_CUST_GRP_V to BARSREADER_ROLE;
grant SELECT                                                                 on EBK_QUALITYATTR_CUST_GRP_V to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_QUALITYATTR_CUST_GRP_V to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_QUALITYATTR_CUST_GRP_V.sql ========
PROMPT ===================================================================================== 
