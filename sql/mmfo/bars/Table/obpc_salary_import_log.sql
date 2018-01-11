

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_SALARY_IMPORT_LOG.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_SALARY_IMPORT_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_SALARY_IMPORT_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_SALARY_IMPORT_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_SALARY_IMPORT_LOG 
   (	FILE_ID NUMBER, 
	FILE_NAME VARCHAR2(400), 
	CRT_DATE DATE, 
	NLS VARCHAR2(20), 
	FIO VARCHAR2(160), 
	INN VARCHAR2(20), 
	SUMMA NUMBER, 
	STATUS VARCHAR2(100), 
	REF NUMBER, 
	ERROR VARCHAR2(400), 
	LINK VARCHAR2(400)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_SALARY_IMPORT_LOG ***
 exec bpa.alter_policies('OBPC_SALARY_IMPORT_LOG');


COMMENT ON TABLE BARS.OBPC_SALARY_IMPORT_LOG IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.FILE_ID IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.FILE_NAME IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.CRT_DATE IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.NLS IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.FIO IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.INN IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.SUMMA IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.STATUS IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.REF IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.ERROR IS '';
COMMENT ON COLUMN BARS.OBPC_SALARY_IMPORT_LOG.LINK IS '';



PROMPT *** Create  grants  OBPC_SALARY_IMPORT_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_SALARY_IMPORT_LOG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_SALARY_IMPORT_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_SALARY_IMPORT_LOG.sql =========**
PROMPT ===================================================================================== 
