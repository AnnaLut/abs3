create or replace view V_DPT_FILE_ROW
( INFO_ID
, HEADER_ID
, NLS
, BRANCH_CODE
, DPT_CODE
, SUM
, FIO
, PASP
, ID_CODE
, PAYOFF_DATE
, MARKED4PAYMENT
, BRANCH
, AGENCY_ID
, AGENCY_NAME
, REF
, INCORRECT
, CLOSED
, EXCLUDED
, DEAL_CREATED
, ACC_TYPE
, REAL_ACC_NUM
, REAL_CUST_NAME
, REAL_CUST_CODE
, ERROR_TEXT
) AS
SELECT r.INFO_ID,
       r.HEADER_ID,
       r.NLS,
       r.BRANCH_CODE,
       r.DPT_CODE,
       r.SUM,
       r.FIO,
       r.PASP,
       r.ID_CODE,
       r.PAYOFF_DATE,
       r.MARKED4PAYMENT,
       r.BRANCH,
       r.AGENCY_ID,
       r.AGENCY_NAME,
       r.REF,
       r.INCORRECT,
       r.CLOSED,
       r.EXCLUDED,
       r.DEAL_CREATED,
       r.ACC_TYPE,
       r.NLS,
       r.FIO,
       r.ID_CODE,
       r.ERR_MSG
  from DPT_FILE_ROW r
;

show errors

grant SELECT on V_DPT_FILE_ROW to BARS_ACCESS_DEFROLE;
grant SELECT on V_DPT_FILE_ROW to DPT_ROLE;
grant SELECT on V_DPT_FILE_ROW to WR_ALL_RIGHTS;
