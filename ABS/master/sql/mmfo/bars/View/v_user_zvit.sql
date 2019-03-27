

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_ZVIT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_ZVIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_ZVIT ("USERID", "FIO", "BRANCH", "VDAT", "KF", "REF", "MFOA", "MFOB", "TT", "NAME", "NLSA", "NLSB", "S", "KV", "NAZN", "SOS") AS 
  SELECT a.userid,
          c.fio,
          a.branch,
          a.vdat,
          a.kf,
          a.REF,
          a.mfoa,
          a.mfob,
          a.tt,
          b.name,
          a.nlsa,
          a.nlsb,
          a.s,
          a.kv,
          a.nazn,
          a.sos
     FROM oper a,
          tts b,
          staff$base c,
          V_SFDAT d
    WHERE     a.userid = c.id
          AND b.tt NOT IN ('R01', 'R00', 'RT0')
          AND a.tt = b.tt
          AND c.id NOT IN (1,
                           101501,
                           3509100,
                           2009401)
          AND a.pdat >= d.b
          AND a.pdat <= d.e
          AND a.userid IN (SELECT userid
                             FROM v_role_staff
                            WHERE role_code IN ('RHO045',
                                                'RHO048',
                                                'RHO056',
                                                'RHO065',
                                                'RHO066',
                                                'RHO068',
                                                'RHO071',
                                                'RHO073',
                                                'RHO074',
                                                'RHO075',
                                                'RHO076',
                                                'RHO078',
                                                'RHO081',
                                                'RHO085',
                                                'RHO089',
                                                'RHO090',
                                                'RHO091',
                                                'RHO092',
                                                'RHO093',
                                                'RHO094',
                                                'RHO095',
                                                'RHO096',
                                                'RHO097',
                                                'RHO098',
                                                'RRU003',
                                                'RRU004',
                                                'RRU005',
                                                'RRU006',
                                                'RRU007',
                                                'RRU008',
                                                'RRU009',
                                                'RRU015',
                                                'RRU016',
                                                'RRU017',
                                                'RRU018',
                                                'RRU019',
                                                'RRU020',
                                                'RRU023',
                                                'RRU024',
                                                'RRU045',
                                                'RTVBV12',
                                                'RHO144',
                                                'RHO145',
                                                'RHO147',
                                                'RHO148',
                                                'RHO149',
                                                'RHO150',
                                                'RHO151',
                                                'RHO153',
                                                'RHO154',
                                                'RHO155',
                                                'RHO156',
                                                'RHO158',
                                                'RHO159',
                                                'RHO160',
                                                'RHO161',
                                                'RHO162',
                                                'RHO163',
                                                'RHO164',
                                                'RHO165',
                                                'RHO166',
                                                'RHO169',
                                                'RHO170',
                                                'RHO171',
                                                'RHO172',
                                                'RHO173',
                                                'RHO174',
                                                'RHO175',
                                                'RHO176',
                                                'RHO152'));

PROMPT *** Create  grants  V_USER_ZVIT ***
grant SELECT                                                                 on V_USER_ZVIT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_ZVIT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_ZVIT.sql =========*** End *** ==
PROMPT ===================================================================================== 