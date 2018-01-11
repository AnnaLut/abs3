

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERAPP_BAK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERAPP_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERAPP_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERAPP_BAK 
   (	CODEAPP VARCHAR2(30 CHAR), 
	CODEOPER NUMBER(38,0), 
	HOTKEY VARCHAR2(1), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERAPP_BAK ***
 exec bpa.alter_policies('OPERAPP_BAK');


COMMENT ON TABLE BARS.OPERAPP_BAK IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.CODEAPP IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.CODEOPER IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.HOTKEY IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.APPROVE IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.ADATE1 IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.ADATE2 IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.RDATE1 IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.RDATE2 IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.REVERSE IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.REVOKED IS '';
COMMENT ON COLUMN BARS.OPERAPP_BAK.GRANTOR IS '';




PROMPT *** Create  constraint SYS_C0025764 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP_BAK MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025765 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP_BAK MODIFY (CODEOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERAPP_BAK ***
grant SELECT                                                                 on OPERAPP_BAK     to BARSREADER_ROLE;
grant SELECT                                                                 on OPERAPP_BAK     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERAPP_BAK.sql =========*** End *** =
PROMPT ===================================================================================== 
