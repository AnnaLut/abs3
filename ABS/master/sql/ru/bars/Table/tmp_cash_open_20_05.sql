

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CASH_OPEN_20_05.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CASH_OPEN_20_05 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CASH_OPEN_20_05 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CASH_OPEN_20_05 
   (	BRANCH VARCHAR2(30), 
	OPDATE DATE, 
	SHIFT NUMBER(*,0), 
	USERID NUMBER, 
	LASTREF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CASH_OPEN_20_05 ***
 exec bpa.alter_policies('TMP_CASH_OPEN_20_05');


COMMENT ON TABLE BARS.TMP_CASH_OPEN_20_05 IS '';
COMMENT ON COLUMN BARS.TMP_CASH_OPEN_20_05.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CASH_OPEN_20_05.OPDATE IS '';
COMMENT ON COLUMN BARS.TMP_CASH_OPEN_20_05.SHIFT IS '';
COMMENT ON COLUMN BARS.TMP_CASH_OPEN_20_05.USERID IS '';
COMMENT ON COLUMN BARS.TMP_CASH_OPEN_20_05.LASTREF IS '';




PROMPT *** Create  constraint SYS_C0043785 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CASH_OPEN_20_05 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CASH_OPEN_20_05 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_CASH_OPEN_20_05 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CASH_OPEN_20_05.sql =========*** E
PROMPT ===================================================================================== 
