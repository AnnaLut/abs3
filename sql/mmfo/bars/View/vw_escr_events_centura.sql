CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_EVENTS_CENTURA
(
   ID,
   NAME,
   EVENT_TYPE,
   BUILD_TYPE_ID,
   OB22,
   EVENT_CODE
)
AS
   WITH ob22_all
        AS (SELECT '220256' ob22, 2 id FROM DUAL
            UNION ALL
            SELECT '220379' ob22, 2 id FROM DUAL -- New
            UNION ALL
            SELECT '220258' ob22, 2 id FROM DUAL
            UNION ALL
            SELECT '220381' ob22, 2 id FROM DUAL -- New
            UNION ALL
            SELECT '220346' ob22, 2 id FROM DUAL
            UNION ALL
            SELECT '220348' ob22, 2 id FROM DUAL
            UNION ALL
            SELECT '220257' ob22, 1 id FROM DUAL
            UNION ALL
            SELECT '220380' ob22, 1 id FROM DUAL -- New
            UNION ALL
            SELECT '220347' ob22, 1 id FROM DUAL)
   SELECT t.id,
          t.name,
          t.event_type,
          t1.build_type_id,
          ob.ob22,
          SUBSTR (t.name, 1, 200) event_code
     FROM escr_events t
          JOIN escr_map_event_to_build_type t1
             ON t.id = t1.event_id AND t.date_to IS NULL
          JOIN ob22_all ob ON ob.id = t.event_type;


GRANT SELECT ON BARS.VW_ESCR_EVENTS_CENTURA TO BARSREADER_ROLE;

GRANT SELECT ON BARS.VW_ESCR_EVENTS_CENTURA TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.VW_ESCR_EVENTS_CENTURA TO UPLD;
