DROP VIEW BARS.VW_ESCR_REF;

/* Formatted on 14/11/2017 17:40:30 (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REF
(
   GOOD_ID,
   GOOD_NAME,
   EVENT_ID,
   EVENT_NAME,
   EVENT_DATE_FROM,
   EVENT_DATE_TO,
   EVENT_TYPE,
   EVENT_TYPE_ID,
   BUILD_TYPE,
   BUILD_TYPE_ID,
   OB22
)
AS
   SELECT t.good_id,
          t.good_name,
          t.event_id,
          t.event_name,
          t.event_date_from,
          t.event_date_to,
          t.event_type,
          t.event_type_id,
          t.build_type,
          t.build_type_id,
          t.ob22
     FROM (WITH ob22_all
                AS (SELECT '220256' ob22, 2 id FROM DUAL
                    UNION ALL
                    SELECT '220379' ob22, 2 id FROM DUAL --New
                    UNION ALL
                    SELECT '220258' ob22, 2 id FROM DUAL
                    UNION ALL
                    SELECT '220381' ob22, 2 id FROM DUAL --New
                    UNION ALL
                    SELECT '220346' ob22, 2 id FROM DUAL
                    UNION ALL
                    SELECT '220348' ob22, 2 id FROM DUAL
                    UNION ALL
                    SELECT '220257' ob22, 1 id FROM DUAL
                    UNION ALL
                    SELECT '220380' ob22, 1 id FROM DUAL --New
                    UNION ALL
                    SELECT '220347' ob22, 1 id FROM DUAL)
             SELECT tt.good_id,
                    tt.good_name,
                    tt.event_name,
                    tt.event_date_from,
                    tt.event_date_to,
                    tt.event_id,
                    tt.event_type,
                    tt.event_type_id,
                    tt.build_type_id,
                    tt.build_type,
                    tt.ob22
               FROM (SELECT g.id good_id,
                            g.good good_name,
                            ev.name event_name,
                            ev.date_from event_date_from,
                            ev.date_to event_date_to,
                            ev.id event_id,
                            CASE ev.event_type
                               WHEN 1 THEN '�����'
                               WHEN 2 THEN '��������'
                            END
                               event_type,
                            ev.event_type event_type_id,
                            bt.id build_type_id,
                            bt.TYPE build_type,
                            ob.ob22 ob22
                       FROM escr_events ev,
                            escr_goods g,
                            escr_map_event_to_build_type eb,
                            escr_map_event_to_good eg,
                            escr_build_types bt,
                            ob22_all ob
                      WHERE     1 = 1
                            AND ev.id = eg.event_id
                            AND g.id = eg.good_id
                            AND eb.event_id = ev.id
                            AND eb.build_type_id = bt.id
                            AND ev.event_type = ob.id
                            AND ev.date_to IS NULL) tt
           ORDER BY tt.good_id, tt.event_id) t;


GRANT SELECT ON BARS.VW_ESCR_REF TO BARS_ACCESS_DEFROLE;
