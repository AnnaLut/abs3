

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_ARCH_PEREOC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_ARCH_PEREOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_ARCH_PEREOC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_ARCH_PEREOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_ARCH_PEREOC 
   (	DATF DATE, 
	KODF CHAR(2), 
	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	SKOR NUMBER, 
	COMM VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_ARCH_PEREOC ***
 exec bpa.alter_policies('OTCN_ARCH_PEREOC');


COMMENT ON TABLE BARS.OTCN_ARCH_PEREOC IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.KODF IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.KV IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.ODATE IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.SKOR IS '';
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.COMM IS '';




PROMPT *** Create  constraint PK_OTCN_ARCH_PEREOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC ADD CONSTRAINT PK_OTCN_ARCH_PEREOC PRIMARY KEY (DATF, KODF, ACC, KODP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001619755 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (KODP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001619754 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001619753 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001619752 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_ARCH_PEREOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_ARCH_PEREOC ON BARS.OTCN_ARCH_PEREOC (DATF, KODF, ACC, KODP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_ARCH_PEREOC.sql =========*** End 
PROMPT ===================================================================================== 
