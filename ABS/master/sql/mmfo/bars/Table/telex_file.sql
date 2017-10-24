

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELEX_FILE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELEX_FILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELEX_FILE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TELEX_FILE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TELEX_FILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELEX_FILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELEX_FILE 
   (	INS NUMBER(3,0), 
	ND NUMBER(38,0), 
	TELEX LONG RAW
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELEX_FILE ***
 exec bpa.alter_policies('TELEX_FILE');


COMMENT ON TABLE BARS.TELEX_FILE IS '';
COMMENT ON COLUMN BARS.TELEX_FILE.INS IS '';
COMMENT ON COLUMN BARS.TELEX_FILE.ND IS '';
COMMENT ON COLUMN BARS.TELEX_FILE.TELEX IS '';




PROMPT *** Create  constraint XPK_TELEXFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELEX_FILE ADD CONSTRAINT XPK_TELEXFILE PRIMARY KEY (INS, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TELEXFILE_INS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELEX_FILE MODIFY (INS CONSTRAINT CC_TELEXFILE_INS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TELEXFILE_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELEX_FILE MODIFY (ND CONSTRAINT CC_TELEXFILE_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TELEXFILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TELEXFILE ON BARS.TELEX_FILE (INS, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELEX_FILE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TELEX_FILE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TELEX_FILE      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TELEX_FILE      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELEX_FILE.sql =========*** End *** ==
PROMPT ===================================================================================== 
