

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TZAPROS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TZAPROS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TZAPROS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TZAPROS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TZAPROS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TZAPROS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TZAPROS 
   (	REC NUMBER(38,0), 
	ISP NUMBER, 
	OTM NUMBER DEFAULT 0, 
	DAT DATE, 
	REC_O NUMBER, 
	STMP DATE DEFAULT SYSDATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TZAPROS ***
 exec bpa.alter_policies('TZAPROS');


COMMENT ON TABLE BARS.TZAPROS IS 'Информационные запросы СЭП';
COMMENT ON COLUMN BARS.TZAPROS.REC IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.TZAPROS.ISP IS '';
COMMENT ON COLUMN BARS.TZAPROS.OTM IS '';
COMMENT ON COLUMN BARS.TZAPROS.DAT IS '';
COMMENT ON COLUMN BARS.TZAPROS.REC_O IS '';
COMMENT ON COLUMN BARS.TZAPROS.STMP IS '';
COMMENT ON COLUMN BARS.TZAPROS.KF IS '';




PROMPT *** Create  constraint CC_TZAPROS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TZAPROS MODIFY (KF CONSTRAINT CC_TZAPROS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TZAPROS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TZAPROS ADD CONSTRAINT PK_TZAPROS PRIMARY KEY (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_TZAPROS_REC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TZAPROS ADD CONSTRAINT NN_TZAPROS_REC CHECK (REC IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TZAPROS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TZAPROS ON BARS.TZAPROS (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_TZAPROS_KF_REC_OTM ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_TZAPROS_KF_REC_OTM ON BARS.TZAPROS (KF, REC, OTM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TZAPROS ***
grant UPDATE                                                                 on TZAPROS         to BARS014;
grant SELECT                                                                 on TZAPROS         to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on TZAPROS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TZAPROS         to BARS_DM;
grant DELETE,SELECT                                                          on TZAPROS         to PYOD001;
grant DELETE                                                                 on TZAPROS         to SBB_NC;
grant DELETE                                                                 on TZAPROS         to TECH002;
grant SELECT                                                                 on TZAPROS         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TZAPROS         to WR_ALL_RIGHTS;
grant DELETE,SELECT                                                          on TZAPROS         to WR_QDOCS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TZAPROS.sql =========*** End *** =====
PROMPT ===================================================================================== 
