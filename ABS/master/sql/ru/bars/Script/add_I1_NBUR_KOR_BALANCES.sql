CREATE INDEX BARS.I1_NBUR_KOR_BALANCES ON BARS.NBUR_KOR_BALANCES
(REPORT_DATE, KF, ACC_ID, ACC_TYPE)
LOGGING
TABLESPACE BRSDYND
NOPARALLEL 
compute statistics;