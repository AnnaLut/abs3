

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CB_TIP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CB_TIP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CB_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CB_TIP 
   (	TIP CHAR(3), 
	CB NUMBER, 
	KOD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CB_TIP ***
 exec bpa.alter_policies('CB_TIP');


COMMENT ON TABLE BARS.CB_TIP IS '';
COMMENT ON COLUMN BARS.CB_TIP.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.CB_TIP.CB IS '';
COMMENT ON COLUMN BARS.CB_TIP.KOD IS '';




PROMPT *** Create  constraint XPK_CB_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CB_TIP ADD CONSTRAINT XPK_CB_TIP PRIMARY KEY (TIP, CB, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007031 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CB_TIP MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007032 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CB_TIP MODIFY (CB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007033 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CB_TIP MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CB_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CB_TIP ON BARS.CB_TIP (TIP, CB, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CB_TIP ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CB_TIP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CB_TIP          to BARS_DM;
grant SELECT                                                                 on CB_TIP          to CB;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CB_TIP          to CB_TIP;
grant FLASHBACK,SELECT                                                       on CB_TIP          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CB_TIP.sql =========*** End *** ======
PROMPT ===================================================================================== 
