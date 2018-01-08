

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INST_TYPE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INST_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INST_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.INST_TYPE 
   (	CB NUMBER, 
	INST_TYPE VARCHAR2(4), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INST_TYPE ***
 exec bpa.alter_policies('INST_TYPE');


COMMENT ON TABLE BARS.INST_TYPE IS '';
COMMENT ON COLUMN BARS.INST_TYPE.CB IS '';
COMMENT ON COLUMN BARS.INST_TYPE.INST_TYPE IS 'The code for the type of insrument.';
COMMENT ON COLUMN BARS.INST_TYPE.NAME IS 'A description of the type of instrument.';




PROMPT *** Create  constraint SYS_C008956 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INST_TYPE MODIFY (CB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INST_TYPE MODIFY (INST_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_INSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INST_TYPE ADD CONSTRAINT XPK_INSTTYPE PRIMARY KEY (CB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_INSTTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_INSTTYPE ON BARS.INST_TYPE (CB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INST_TYPE ***
grant SELECT                                                                 on INST_TYPE       to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on INST_TYPE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INST_TYPE       to BARS_DM;
grant DELETE,INSERT,UPDATE                                                   on INST_TYPE       to INST_TYP;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INST_TYPE       to INST_TYPE;
grant SELECT                                                                 on INST_TYPE       to START1;
grant SELECT                                                                 on INST_TYPE       to UPLD;
grant FLASHBACK,SELECT                                                       on INST_TYPE       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INST_TYPE.sql =========*** End *** ===
PROMPT ===================================================================================== 
