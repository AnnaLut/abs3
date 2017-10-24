

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_39.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TRACE_39 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TRACE_39'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OTCN_TRACE_39'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_TRACE_39'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_TRACE_39 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_TRACE_39 
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




PROMPT *** ALTER_POLICIES to OTCN_TRACE_39 ***
 exec bpa.alter_policies('OTCN_TRACE_39');


COMMENT ON TABLE BARS.OTCN_TRACE_39 IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.KF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.KV IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.ODATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.NBUC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.REF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.COMM IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.ND IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.MDATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_39.TOBO IS '';




PROMPT *** Create  constraint FK_OTCNTRACE39_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TRACE_39 ADD CONSTRAINT FK_OTCNTRACE39_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNTRACE39_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TRACE_39 MODIFY (KF CONSTRAINT CC_OTCNTRACE39_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_TRACE_39 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_39   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_TRACE_39   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_39   to RPBN002;



PROMPT *** Create SYNONYM  to OTCN_TRACE_39 ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_TRACE_39 FOR BARS.OTCN_TRACE_39;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_39.sql =========*** End ***
PROMPT ===================================================================================== 
