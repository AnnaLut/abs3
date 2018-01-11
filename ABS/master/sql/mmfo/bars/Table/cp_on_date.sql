

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ON_DATE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ON_DATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ON_DATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ON_DATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ON_DATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ON_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ON_DATE 
   (	USER_ID NUMBER DEFAULT sys_context(''bars_global'', ''user_id''), 
	ID NUMBER, 
	CP_ID VARCHAR2(20), 
	RYN NUMBER, 
	RYN_NAME VARCHAR2(35), 
	REF NUMBER, 
	ERAT NUMBER, 
	DOX NUMBER, 
	EMI NUMBER, 
	KV NUMBER, 
	MDATE DATE, 
	OSTA NUMBER, 
	PF NUMBER, 
	PF_NAME VARCHAR2(70), 
	DATD DATE, 
	ND VARCHAR2(32), 
	RNK NUMBER, 
	SUMB NUMBER, 
	VIDD NUMBER, 
	IR NUMBER, 
	MO_PR NUMBER, 
	OSTD NUMBER, 
	OSTP NUMBER, 
	OSTR NUMBER, 
	OSTR2 NUMBER, 
	OSTS NUMBER, 
	OSTAB NUMBER, 
	OSTAF NUMBER, 
	P_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ON_DATE ***
 exec bpa.alter_policies('CP_ON_DATE');


COMMENT ON TABLE BARS.CP_ON_DATE IS 'Таблиця для звіту ЦП Портфель на дату';
COMMENT ON COLUMN BARS.CP_ON_DATE.USER_ID IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.ID IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.CP_ID IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.RYN IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.RYN_NAME IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.REF IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.ERAT IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.DOX IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.EMI IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.KV IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.MDATE IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTA IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.PF IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.PF_NAME IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.DATD IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.ND IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.RNK IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.SUMB IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.VIDD IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.IR IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.MO_PR IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTD IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTP IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTR IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTR2 IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTS IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTAB IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.OSTAF IS '';
COMMENT ON COLUMN BARS.CP_ON_DATE.P_DATE IS '';




PROMPT *** Create  index IDX1_CPONDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX1_CPONDATE ON BARS.CP_ON_DATE (USER_ID, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ON_DATE ***
grant SELECT                                                                 on CP_ON_DATE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ON_DATE      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ON_DATE.sql =========*** End *** ==
PROMPT ===================================================================================== 
