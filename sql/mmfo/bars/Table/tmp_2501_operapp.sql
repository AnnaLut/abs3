

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2501_OPERAPP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2501_OPERAPP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2501_OPERAPP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2501_OPERAPP 
   (	CODEAPP VARCHAR2(30), 
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




PROMPT *** ALTER_POLICIES to TMP_2501_OPERAPP ***
 exec bpa.alter_policies('TMP_2501_OPERAPP');


COMMENT ON TABLE BARS.TMP_2501_OPERAPP IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.CODEAPP IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.CODEOPER IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.HOTKEY IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.REVERSE IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.REVOKED IS '';
COMMENT ON COLUMN BARS.TMP_2501_OPERAPP.GRANTOR IS '';




PROMPT *** Create  constraint SYS_C00109340 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_2501_OPERAPP MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109341 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_2501_OPERAPP MODIFY (CODEOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_2501_OPERAPP ***
grant SELECT                                                                 on TMP_2501_OPERAPP to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_2501_OPERAPP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2501_OPERAPP.sql =========*** End 
PROMPT ===================================================================================== 
