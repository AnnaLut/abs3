

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEMPLATES_BAK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TEMPLATES_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEMPLATES_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TEMPLATES_BAK 
   (	KV NUMBER(*,0), 
	TT CHAR(3), 
	PM NUMBER(*,0), 
	KODN_I NUMBER(*,0), 
	KODN_O NUMBER(*,0), 
	TIP_D CHAR(3), 
	WD CHAR(1), 
	TIP_K CHAR(3), 
	WK CHAR(1), 
	COMM VARCHAR2(70), 
	TTL CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TEMPLATES_BAK ***
 exec bpa.alter_policies('TEMPLATES_BAK');


COMMENT ON TABLE BARS.TEMPLATES_BAK IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.KV IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.TT IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.PM IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.KODN_I IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.KODN_O IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.TIP_D IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.WD IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.TIP_K IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.WK IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.COMM IS '';
COMMENT ON COLUMN BARS.TEMPLATES_BAK.TTL IS '';




PROMPT *** Create  constraint SYS_C009756 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES_BAK MODIFY (KODN_I NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009757 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES_BAK MODIFY (KODN_O NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TEMPLATES_BAK ***
grant SELECT                                                                 on TEMPLATES_BAK   to BARSREADER_ROLE;
grant SELECT                                                                 on TEMPLATES_BAK   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TEMPLATES_BAK   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TEMPLATES_BAK.sql =========*** End ***
PROMPT ===================================================================================== 
