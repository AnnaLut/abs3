create or replace force view v_t00_stats_plain
as
SELECT sa.fdat,
                             a.kf,
                             a.acc,
                             s.id,
                             a.nls,
                             s.report_date,
                             sa.ostf,
                             sa.dos,
                             sa.kos,
                             s.amount,
                             sd.stat_type_id,
                             sd.stat_type,
                             sd.stat_id_desc
                        FROM t00_stats s,
                             t00_stats_desc sd,
                             saldoa sa,
                             accounts a
                       WHERE     a.kf = s.kf
                             AND sa.kf = s.kf
                             AND report_date =  NVL (   TO_DATE (PUL.GET ('ZDAT'), 'dd.mm.yyyy'),       GL.BD)
                             AND sa.fdat = report_date
                             AND a.tip = 'T00'
                             AND a.acc = sa.acc
                             AND a.kv = 980
                             AND sd.id = s.stat_id;