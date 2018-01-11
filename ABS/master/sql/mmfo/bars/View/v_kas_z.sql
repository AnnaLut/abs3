

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KAS_Z.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KAS_Z ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KAS_Z ("SOS", "BRANCH", "KODV", "KV", "DAT2", "S", "KOL", "IDS", "IDI", "IDM", "VID", "REFA", "REFB", "VDAT") AS 
  SELECT sos,
          branch,
          REPLACE (
             INITCAP (
                DECODE (
                   vid,
                   1, NVL (kodv, 'Готівка ' || kz.kv),
                   4, (SELECT UNIQUE
                              REPLACE (
                                 REPLACE (
                                    REPLACE (
                                       REPLACE (name, '"', ''),
                                       'лотерейні білети',
                                       'Лот.біл.'),
                                    'інвестиц.монети',
                                    'Інв.мон.'),
                                 'номінал',
                                 'ном.')
                         FROM valuables
                        WHERE ob22 = kz.kodv),
                   3, (SELECT UNIQUE REPLACE (namemoney, '"', '')
                         FROM spr_mon
                        WHERE kod_money = kz.kodv),
                   2, (SELECT UNIQUE
                              REPLACE (
                                 REPLACE (REPLACE (name, '"', ''), '/', ''),
                                 '\',
                                 '')
                         FROM bank_metals
                        WHERE kod = kz.kodv),
                   kz.kodv)),
             q'[']',
             '`')
             AS kodv,
          kv,
          dat2,
          s,
          kol,
          --nvl(to_char(ids), (select LISTAGG(idm, '; ') WITHIN GROUP (ORDER BY idm) from kas_bu where branch = kz.branch )) as ids,
          ids,
          idi,
          idm, --nvl(idm, (select idm from kas_b where branch = kz.branch )) as idm,
          vid,
          refa,
          refb,
          (SELECT fdat
             FROM opldok
            WHERE REF = kz.refa AND ROWNUM = 1 AND sos >= 0)
             AS vdat
     FROM kas_z kz;

PROMPT *** Create  grants  V_KAS_Z ***
grant SELECT                                                                 on V_KAS_Z         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_KAS_Z         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_KAS_Z         to START1;
grant SELECT                                                                 on V_KAS_Z         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KAS_Z.sql =========*** End *** ======
PROMPT ===================================================================================== 
