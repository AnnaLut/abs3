

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FOREX_OB22_BACKUP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FOREX_OB22_BACKUP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FOREX_OB22_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FOREX_OB22_BACKUP 
   (	ID NUMBER(*,0), 
	KOD VARCHAR2(15), 
	S9A VARCHAR2(15), 
	S9P VARCHAR2(15), 
	S3D VARCHAR2(15), 
	S3K VARCHAR2(15), 
	S62 VARCHAR2(15), 
	S1T VARCHAR2(15), 
	S38 VARCHAR2(15), 
	P_SPOT NUMBER(*,0), 
	NAME VARCHAR2(20), 
	S9AV VARCHAR2(15), 
	S9PV VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FOREX_OB22_BACKUP ***
 exec bpa.alter_policies('TMP_FOREX_OB22_BACKUP');


COMMENT ON TABLE BARS.TMP_FOREX_OB22_BACKUP IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.ID IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.KOD IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S9A IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S9P IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S3D IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S3K IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S62 IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S1T IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S38 IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.P_SPOT IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.NAME IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S9AV IS '';
COMMENT ON COLUMN BARS.TMP_FOREX_OB22_BACKUP.S9PV IS '';



PROMPT *** Create  grants  TMP_FOREX_OB22_BACKUP ***
grant SELECT                                                                 on TMP_FOREX_OB22_BACKUP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FOREX_OB22_BACKUP.sql =========***
PROMPT ===================================================================================== 
