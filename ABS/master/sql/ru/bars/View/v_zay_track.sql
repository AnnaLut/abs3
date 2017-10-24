

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_TRACK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_TRACK ("ID", "TRACK_ID", "CHANGE_TIME", "FIO", "VIZA", "VIZA_NAME") AS 
  select z.id, z.track_id, z.change_time, s.fio,
       z.new_viza viza,
       decode (z.new_viza,
               0, 'Введена НЕзавизирована',
               1, 'Завизирована визой ZAY2',
               2, 'Завизирована визой ZAY3',
               -1, 'Снята с визы',
               '') viza_name
  from zay_track z, staff s
 where z.userid = s.id and z.new_sos = 0
 order by z.id, z.track_id;

PROMPT *** Create  grants  V_ZAY_TRACK ***
grant SELECT                                                                 on V_ZAY_TRACK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_TRACK     to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK.sql =========*** End *** ==
PROMPT ===================================================================================== 
