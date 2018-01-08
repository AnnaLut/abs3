

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_LOB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_LOB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_LOB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_LOB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPA_LOB'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_LOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_LOB 
   (	ID NUMBER(22,0), 
	FILE_DATA CLOB, 
	FILE_NAME VARCHAR2(50), 
	USERID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_LOB ***
 exec bpa.alter_policies('DPA_LOB');


COMMENT ON TABLE BARS.DPA_LOB IS '';
COMMENT ON COLUMN BARS.DPA_LOB.ID IS '';
COMMENT ON COLUMN BARS.DPA_LOB.FILE_DATA IS '';
COMMENT ON COLUMN BARS.DPA_LOB.FILE_NAME IS '';
COMMENT ON COLUMN BARS.DPA_LOB.USERID IS '';
COMMENT ON COLUMN BARS.DPA_LOB.KF IS '';




PROMPT *** Create  constraint CC_DPALOB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_LOB MODIFY (KF CONSTRAINT CC_DPALOB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPA_LOB_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_LOB ADD CONSTRAINT PK_DPA_LOB_ID PRIMARY KEY (ID, USERID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPA_LOB_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPA_LOB_ID ON BARS.DPA_LOB (ID, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_LOB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_LOB         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_LOB         to RPBN002;



PROMPT *** Create SYNONYM  to DPA_LOB ***

  CREATE OR REPLACE PUBLIC SYNONYM DPA_LOB FOR BARS.DPA_LOB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_LOB.sql =========*** End *** =====
PROMPT ===================================================================================== 
