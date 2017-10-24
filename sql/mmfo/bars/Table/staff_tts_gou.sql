

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TTS_GOU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TTS_GOU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TTS_GOU ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TTS_GOU 
   (	TT CHAR(3), 
	ID NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
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




PROMPT *** ALTER_POLICIES to STAFF_TTS_GOU ***
 exec bpa.alter_policies('STAFF_TTS_GOU');


COMMENT ON TABLE BARS.STAFF_TTS_GOU IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.TT IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.ID IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.APPROVE IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.ADATE1 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.ADATE2 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.RDATE1 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.RDATE2 IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.REVOKED IS '';
COMMENT ON COLUMN BARS.STAFF_TTS_GOU.GRANTOR IS '';



PROMPT *** Create  grants  STAFF_TTS_GOU ***
grant SELECT                                                                 on STAFF_TTS_GOU   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TTS_GOU.sql =========*** End ***
PROMPT ===================================================================================== 
