
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/oo_opldok_record.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.OO_OPLDOK_RECORD AS OBJECT (
  REF     NUMBER,
  STMT    NUMBER,
  FDAT    DATE,
  TT      CHAR(3),
  DK      NUMBER,
  ACC     NUMBER,
  BRANCH  VARCHAR2(30),
  NLS     VARCHAR2(14),
  KV      NUMBER,
  S       NUMBER,
  SQ      NUMBER,
  TXT     VARCHAR2(70),
  SOS     NUMBER,
  ID      NUMBER,
  NMS     VARCHAR2(70),
  OKPO    VARCHAR2(14),
  MFO     VARCHAR2(12),
  ND      VARCHAR2(10),
  PDAT    DATE,
  DATD    DATE,
  SK      NUMBER,
  D_REC   VARCHAR2(60)
   );
/

 show err;
 
PROMPT *** Create  grants  OO_OPLDOK_RECORD ***
grant EXECUTE                                                                on OO_OPLDOK_RECORD to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/oo_opldok_record.sql =========*** End *
 PROMPT ===================================================================================== 
 