PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/type/T_ACC_TRANSACTION.sql =========*** Run *** ========
PROMPT ===================================================================================== 

CREATE OR REPLACE TYPE BARS.T_ACC_TRANSACTION force as object
  (
     REF                  NUMBER(38)
     , SOS                NUMBER(1)
     , STMT               NUMBER(38)
     , TT                 CHAR(3)
     , TXT                VARCHAR2(70 CHAR)
     , KV                 NUMBER(3)
     , BAL                NUMBER(24)
     , BAL_UAH            NUMBER(24)
     , CUST_ID_DB         NUMBER(38)
     , CUST_NAME_DB       VARCHAR2(255 CHAR)
     , CUST_OKPO_DB       VARCHAR2(15 CHAR)          
     , ACC_ID_DB          NUMBER(38)
     , ACC_NUM_DB         VARCHAR2(15 CHAR)
     , R020_DB            VARCHAR2(4 CHAR)
     , CUST_ID_CR         NUMBER(38)
     , CUST_NAME_CR       VARCHAR2(255 CHAR)
     , CUST_OKPO_CR       VARCHAR2(15 CHAR)     
     , ACC_ID_CR          NUMBER(38)
     , ACC_NUM_CR         VARCHAR2(15 CHAR)
     , R020_CR            VARCHAR2(4 CHAR)
     , MFO_DB             VARCHAR2(6 CHAR)
     , BANK_NAME_DB       VARCHAR2(255 CHAR)
     , MFO_CR             VARCHAR2(6 CHAR)
     , BANK_NAME_CR       VARCHAR2(255 CHAR)
     , PURPOSE_OF_PAYMENT VARCHAR2(70 CHAR)
     , OPERATION_DATE     DATE
  );
/
show err;
  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/type/T_ACC_TRANSACTION.sql =========*** End *** ========
PROMPT ===================================================================================== 
