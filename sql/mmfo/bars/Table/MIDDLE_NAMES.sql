

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIDDLE_NAMES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIDDLE_NAMES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MIDDLE_NAMES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MIDDLE_NAMES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIDDLE_NAMES ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIDDLE_NAMES 
   (	MIDDLEID NUMBER(10,0), 
	MIDDLEUA VARCHAR2(50), 
	MIDDLERU VARCHAR2(50), 
	SEXID CHAR(1), 
	FIRSTID NUMBER(10,0), 
	MIDDLEUAOF VARCHAR2(50), 
	MIDDLEUAROD VARCHAR2(50), 
	MIDDLEUADAT VARCHAR2(50), 
	MIDDLEUAVIN VARCHAR2(50), 
	MIDDLEUATVO VARCHAR2(50), 
	MIDDLEUAPRE VARCHAR2(50), 
	MIDDLERUROD VARCHAR2(50), 
	MIDDLERUDAT VARCHAR2(50), 
	MIDDLERUVIN VARCHAR2(50), 
	MIDDLERUTVO VARCHAR2(50), 
	MIDDLERUPRE VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIDDLE_NAMES ***
 exec bpa.alter_policies('MIDDLE_NAMES');


COMMENT ON TABLE BARS.MIDDLE_NAMES IS 'Довідник по-батькові';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEID IS 'ID';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEUA IS 'По батькові (укр)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLERU IS 'По батькові (рос)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.SEXID IS 'Стать';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.FIRSTID IS 'ссылка на FIRST_NAMES';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEUAOF IS 'Звернення (укр)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEUAROD IS 'Родовий відмінок (укр)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEUADAT IS 'Давальний відмінок (укр)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEUAVIN IS 'Знахідний відмінок (укр)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEUATVO IS 'Орудний відмінок (укр)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLEUAPRE IS 'Місцевий відмінок (укр)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLERUROD IS 'Родовий відмінок (рос)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLERUDAT IS 'Давальний відмінок (рос)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLERUVIN IS 'Знахідний відмінок (рос)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLERUTVO IS 'Орудний відмінок (рос)';
COMMENT ON COLUMN BARS.MIDDLE_NAMES.MIDDLERUPRE IS 'Місцевий відмінок (рос)';




PROMPT *** Create  constraint SYS_C00137533 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIDDLE_NAMES MODIFY (MIDDLEID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MIDDLENAMES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIDDLE_NAMES ADD CONSTRAINT PK_MIDDLENAMES PRIMARY KEY (MIDDLEID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MIDDLENAMES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MIDDLENAMES ON BARS.MIDDLE_NAMES (MIDDLEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MIDDLE_NAMES ***
grant SELECT                                                                 on MIDDLE_NAMES    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIDDLE_NAMES.sql =========*** End *** 
PROMPT ===================================================================================== 
