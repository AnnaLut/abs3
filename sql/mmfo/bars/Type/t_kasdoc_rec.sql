
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_kasdoc_rec.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_KASDOC_REC AS OBJECT (
  pdat   DATE,
  ref    NUMBER (38),
  vdat     DATE,
  tt       CHAR(3),
  fio      VARCHAR(60),
  ptime   VARCHAR(8),
  sq       NUMBER(24),
  s        NUMBER(24),
  br_name  VARCHAR2(70)
)
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_kasdoc_rec.sql =========*** End *** =
 PROMPT ===================================================================================== 
 