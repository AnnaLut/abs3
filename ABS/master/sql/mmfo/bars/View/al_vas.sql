

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AL_VAS.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view AL_VAS ***

  CREATE OR REPLACE FORCE VIEW BARS.AL_VAS ("OTD", "VDAT", "PR", "TT", "NAME", "USERID", "S", "KOL") AS 
  SELECT ot.otd,
            o.vdat,
            DECODE (SUBSTR (t.flags, 1, 1), 1, 'Р', 'П'),
            o.tt,
            SUBSTR (t.name, 1, 20),
            o.userid,
            TO_CHAR (SUM (o.s) / 100, '9999999999.99'),
            COUNT (*)
       FROM oper o, tts t, otd_user ot
      WHERE     o.sos = 5
            AND t.tt = o.tt
            AND ot.userid(+) = o.userid
            AND o.kv = o.kv2
            AND o.kv = 980
   GROUP BY ot.otd,
            o.vdat,
            DECODE (SUBSTR (t.flags, 1, 1), 1, 'Р', 'П'),
            o.tt,
            t.name,
            o.userid
   UNION ALL
     SELECT ot.otd,
            o.vdat,
            DECODE (SUBSTR (t.flags, 1, 1), 1, 'Р', 'П'),
            '---',
            'PA3OM',
            o.userid,
            TO_CHAR (SUM (o.s) / 100, '9999999999.99'),
            COUNT (*)
       FROM oper o, tts t, otd_user ot
      WHERE     o.tt = t.tt
            AND o.sos = 5
            AND o.kv = o.kv2
            AND o.kv = 980
            AND ot.userid = o.userid
   GROUP BY ot.otd,
            o.vdat,
            DECODE (SUBSTR (t.flags, 1, 1), 1, 'Р', 'П'),
            o.userid
   UNION ALL
     SELECT 0,
            o.vdat,
            DECODE (SUBSTR (t.flags, 1, 1), 1, 'Р', 'П'),
            '---',
            'В цўлому ',
            0,
            TO_CHAR (SUM (o.s) / 100, '9999999999.99'),
            COUNT (*)
       FROM oper o, tts t
      WHERE o.tt = t.tt AND o.sos = 5 AND o.kv = o.kv2 AND o.kv = 980
   GROUP BY 0, o.vdat, DECODE (SUBSTR (t.flags, 1, 1), 1, 'Р', 'П');

PROMPT *** Create  grants  AL_VAS ***
grant SELECT                                                                 on AL_VAS          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on AL_VAS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AL_VAS          to SALGL;
grant SELECT                                                                 on AL_VAS          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AL_VAS.sql =========*** End *** =======
PROMPT ===================================================================================== 
