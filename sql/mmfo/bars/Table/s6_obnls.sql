

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_OBNLS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_OBNLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_OBNLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_OBNLS 
   (	DA DATE, 
	NLS VARCHAR2(25), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	DOS NUMBER(16,2), 
	KOS NUMBER(16,2), 
	DOS_V NUMBER(16,2), 
	KOS_V NUMBER(16,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_OBNLS ***
 exec bpa.alter_policies('S6_OBNLS');


COMMENT ON TABLE BARS.S6_OBNLS IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.DA IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.NLS IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.I_VA IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.DOS IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.KOS IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.DOS_V IS '';
COMMENT ON COLUMN BARS.S6_OBNLS.KOS_V IS '';




PROMPT *** Create  constraint SYS_C009669 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (DA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009670 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009671 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009672 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009673 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009674 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009675 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (DOS_V NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009676 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_OBNLS MODIFY (KOS_V NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_OBNLS ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_OBNLS ON BARS.S6_OBNLS (NLS, I_VA, GROUP_U) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_OBNLS ***
grant SELECT                                                                 on S6_OBNLS        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_OBNLS        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_OBNLS        to START1;
grant SELECT                                                                 on S6_OBNLS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_OBNLS.sql =========*** End *** ====
PROMPT ===================================================================================== 
