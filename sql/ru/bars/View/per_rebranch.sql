

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PER_REBRANCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view PER_REBRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.PER_REBRANCH ("NLSA", "KVA", "MFOB", "NLSB", "KVB", "TT", "VOB", "ND", "DATD", "S", "NAM_A", "NAM_B", "NAZN", "NAZN2", "OKPOA", "OKPOB", "GRP", "REF", "SOS", "ID", "SS") AS 
  with
 parama as (select '/311647/000011/'                                                                           as branch_old,
                   'Ребренчинг 011. Згортання залишку відповідно до наказу №359/П ві 18.07.2013р.'                           as nazn        from DBLIST where rownum = 1 ),
 param  as (select '/311647/000066/'                                                                           as branch_new  from DBLIST where rownum = 1 )
SELECT substr(a.nls,1,14) AS nlsa,
          a.kv,
          a.kf AS mfob,
          substr(nbs_ob22_null (a.nbs, a.ob22, p2.branch_new),1,14) AS nlsb,
          A.KV AS kvb,
          'PS1' AS tt,
          6 AS vob,
          a.nls AS nd,
          SYSDATE AS datd,
          a.ostc AS s,
          a.nms || ' ' || SUBSTR (a.branch, -4) AS nam_a,
         ( select nms||' '||SUBSTR (branch, -4) from accounts where nls = nbs_ob22_null (a.nbs, a.ob22, p2.branch_new) and kv = 980)  AS nam_b,
          p1.nazn,
          '' AS nazn2,
          SUBSTR (f_ourokpo, 1, 8) AS okpoa,
          SUBSTR (f_ourokpo, 1, 8) AS okpob,
          10 AS grp,
          a.nls AS REF,
          0 AS sos,
          ROWNUM AS id,
          a.ostc AS ss
     FROM accounts a, parama p1, param p2
    WHERE     EXISTS
                 (SELECT 1
                    FROM sb_ob22
                   WHERE r020 = a.nbs AND r020 LIKE '6___')
          AND a.branch = p1.branch_old
          AND a.dazs IS NULL
          AND a.ostb > 0
    UNION ALL
      SELECT substr(nbs_ob22_null (a.nbs, a.ob22, p2.branch_new),1,14) AS nlsa,
          a.kv,
          a.kf AS mfob,
          a.nls AS nlsb,
          A.KV AS kvb,
          'PS1' AS tt,
          6 AS vob,
          a.nls AS nd,
          SYSDATE AS datd,
          a.ostc * -1 AS s,
          ( select nms||' '||SUBSTR (branch, -4) from accounts where nls = nbs_ob22_null (a.nbs, a.ob22, p2.branch_new) and kv = 980)  AS nam_a,
          a.nms || ' ' || SUBSTR (a.branch, -4) AS nam_b,
          p1.nazn,
          '' AS nazn2,
          SUBSTR (f_ourokpo, 1, 8) AS okpoa,
          SUBSTR (f_ourokpo, 1, 8) AS okpob,
          10 AS grp,
          a.nls AS REF,
          0 AS sos,
          ROWNUM AS id,
          a.ostc AS ss
     FROM accounts a, parama p1, param p2
    WHERE     EXISTS
                 (SELECT 1
                    FROM sb_ob22
                   WHERE r020 = a.nbs AND r020 LIKE '7___')
          AND a.branch = p1.branch_old
          AND a.dazs IS NULL
          AND a.ostb < 0;

PROMPT *** Create  grants  PER_REBRANCH ***
grant SELECT,UPDATE                                                          on PER_REBRANCH    to BARS015;
grant SELECT,UPDATE                                                          on PER_REBRANCH    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on PER_REBRANCH    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PER_REBRANCH.sql =========*** End *** =
PROMPT ===================================================================================== 
