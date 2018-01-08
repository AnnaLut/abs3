

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_MAILNLS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_MAILNLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_MAILNLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_MAILNLS 
   (	ABON VARCHAR2(4), 
	NLS VARCHAR2(15), 
	KSS NUMBER(*,0), 
	GROUP_U NUMBER(*,0), 
	I_VA NUMBER(*,0), 
	OKPO VARCHAR2(14), 
	NAME VARCHAR2(70), 
	VISIBLE NUMBER(*,0), 
	FLAGS VARCHAR2(64), 
	ISP NUMBER(*,0), 
	DEPART VARCHAR2(30), 
	ISP_OWNER NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_MAILNLS ***
 exec bpa.alter_policies('MIGR_MAILNLS');


COMMENT ON TABLE BARS.MIGR_MAILNLS IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.ABON IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.NLS IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.KSS IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.GROUP_U IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.I_VA IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.OKPO IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.NAME IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.VISIBLE IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.FLAGS IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.ISP IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.DEPART IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS.ISP_OWNER IS '';



PROMPT *** Create  grants  MIGR_MAILNLS ***
grant SELECT                                                                 on MIGR_MAILNLS    to BARSREADER_ROLE;
grant SELECT                                                                 on MIGR_MAILNLS    to BARS_DM;
grant SELECT                                                                 on MIGR_MAILNLS    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_MAILNLS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_MAILNLS.sql =========*** End *** 
PROMPT ===================================================================================== 
