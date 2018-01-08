

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHKLIST_GOU.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHKLIST_GOU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHKLIST_GOU ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHKLIST_GOU 
   (	IDCHK NUMBER(*,0), 
	NAME VARCHAR2(35), 
	COMM VARCHAR2(35), 
	F_IN_CHARGE NUMBER(*,0), 
	IDCHK_HEX VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CHKLIST_GOU ***
 exec bpa.alter_policies('CHKLIST_GOU');


COMMENT ON TABLE BARS.CHKLIST_GOU IS '';
COMMENT ON COLUMN BARS.CHKLIST_GOU.IDCHK IS '';
COMMENT ON COLUMN BARS.CHKLIST_GOU.NAME IS '';
COMMENT ON COLUMN BARS.CHKLIST_GOU.COMM IS '';
COMMENT ON COLUMN BARS.CHKLIST_GOU.F_IN_CHARGE IS '';
COMMENT ON COLUMN BARS.CHKLIST_GOU.IDCHK_HEX IS '';




PROMPT *** Create  constraint SYS_C007591 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_GOU MODIFY (F_IN_CHARGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007592 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_GOU MODIFY (IDCHK_HEX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007590 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_GOU MODIFY (IDCHK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHKLIST_GOU ***
grant SELECT                                                                 on CHKLIST_GOU     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHKLIST_GOU.sql =========*** End *** =
PROMPT ===================================================================================== 
