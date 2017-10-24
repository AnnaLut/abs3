

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PZ3_GRC_ZZ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PZ3_GRC_ZZ ***

  CREATE OR REPLACE PROCEDURE BARS.PZ3_GRC_ZZ IS
--
-- Подготовка данных по межобластным оборотам(для головного банка по 3 модели)
--
l_dat          DATE;
l_dat_a        DATE;
l_dat_b        DATE;
G_NBU_mfo     VARCHAR(12) DEFAULT NULL;

BEGIN
l_dat    := to_date('13.03.2008','DD.MM.YYYY');
l_dat_a  := l_dat;
l_dat_b  := l_dat_a+1;

G_NBU_mfo := sep.get_nbu_mfo;

INSERT INTO pers_z3 (id1,id2,n,s)

SELECT id1,id2,SUM(n) n,SUM(s) s
  FROM

(SELECT
       SUBSTR(c.sab,2,1) id1,SUBSTR(d.sab,2,1) id2,count(*) n,sum(s) s
   FROM arc_rrp x,banks c,banks d
  WHERE x.dk = 1 AND x.kv=980
    AND x.mfoa<>G_NBU_mfo AND x.mfob<>G_NBU_mfo
    AND x.mfoa = c.mfo AND c.mfop<>G_NBU_mfo AND
        (c.mfop=gl.aMFO OR c.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND x.mfob = d.mfo AND d.mfop<>G_NBU_mfo AND
    (d.mfop=gl.aMFO OR d.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND  x.dat_b >= l_dat_a AND x.dat_b < l_dat_b
  GROUP BY SUBSTR(c.sab,2,1), SUBSTR(d.sab,2,1)

  UNION ALL

 SELECT
    SUBSTR(d.sab,2,1) id1,SUBSTR(c.sab,2,1) id2,count(*) n,sum(s) s
   FROM arc_rrp x,banks c,banks d
  WHERE x.dk = 0 AND x.kv=980
    AND x.mfoa<>G_NBU_mfo AND x.mfob<>G_NBU_mfo
    AND x.mfob = c.mfo AND c.mfop<>G_NBU_mfo AND
        (c.mfop=gl.aMFO OR c.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND x.mfoa = d.mfo AND d.mfop<>G_NBU_mfo AND
    (d.mfop=gl.aMFO OR d.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND  x.dat_b >= l_dat_a AND x.dat_b < l_dat_b
  GROUP BY SUBSTR(d.sab,2,1), SUBSTR(c.sab,2,1)
  UNION ALL
 select id1.id,id2.id,0,0 from
(SELECT UNIQUE decode(substr(a.sab,2,1),'J','I','1','I',substr(a.sab,2,1)) id
 FROM banks a
 WHERE SUBSTR(a.sab,2,1) BETWEEN 'A' AND 'Z') id1,
(SELECT UNIQUE decode(substr(a.sab,2,1),'J','I','1','I',substr(a.sab,2,1)) id
 FROM banks a
 WHERE SUBSTR(a.sab,2,1) BETWEEN 'A' AND 'Z') id2
)
 GROUP BY id1,id2;
END pz3_grc_zz;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PZ3_GRC_ZZ.sql =========*** End **
PROMPT ===================================================================================== 
