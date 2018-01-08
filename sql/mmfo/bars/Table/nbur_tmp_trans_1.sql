DROP TABLE BARS.NBUR_TMP_TRANS_1 CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_TMP_TRANS_1
(
  REPORT_DATE  DATE                             NOT NULL,
  KF           VARCHAR2(6 BYTE)                 NOT NULL,
  REF          NUMBER(38)                       NOT NULL,
  TT           VARCHAR2(3 BYTE)                 NOT NULL,
  RNK          NUMBER(38)                       NOT NULL,
  ACC          NUMBER(38)                       NOT NULL,
  NLS          VARCHAR2(15 BYTE)                NOT NULL,
  KV           NUMBER(3)                        NOT NULL,
  P10          VARCHAR2(3 BYTE),
  P20          VARCHAR2(16 BYTE),
  P31          VARCHAR2(10 BYTE),
  P32          VARCHAR2(100 BYTE),
  P40          VARCHAR2(2 BYTE),
  P51          VARCHAR2(50 BYTE),
  P52          VARCHAR2(10 BYTE),
  P53          VARCHAR2(135 BYTE),
  P54          VARCHAR2(2 BYTE),
  P55          VARCHAR2(1 BYTE),
  P62          VARCHAR2(1 BYTE),
  REFD         NUMBER,
  D1#E2        VARCHAR2(2 BYTE),
  D6#E2        VARCHAR2(3 BYTE),
  D7#E2        VARCHAR2(10 BYTE),
  D8#E2        VARCHAR2(70 BYTE),
  DA#E2        VARCHAR2(70 BYTE),
  KOD_G        VARCHAR2(16 BYTE),
  NB           VARCHAR2(70 BYTE),
  NAZN         VARCHAR2(70 BYTE),
  NMK          VARCHAR2(70 BYTE),
  BAL_UAH      NUMBER
)
ON COMMIT PRESERVE ROWS
RESULT_CACHE (MODE DEFAULT)
NOCACHE;

COMMENT ON TABLE BARS.NBUR_TMP_TRANS_1 IS 'Тимчасова таблиця для переліку бал.рахунків';



GRANT SELECT ON BARS.NBUR_TMP_TRANS_1 TO BARSREADER_ROLE;

GRANT SELECT ON BARS.NBUR_TMP_TRANS_1 TO UPLD;
