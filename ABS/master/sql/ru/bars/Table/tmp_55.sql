

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_55.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_55 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_55 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_55 
   (	ID NUMBER, 
	CUSTOMER_ID VARCHAR2(4000), 
	CUSTOMER_OKPO VARCHAR2(4000), 
	DEAL_DATE_FROM VARCHAR2(4000), 
	DEAL_NUMBER VARCHAR2(4000), 
	DEAL_SUM VARCHAR2(4000), 
	MFO VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_55 ***
 exec bpa.alter_policies('TMP_55');


COMMENT ON TABLE BARS.TMP_55 IS '';
COMMENT ON COLUMN BARS.TMP_55.ID IS '';
COMMENT ON COLUMN BARS.TMP_55.CUSTOMER_ID IS '';
COMMENT ON COLUMN BARS.TMP_55.CUSTOMER_OKPO IS '';
COMMENT ON COLUMN BARS.TMP_55.DEAL_DATE_FROM IS '';
COMMENT ON COLUMN BARS.TMP_55.DEAL_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_55.DEAL_SUM IS '';
COMMENT ON COLUMN BARS.TMP_55.MFO IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_55.sql =========*** End *** ======
PROMPT ===================================================================================== 
