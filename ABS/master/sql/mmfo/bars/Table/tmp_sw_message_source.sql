

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SW_MESSAGE_SOURCE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SW_MESSAGE_SOURCE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SW_MESSAGE_SOURCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SW_MESSAGE_SOURCE 
   (	NUM NUMBER(3,0), 
	SEQ CHAR(1), 
	SUBSEQ CHAR(2), 
	TAG CHAR(2), 
	OPT CHAR(1), 
	STATUS CHAR(1), 
	EMPTY CHAR(1), 
	SEQSTAT CHAR(1), 
	VALUE VARCHAR2(1024), 
	OPTMODEL CHAR(1), 
	EDITVAL CHAR(1), 
	SWREF NUMBER, 
	USERID NUMBER DEFAULT sys_context(''bars_global'',''user_id'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SW_MESSAGE_SOURCE ***
 exec bpa.alter_policies('TMP_SW_MESSAGE_SOURCE');


COMMENT ON TABLE BARS.TMP_SW_MESSAGE_SOURCE IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.NUM IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.SEQ IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.SUBSEQ IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.TAG IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.OPT IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.STATUS IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.EMPTY IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.SEQSTAT IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.VALUE IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.OPTMODEL IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.EDITVAL IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.SWREF IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE_SOURCE.USERID IS '';




PROMPT *** Create  constraint PK_TMPSWMESSAGESRC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE_SOURCE ADD CONSTRAINT PK_TMPSWMESSAGESRC PRIMARY KEY (NUM, SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPSWMESSAGESRC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPSWMESSAGESRC ON BARS.TMP_SW_MESSAGE_SOURCE (NUM, SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SW_MESSAGE_SOURCE ***
grant SELECT                                                                 on TMP_SW_MESSAGE_SOURCE to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SW_MESSAGE_SOURCE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SW_MESSAGE_SOURCE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SW_MESSAGE_SOURCE to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_SW_MESSAGE_SOURCE ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_SW_MESSAGE_SOURCE FOR BARS.TMP_SW_MESSAGE_SOURCE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SW_MESSAGE_SOURCE.sql =========***
PROMPT ===================================================================================== 
