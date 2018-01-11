

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_ARCH_PEREOC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_ARCH_PEREOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_ARCH_PEREOC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_ARCH_PEREOC'', ''FILIAL'' , null, null, null, null);
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
	ACC NUMBER(*,0), 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	SKOR NUMBER, 
	COMM VARCHAR2(200), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
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
COMMENT ON COLUMN BARS.OTCN_ARCH_PEREOC.KF IS '';




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




PROMPT *** Create  constraint CC_OTCNARCHPEREOC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (KF CONSTRAINT CC_OTCNARCHPEREOC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006140 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006141 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006142 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006143 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ARCH_PEREOC MODIFY (KODP NOT NULL ENABLE)';
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



PROMPT *** Create  grants  OTCN_ARCH_PEREOC ***
grant SELECT                                                                 on OTCN_ARCH_PEREOC to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_ARCH_PEREOC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_ARCH_PEREOC to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_ARCH_PEREOC to START1;
grant SELECT                                                                 on OTCN_ARCH_PEREOC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_ARCH_PEREOC.sql =========*** End 
PROMPT ===================================================================================== 
