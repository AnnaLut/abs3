

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SW_MESSAGE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SW_MESSAGE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SW_MESSAGE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SW_MESSAGE 
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
	EDITVAL CHAR(1)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SW_MESSAGE ***
 exec bpa.alter_policies('TMP_SW_MESSAGE');


COMMENT ON TABLE BARS.TMP_SW_MESSAGE IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.NUM IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.SEQ IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.SUBSEQ IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.TAG IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.OPT IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.STATUS IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.EMPTY IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.SEQSTAT IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.VALUE IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.OPTMODEL IS '';
COMMENT ON COLUMN BARS.TMP_SW_MESSAGE.EDITVAL IS '';




PROMPT *** Create  constraint CC_TMPSWMSG_SEQSTAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE ADD CONSTRAINT CC_TMPSWMSG_SEQSTAT CHECK (seqstat in (''M'', ''O'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE ADD CONSTRAINT CC_TMPSWMSG_STATUS CHECK (status in (''M'', ''O'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMPSWMESSAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE ADD CONSTRAINT PK_TMPSWMESSAGE PRIMARY KEY (NUM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_SEQSTAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE MODIFY (SEQSTAT CONSTRAINT CC_TMPSWMSG_SEQSTAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_EMPTY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE MODIFY (EMPTY CONSTRAINT CC_TMPSWMSG_EMPTY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE MODIFY (STATUS CONSTRAINT CC_TMPSWMSG_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE MODIFY (TAG CONSTRAINT CC_TMPSWMSG_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_SEQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE MODIFY (SEQ CONSTRAINT CC_TMPSWMSG_SEQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE MODIFY (NUM CONSTRAINT CC_TMPSWMSG_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPSWMSG_EMPTY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_MESSAGE ADD CONSTRAINT CC_TMPSWMSG_EMPTY CHECK (empty in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPSWMESSAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPSWMESSAGE ON BARS.TMP_SW_MESSAGE (NUM) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SW_MESSAGE ***
grant DELETE,INSERT,SELECT                                                   on TMP_SW_MESSAGE  to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SW_MESSAGE  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_SW_MESSAGE ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_SW_MESSAGE FOR BARS.TMP_SW_MESSAGE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SW_MESSAGE.sql =========*** End **
PROMPT ===================================================================================== 
