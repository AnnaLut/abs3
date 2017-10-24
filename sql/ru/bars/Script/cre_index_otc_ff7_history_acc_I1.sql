-- нужный индекс

CREATE INDEX BARS.OTC_FF7_HISTORY_ACC_I1 ON BARS.OTC_FF7_HISTORY_ACC
(DATF, ACC)
LOGGING
TABLESPACE BRSDYND
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             128K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

