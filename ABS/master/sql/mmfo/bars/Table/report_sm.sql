

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORT_SM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORT_SM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORT_SM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORT_SM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORT_SM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORT_SM ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORT_SM 
   (	MFO VARCHAR2(12), 
	NB VARCHAR2(38), 
	SUM_NUMBER NUMBER, 
	SUM_TEXT VARCHAR2(19), 
	CNT_NUMBER NUMBER, 
	CNT_TEXT VARCHAR2(16), 
	CNT_PASSPORT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORT_SM ***
 exec bpa.alter_policies('REPORT_SM');


COMMENT ON TABLE BARS.REPORT_SM IS '';
COMMENT ON COLUMN BARS.REPORT_SM.MFO IS '';
COMMENT ON COLUMN BARS.REPORT_SM.NB IS '';
COMMENT ON COLUMN BARS.REPORT_SM.SUM_NUMBER IS '';
COMMENT ON COLUMN BARS.REPORT_SM.SUM_TEXT IS '';
COMMENT ON COLUMN BARS.REPORT_SM.CNT_NUMBER IS '';
COMMENT ON COLUMN BARS.REPORT_SM.CNT_TEXT IS '';
COMMENT ON COLUMN BARS.REPORT_SM.CNT_PASSPORT IS '';




PROMPT *** Create  constraint SYS_C005844 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORT_SM MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPORT_SM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORT_SM       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORT_SM       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORT_SM.sql =========*** End *** ===
PROMPT ===================================================================================== 
