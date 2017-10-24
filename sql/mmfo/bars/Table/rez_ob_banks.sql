

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_OB_BANKS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_OB_BANKS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_OB_BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_OB_BANKS 
   (	FIN NUMBER(*,0), 
	OBS NUMBER(*,0), 
	VNCRR VARCHAR2(4), 
	KHIST NUMBER(*,0), 
	NEINF NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	K2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_OB_BANKS ***
 exec bpa.alter_policies('REZ_OB_BANKS');


COMMENT ON TABLE BARS.REZ_OB_BANKS IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.FIN IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.OBS IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.VNCRR IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.KHIST IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.NEINF IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.KAT23 IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.K23 IS '';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.K2 IS '';




PROMPT *** Create  constraint SYS_C007604 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_OB_BANKS MODIFY (FIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007605 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_OB_BANKS MODIFY (OBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007606 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_OB_BANKS MODIFY (VNCRR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007607 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_OB_BANKS MODIFY (KHIST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007608 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_OB_BANKS MODIFY (NEINF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_OB_BANKS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_OB_BANKS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_OB_BANKS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_OB_BANKS    to START1;
grant FLASHBACK,SELECT                                                       on REZ_OB_BANKS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_OB_BANKS.sql =========*** End *** 
PROMPT ===================================================================================== 
