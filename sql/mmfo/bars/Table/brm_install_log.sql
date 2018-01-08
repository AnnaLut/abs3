

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRM_INSTALL_LOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRM_INSTALL_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRM_INSTALL_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BRM_INSTALL_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRM_INSTALL_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRM_INSTALL_LOG 
   (	REC_ID NUMBER, 
	REC_DATE DATE DEFAULT sysdate, 
	INST_TYPE VARCHAR2(10), 
	INST_NAME VARCHAR2(50), 
	REC_MESSAGE VARCHAR2(250), 
	BARS_HASH VARCHAR2(32), 
	DBNAME VARCHAR2(24), 
	MFO VARCHAR2(6), 
	GLBNAME VARCHAR2(64), 
	USERNAME VARCHAR2(64), 
	MACHINE_NAME VARCHAR2(64), 
	MACHINE_IP VARCHAR2(24)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRM_INSTALL_LOG ***
 exec bpa.alter_policies('BRM_INSTALL_LOG');


COMMENT ON TABLE BARS.BRM_INSTALL_LOG IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.REC_ID IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.REC_DATE IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.INST_TYPE IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.INST_NAME IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.REC_MESSAGE IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.BARS_HASH IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.DBNAME IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.MFO IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.GLBNAME IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.USERNAME IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.MACHINE_NAME IS '';
COMMENT ON COLUMN BARS.BRM_INSTALL_LOG.MACHINE_IP IS '';




PROMPT *** Create  constraint XPK_BRM_INSTALL_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRM_INSTALL_LOG ADD CONSTRAINT XPK_BRM_INSTALL_LOG PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BRM_INSTALL_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BRM_INSTALL_LOG ON BARS.BRM_INSTALL_LOG (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRM_INSTALL_LOG ***
grant SELECT                                                                 on BRM_INSTALL_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRM_INSTALL_LOG.sql =========*** End *
PROMPT ===================================================================================== 
