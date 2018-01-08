

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPECPARAM_INT_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPECPARAM_INT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPECPARAM_INT_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPECPARAM_INT_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SPECPARAM_INT_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPECPARAM_INT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPECPARAM_INT_UPDATE 
   (	ACC NUMBER(38,0), 
	P080 VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	OB88 VARCHAR2(4), 
	MFO VARCHAR2(6), 
	R020_FA VARCHAR2(4), 
	FDAT DATE, 
	USER_NAME VARCHAR2(30), 
	IDUPD NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPECPARAM_INT_UPDATE ***
 exec bpa.alter_policies('SPECPARAM_INT_UPDATE');


COMMENT ON TABLE BARS.SPECPARAM_INT_UPDATE IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.P080 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.OB22 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.OB88 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.MFO IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.R020_FA IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.USER_NAME IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_SPECPARAMINTUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT_UPDATE ADD CONSTRAINT PK_SPECPARAMINTUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMINTUPD_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT_UPDATE MODIFY (FDAT CONSTRAINT CC_SPECPARAMINTUPD_DATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMINTUPD_USERNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT_UPDATE MODIFY (USER_NAME CONSTRAINT CC_SPECPARAMINTUPD_USERNAME_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMINTUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT_UPDATE MODIFY (IDUPD CONSTRAINT CC_SPECPARAMINTUPD_IDUPD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMINTUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT_UPDATE MODIFY (KF CONSTRAINT CC_SPECPARAMINTUPD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPECPARAMINTUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPECPARAMINTUPDATE ON BARS.SPECPARAM_INT_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPECPARAM_INT_UPDATE ***
grant SELECT                                                                 on SPECPARAM_INT_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on SPECPARAM_INT_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPECPARAM_INT_UPDATE to BARS_DM;
grant SELECT                                                                 on SPECPARAM_INT_UPDATE to RPBN001;
grant SELECT                                                                 on SPECPARAM_INT_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPECPARAM_INT_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
