CREATE OR REPLACE VIEW VB_SNO AS
SELECT t.otm
      ,t.spn
      ,t.nd
      ,t.kv
      ,t.acc
      ,t.nls
      ,t.id
      ,t.dat
      ,t.fdat
      ,t.s / 100 s
      ,t.sa / 100 sa
      ,(t.ostf - (SELECT nvl(SUM(s), 0)
                    FROM t2_sno
                   WHERE dat < t.dat
                     AND acc = t.acc)) / 100 ost1
      ,(t.ostf - (SELECT nvl(SUM(s), 0)
                    FROM t2_sno
                   WHERE dat <= t.dat
                     AND acc = t.acc)) / 100 ost2
  FROM t2_sno t
 WHERE acc = to_number(pul.get_mas_ini_val('ACC'));
