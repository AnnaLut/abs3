

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_TRACK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_TRACK ("ID", "TRACK_ID", "CHANGE_TIME", "FIO", "VIZA", "VIZA_NAME") AS 
  SELECT z.id,
            z.track_id,
            z.change_time,
            s.fio,
            z.new_viza viza,
            DECODE (z.new_viza,
                    0, 'Створена НЕвізована',
                    1, 'Завізована ZAY2',
                    2, 'Завізована ZAY3',
                    -1, 'Знята з візи',
                    '')
               viza_name
       FROM zay_track z, staff s
      WHERE z.userid = s.id AND z.new_sos = 0
   ORDER BY z.id, z.track_id;

PROMPT *** Create  grants  V_ZAY_TRACK ***
grant SELECT                                                                 on V_ZAY_TRACK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_TRACK     to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK.sql =========*** End *** ==
PROMPT ===================================================================================== 
