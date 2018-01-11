

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22_CONTROL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22_CONTROL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22_CONTROL ("BRANCH", "NBS", "KOD", "KV", "ISP", "DAOS", "NLS", "NMS", "OSTC", "OB22", "ACC", "TXT") AS 
  SELECT a.branch,
          a.NBS,
          a.nbs || a.ob22 kod,
          a.KV,
          a.ISP,
          a.DAOS,
          a.NLS,
          a.NMS,
          a.OSTc / 100 ostc,
          a.OB22,
          a.ACC,
          case when (select d_close  FROM sb_ob22 where r020||ob22 = a.nbs||a.ob22 and rownum = 1) is null then 'Помилковий ОБ22'
          else 'Аналітика закрита дата закриття -'||(select d_close  FROM sb_ob22 where r020||ob22 = a.nbs||a.ob22 and rownum = 1) end as TXT
     FROM accounts a
    WHERE     a.dazs IS NULL
          AND a.nbs IN (SELECT r020 FROM sb_ob22)
          AND a.nbs || NVL (a.OB22, '##') NOT IN (SELECT r020 || ob22
                                                FROM sb_ob22
                                               WHERE D_CLOSE IS NULL);

PROMPT *** Create  grants  V_OB22_CONTROL ***
grant SELECT                                                                 on V_OB22_CONTROL  to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB22_CONTROL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22_CONTROL  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22_CONTROL.sql =========*** End ***
PROMPT ===================================================================================== 
