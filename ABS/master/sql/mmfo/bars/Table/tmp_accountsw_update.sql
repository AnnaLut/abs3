

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTSW_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCOUNTSW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCOUNTSW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACCOUNTSW_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC NUMBER(38,0), 
	TAG VARCHAR2(8), 
	VALUE VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCOUNTSW_UPDATE ***
 exec bpa.alter_policies('TMP_ACCOUNTSW_UPDATE');


COMMENT ON TABLE BARS.TMP_ACCOUNTSW_UPDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.TAG IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTSW_UPDATE.KF IS '';



PROMPT *** Create  grants  TMP_ACCOUNTSW_UPDATE ***
grant SELECT                                                                 on TMP_ACCOUNTSW_UPDATE to BARSUPL;
grant SELECT                                                                 on TMP_ACCOUNTSW_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTSW_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
