

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_REPORT_ROW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_REPORT_ROW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_REPORT_ROW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_REPORT_ROW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_REPORT_ROW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_REPORT_ROW ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_REPORT_ROW 
   (	ROW_ID NUMBER(38,0), 
	SUBHEADER_ID NUMBER(38,0), 
	PARAMETER VARCHAR2(32), 
	VALUE VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_REPORT_ROW ***
 exec bpa.alter_policies('RNBU_REPORT_ROW');


COMMENT ON TABLE BARS.RNBU_REPORT_ROW IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_ROW.ROW_ID IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_ROW.SUBHEADER_ID IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_ROW.PARAMETER IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_ROW.VALUE IS '';




PROMPT *** Create  constraint SYS_C005907 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_REPORT_ROW MODIFY (SUBHEADER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005908 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_REPORT_ROW MODIFY (PARAMETER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005909 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_REPORT_ROW MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_REPORT_ROW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_REPORT_ROW to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_REPORT_ROW to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_REPORT_ROW.sql =========*** End *
PROMPT ===================================================================================== 
