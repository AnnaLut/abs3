

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SMSOPERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SMSOPERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SMSOPERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SMSOPERS 
   (	STMT NUMBER(38,0), 
	ACC NUMBER(38,0), 
	BDAYBALANCE NUMBER(24,0), 
	REF NUMBER(38,0), 
	OPERTIME DATE, 
	NUMDOC VARCHAR2(10), 
	DIRECTION NUMBER(2,0), 
	OPERSUM NUMBER(24,0), 
	ENDBALANCE NUMBER(24,0), 
	NAZN VARCHAR2(160), 
	COR_MFO VARCHAR2(12), 
	COR_NLS VARCHAR2(15), 
	COR_NK VARCHAR2(38), 
	SENDEDONOPER NUMBER(1,0) DEFAULT 0, 
	COR_OKPO VARCHAR2(14)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SMSOPERS ***
 exec bpa.alter_policies('TMP_SMSOPERS');


COMMENT ON TABLE BARS.TMP_SMSOPERS IS 'Операції зняття/надходження коштів по рахункам SMS - клієнтів поточного опер. дня (приложення SmsGuard.exe)';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.STMT IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.BDAYBALANCE IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.REF IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.OPERTIME IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.NUMDOC IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.DIRECTION IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.OPERSUM IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.ENDBALANCE IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.COR_MFO IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.COR_NLS IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.COR_NK IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.SENDEDONOPER IS '';
COMMENT ON COLUMN BARS.TMP_SMSOPERS.COR_OKPO IS '';




PROMPT *** Create  constraint TMP_SMSOPERS_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSOPERS ADD CONSTRAINT TMP_SMSOPERS_PK PRIMARY KEY (STMT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217394 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSOPERS MODIFY (SENDEDONOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217393 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSOPERS MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217392 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSOPERS MODIFY (STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TMP_SMSOPERS_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.TMP_SMSOPERS_PK ON BARS.TMP_SMSOPERS (STMT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SMSOPERS.sql =========*** End *** 
PROMPT ===================================================================================== 
