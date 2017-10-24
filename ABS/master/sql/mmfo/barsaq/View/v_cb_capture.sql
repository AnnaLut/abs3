

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_CB_CAPTURE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CB_CAPTURE ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_CB_CAPTURE ("CAPTURE_NAME", "STATUS", "STATE", "STARTUP_TIME", "STATE_CHANGED_TIME", "STATUS_CHANGE_TIME", "ERROR_MESSAGE") AS 
  SELECT dc.capture_name,
          dc.status,
          sc.state,
          sc.startup_time,
          sc.state_changed_time,
          dc.status_change_time,
          dc.error_message
     FROM dba_capture dc, v$streams_capture sc
    WHERE     dc.capture_name in('CB_CAPTURE', 'TR_CAPTURE')
          AND dc.capture_name = sc.capture_name(+);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_CB_CAPTURE.sql =========*** End ***
PROMPT ===================================================================================== 
