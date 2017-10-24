CREATE OR REPLACE VIEW CC_W_GLK1 AS
SELECT to_number(pul.get_mas_ini_val('ND')) nd
      ,x.fdat
      ,x.lim2
      ,nvl(x.ost, 0) ost
      ,x.lim2 + x.ost del2
      ,x.fdat - 1 fdat1
      ,decode(x.fdat1
             ,NULL
             ,x.lim2
             ,(SELECT lim2 / 100
                FROM cc_lim
               WHERE nd = x.nd
                 AND fdat = x.fdat1)) lim1
      ,(SELECT txt
          FROM nd_txt
         WHERE nd = x.nd
           AND tag = 'D9129') / 100 d9129
      ,x.not_sn daysn
      ,NULL upd_flag
  FROM (SELECT nd
              ,fdat
              ,lim2 / 100 lim2
              ,sumg / 100 sumg
              ,fost(acc, fdat) / 100 ost
              ,(SELECT MAX(fdat)
                  FROM cc_lim
                 WHERE nd = l.nd
                   AND fdat < l.fdat) fdat1
              ,l.not_sn
          FROM cc_lim l
         WHERE nd = to_number(pul.get_mas_ini_val('ND'))) x;
