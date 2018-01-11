

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_REPORT_SUBHEADER.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_REPORT_SUBHEADER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_REPORT_SUBHEADER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_REPORT_SUBHEADER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_REPORT_SUBHEADER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_REPORT_SUBHEADER ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_REPORT_SUBHEADER 
   (	SUBHEADER_ID NUMBER(38,0), 
	HEADER_ID NUMBER(38,0), 
	ISRESIDENT NUMBER(1,0) DEFAULT 1, 
	NBUCODE NUMBER(10,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_REPORT_SUBHEADER ***
 exec bpa.alter_policies('RNBU_REPORT_SUBHEADER');


COMMENT ON TABLE BARS.RNBU_REPORT_SUBHEADER IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_SUBHEADER.SUBHEADER_ID IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_SUBHEADER.HEADER_ID IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_SUBHEADER.ISRESIDENT IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_SUBHEADER.NBUCODE IS '';




PROMPT *** Create  constraint SYS_C005738 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_REPORT_SUBHEADER MODIFY (HEADER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005739 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_REPORT_SUBHEADER MODIFY (ISRESIDENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005740 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_REPORT_SUBHEADER MODIFY (NBUCODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_REPORT_SUBHEADER ***
grant SELECT                                                                 on RNBU_REPORT_SUBHEADER to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_REPORT_SUBHEADER to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_REPORT_SUBHEADER to START1;
grant SELECT                                                                 on RNBU_REPORT_SUBHEADER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_REPORT_SUBHEADER.sql =========***
PROMPT ===================================================================================== 
