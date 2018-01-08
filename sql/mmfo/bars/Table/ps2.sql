

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS2.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PS2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PS2'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PS2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS2 
   (	NBS CHAR(4), 
	XAR NUMBER(2,0), 
	PAP NUMBER(1,0), 
	NAME VARCHAR2(175), 
	CLASS NUMBER(2,0), 
	CHKNBS NUMBER(1,0), 
	AUTO_STOP NUMBER(1,0), 
	D_CLOSE DATE, 
	SB CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS2 ***
 exec bpa.alter_policies('PS2');


COMMENT ON TABLE BARS.PS2 IS '';
COMMENT ON COLUMN BARS.PS2.NBS IS '';
COMMENT ON COLUMN BARS.PS2.XAR IS '';
COMMENT ON COLUMN BARS.PS2.PAP IS '';
COMMENT ON COLUMN BARS.PS2.NAME IS '';
COMMENT ON COLUMN BARS.PS2.CLASS IS '';
COMMENT ON COLUMN BARS.PS2.CHKNBS IS '';
COMMENT ON COLUMN BARS.PS2.AUTO_STOP IS '';
COMMENT ON COLUMN BARS.PS2.D_CLOSE IS '';
COMMENT ON COLUMN BARS.PS2.SB IS '';




PROMPT *** Create  constraint SYS_C005955 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS2 MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005956 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS2 MODIFY (PAP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS2 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005958 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS2 MODIFY (CLASS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS2 ***
grant SELECT                                                                 on PS2             to BARSREADER_ROLE;
grant SELECT                                                                 on PS2             to BARS_DM;
grant SELECT                                                                 on PS2             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS2             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS2.sql =========*** End *** =========
PROMPT ===================================================================================== 
