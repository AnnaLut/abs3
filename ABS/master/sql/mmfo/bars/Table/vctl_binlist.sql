

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VCTL_BINLIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VCTL_BINLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VCTL_BINLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VCTL_BINLIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VCTL_BINLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VCTL_BINLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.VCTL_BINLIST 
   (	RECID NUMBER, 
	OBJECT_NAME VARCHAR2(128), 
	OBJECT_SIZE NUMBER, 
	OBJECT_DATE DATE, 
	OBJECT_CRITICAL NUMBER(1,0), 
	PASSED NUMBER(1,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VCTL_BINLIST ***
 exec bpa.alter_policies('VCTL_BINLIST');


COMMENT ON TABLE BARS.VCTL_BINLIST IS '';
COMMENT ON COLUMN BARS.VCTL_BINLIST.RECID IS '';
COMMENT ON COLUMN BARS.VCTL_BINLIST.OBJECT_NAME IS '';
COMMENT ON COLUMN BARS.VCTL_BINLIST.OBJECT_SIZE IS '';
COMMENT ON COLUMN BARS.VCTL_BINLIST.OBJECT_DATE IS '';
COMMENT ON COLUMN BARS.VCTL_BINLIST.OBJECT_CRITICAL IS '';
COMMENT ON COLUMN BARS.VCTL_BINLIST.PASSED IS '';




PROMPT *** Create  constraint SYS_C005241 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VCTL_BINLIST MODIFY (RECID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VCTL_BINLIST MODIFY (OBJECT_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005243 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VCTL_BINLIST MODIFY (OBJECT_SIZE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005244 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VCTL_BINLIST MODIFY (OBJECT_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VCTL_BINLIST ***
grant SELECT                                                                 on VCTL_BINLIST    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VCTL_BINLIST    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VCTL_BINLIST    to START1;
grant SELECT                                                                 on VCTL_BINLIST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VCTL_BINLIST.sql =========*** End *** 
PROMPT ===================================================================================== 
