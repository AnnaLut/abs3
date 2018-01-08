

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2501_REP_APP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2501_REP_APP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2501_REP_APP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2501_REP_APP 
   (	CODEAPP VARCHAR2(30 CHAR), 
	CODEREP NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0), 
	ACODE VARCHAR2(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_2501_REP_APP ***
 exec bpa.alter_policies('TMP_2501_REP_APP');


COMMENT ON TABLE BARS.TMP_2501_REP_APP IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.CODEAPP IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.CODEREP IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.REVERSE IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.REVOKED IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.GRANTOR IS '';
COMMENT ON COLUMN BARS.TMP_2501_REP_APP.ACODE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2501_REP_APP.sql =========*** End 
PROMPT ===================================================================================== 
