

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_3A.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TRACE_3A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TRACE_3A'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OTCN_TRACE_3A'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_TRACE_3A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_TRACE_3A ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_TRACE_3A 
   (	DATF DATE, 
	USERID NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(30), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	MDATE DATE, 
	TOBO VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_TRACE_3A ***
 exec bpa.alter_policies('OTCN_TRACE_3A');


COMMENT ON TABLE BARS.OTCN_TRACE_3A IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.KF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.KV IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.ODATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.NBUC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.REF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.COMM IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.ND IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.MDATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_3A.TOBO IS '';




PROMPT *** Create  constraint FK_OTCNTRACE3A_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TRACE_3A ADD CONSTRAINT FK_OTCNTRACE3A_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNTRACE3A_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TRACE_3A MODIFY (KF CONSTRAINT CC_OTCNTRACE3A_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_TRACE_3A ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_3A   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_TRACE_3A   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_3A   to RPBN002;



PROMPT *** Create SYNONYM  to OTCN_TRACE_3A ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_TRACE_3A FOR BARS.OTCN_TRACE_3A;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_3A.sql =========*** End ***
PROMPT ===================================================================================== 
