PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TRANSACTIONS.sql =========*** Run *** =====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to TMP_TRANSACTIONS ***

BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TRAMNSACTIONS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_TRANSACTIONS 
   (	
     REPORT_DATE DATE,
     KF          VARCHAR2(6),
     FILE_CODE   VARCHAR2(3),
     REF         NUMBER(38),
     TT          CHAR(3),
     CCY_ID      NUMBER(3),
     BAL         NUMBER(24),
     BAL_UAH     NUMBER(24),
     CUST_ID_DB  NUMBER(38),
     ACC_ID_DB   NUMBER(38),
     R020_DB     CHAR(4),
     ACC_NUM_DB  VARCHAR2(15),
     NBUC_DB     VARCHAR2(20),
     CUST_ID_CR  NUMBER(38),
     ACC_ID_CR   NUMBER(38),
     R020_CR     CHAR(4),
     ACC_NUM_CR  VARCHAR2(15),
     NBUC_CR     VARCHAR2(20)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** ALTER_POLICIES to TMP_TRANSACTIONS ***
 exec bpa.alter_policies('TMP_TRANSACTIONS');

COMMENT ON TABLE BARS.TMP_TRANSACTIONS IS 'Временная таблица операций для процедуры NBUR_P_F73X';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.REPORT_DATE IS 'Calculation date';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.KF IS 'Bank code';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.FILE_CODE IS 'File code';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.REF IS 'Document identifier';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.TT IS 'Transaction type code';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.CCY_ID IS 'Currency identifier';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.BAL IS 'Transaction amount';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.BAL_UAH IS 'Transaction amount in UAH';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.CUST_ID_DB IS 'Customer identifier Debit side transaction (sender)';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.ACC_ID_DB IS 'Account identifier Debit side transaction';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.R020_DB IS 'Account code Debit side transaction';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.ACC_NUM_DB IS 'Account number Debit side transaction';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.CUST_ID_CR IS 'Customer identifier Credit side transaction (receiver)';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.ACC_ID_CR IS 'Account identifier Credit side transaction';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.R020_CR IS 'Account parameter Credit side transaction';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.ACC_NUM_CR IS 'Account number Credit side transaction';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.NBUC_DB IS '';
COMMENT ON COLUMN BARS.TMP_TRANSACTIONS.NBUC_CR IS '';

PROMPT *** Create  grants  TMP_TRANSACTIONS ***

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TRANSACTIONS.sql =========*** End *** =====
PROMPT =====================================================================================