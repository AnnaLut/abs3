

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIRST_NAMES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIRST_NAMES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIRST_NAMES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIRST_NAMES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIRST_NAMES ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIRST_NAMES 
   (	FIRSTID NUMBER(10,0), 
	FIRSTRU VARCHAR2(50), 
	FIRSTUA VARCHAR2(50), 
	SEXID CHAR(1), 
	MIDDLEUAM VARCHAR2(50), 
	MIDDLEUAF VARCHAR2(50), 
	MIDDLERUM VARCHAR2(50), 
	MIDDLERUF VARCHAR2(50), 
	FIRSTUAOF VARCHAR2(50), 
	FIRSTUAROD VARCHAR2(50), 
	FIRSTUADAT VARCHAR2(50), 
	FIRSTUAVIN VARCHAR2(50), 
	FIRSTUATVO VARCHAR2(50), 
	FIRSTUAPRE VARCHAR2(50), 
	FIRSTRUROD VARCHAR2(50), 
	FIRSTRUDAT VARCHAR2(50), 
	FIRSTRUVIN VARCHAR2(50), 
	FIRSTRUTVO VARCHAR2(50), 
	FIRSTRUPRE VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIRST_NAMES ***
 exec bpa.alter_policies('FIRST_NAMES');


COMMENT ON TABLE BARS.FIRST_NAMES IS 'Довідник імен';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTID IS 'ID';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTRU IS 'Ім'я (рос) ';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTUA IS 'Ім'я (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.SEXID IS 'Стать';
COMMENT ON COLUMN BARS.FIRST_NAMES.MIDDLEUAM IS 'По батькові чол. (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.MIDDLEUAF IS 'По батькові жін. (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.MIDDLERUM IS 'По батькові чол. (рос)';
COMMENT ON COLUMN BARS.FIRST_NAMES.MIDDLERUF IS 'По батькові жін. (рос)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTUAOF IS 'Звернення (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTUAROD IS 'Родовий відмінок (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTUADAT IS 'Давальний відмінок (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTUAVIN IS 'Знахідний відмінок (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTUATVO IS 'Орудний відмінок (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTUAPRE IS 'Місцевий відмінок (укр)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTRUROD IS 'Родовий відмінок (рос)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTRUDAT IS 'Давальний відмінок (рос)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTRUVIN IS 'Знахідний відмінок (рос)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTRUTVO IS 'Орудний відмінок (рос)';
COMMENT ON COLUMN BARS.FIRST_NAMES.FIRSTRUPRE IS 'Місцевий відмінок (рос)';




PROMPT *** Create  constraint SYS_C00137536 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIRST_NAMES MODIFY (FIRSTID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FIRSTNAMES ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIRST_NAMES ADD CONSTRAINT PK_FIRSTNAMES PRIMARY KEY (FIRSTID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FIRSTNAMES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FIRSTNAMES ON BARS.FIRST_NAMES (FIRSTID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIRST_NAMES ***
grant SELECT                                                                 on FIRST_NAMES     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIRST_NAMES.sql =========*** End *** =
PROMPT ===================================================================================== 
