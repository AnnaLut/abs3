

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK_FULL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_TRACK_FULL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_TRACK_FULL ("ID", "MFO", "REQ_ID", "TRACK_ID", "CHANGE_TIME", "FIO", "VIZA", "SOS", "STATUS_NAME", "ID_PREV") AS 
  SELECT t.id,
          SUBSTR (f_ourmfo, 1, 6),
          NULL,
          t.track_id,
          t.change_time,
          NVL (s.fio, 'Ділер'),
          t.new_viza viza,
          t.new_sos sos,
          DECODE (
             t.new_sos,
             0, DECODE (
                   t.new_viza,
                   0, 'Створена НЕзавізована',
                   -1, 'Знята з візи',
                   1, DECODE (
                         NVL (t.old_viza, 0),
                         0, DECODE (
                               NVL (z.id_prev, 0),
                               0, 'Завізована ZAY2',
                                  'Розбиття заявки '
                               || z.id_prev),
                         'Завізована ZAY2'),
                   2, DECODE (
                         NVL (t.old_viza, 0),
                         0, DECODE (
                               NVL (z.id_prev, 0),
                               0, 'Завізована ZAY3',
                                  'Розбиття заявки '
                               || z.id_prev),
                         'Завізована ZAY3'),
                   ''),
             0.5, 'Задоволена ділером, НЕзавізована',
             1, 'Задоволена дилером, завізована',
             2, 'Сплачена',
             -1, 'Видалена',
             '')
             stan_name,
          z.id_prev
     FROM zay_track t, staff s, zayavka z
    WHERE t.userid = s.id(+) AND z.id = t.id
   UNION ALL
   SELECT z.id,
          t.mfo,
          t.req_id,
          t.track_id,
          t.change_time,
          t.fio,
          t.viza,
          t.sos,
          t.viza_name,
          NULL
     FROM zay_track_ru t, zayavka_ru z
    WHERE t.mfo = z.mfo AND t.req_id = z.req_id
   ORDER BY 1, 2;

PROMPT *** Create  grants  V_ZAY_TRACK_FULL ***
grant SELECT                                                                 on V_ZAY_TRACK_FULL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_TRACK_FULL to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK_FULL.sql =========*** End *
PROMPT ===================================================================================== 
