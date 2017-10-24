

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_SYNCRU_PARAMS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_SYNCRU_PARAMS ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_SYNCRU_PARAMS ("KF", "NAME", "SYNC_SERVICE_URL", "SYNC_LOGIN", "SYNC_PASSWORD", "LAST_SYNC_DATE", "SYNC_ENABLED", "LAST_SYNC_STATUS", "PACK_SIZE") AS 
  SELECT kf,
          name,
          sync_service_url,
          sync_login,
          sync_password,
          last_sync_date,
          sync_enabled,
          last_sync_status,
          pfu_sync_ru.get_packsize AS pack_size
     FROM pfu_syncru_params p;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_SYNCRU_PARAMS.sql =========*** End
PROMPT ===================================================================================== 
