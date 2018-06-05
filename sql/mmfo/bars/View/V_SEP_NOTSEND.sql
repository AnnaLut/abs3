create or replace force view BARS.V_SEP_NOTSEND
as
SELECT op.REF,
       op.TT,
       op.vob,
       op.pdat,
       op.vdat,
       op.kv,
       op.s/100 as s,
       op.nam_a,
       op.nlsa,
       op.mfoa,
       op.nam_b,
       op.nlsb,
       op.mfob,
       op.nazn,
       op.sos,
       op.odat,
       op.kf
  FROM oper op
       JOIN
       (SELECT o.*
          FROM opldok o, (SELECT acc
                               FROM accounts
                              WHERE tip = 'T00' AND dazs IS NULL) a
         WHERE o.fdat >= NVL (TO_DATE (
                                            pul.get_mas_ini_val (
                                               'sFdat1'),
                                            'dd.mm.yyyy'),
                                         gl.bd) - 5 
               and o.fdat <= NVL (TO_DATE (
                                            pul.get_mas_ini_val (
                                               'sFdat1'),
                                            'dd.mm.yyyy'),
                                         gl.bd)
               --BETWEEN TRUNC (SYSDATE) - 30 AND TRUNC (SYSDATE)
               AND o.acc = a.acc
               AND o.dk = 1
               AND o.sos = 5
               AND o.tt NOT IN ('R00',
                                'R02',
                                'R01',
                                'RT1')
               AND NOT EXISTS
                      (SELECT 1
                         FROM arc_rrp
                        WHERE REF = o.REF)) d
          ON op.REF = d.REF;
          
grant select on BARS.V_SEP_NOTSEND to bars_access_defrole;