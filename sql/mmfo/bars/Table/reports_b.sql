

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORTS_B.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORTS_B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORTS_B'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_B'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_B'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORTS_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORTS_B 
   (	ID NUMBER, 
	DESCRIPTION VARCHAR2(210), 
	DATE_COUNT NUMBER, 
	MAIN_SQL VARCHAR2(1000), 
	AUX_SQL VARCHAR2(1000), 
	RPT_TEMPLATE LONG RAW, 
	LINK_FIELDS VARCHAR2(50), 
	PARAMS_DESC VARCHAR2(1000), 
	FORM_PROC VARCHAR2(150), 
	R_TYPE NUMBER, 
	PARAMS_DEFAULTS VARCHAR2(1000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORTS_B ***
 exec bpa.alter_policies('REPORTS_B');


COMMENT ON TABLE BARS.REPORTS_B IS '';
COMMENT ON COLUMN BARS.REPORTS_B.ID IS '';
COMMENT ON COLUMN BARS.REPORTS_B.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.REPORTS_B.DATE_COUNT IS '';
COMMENT ON COLUMN BARS.REPORTS_B.MAIN_SQL IS '';
COMMENT ON COLUMN BARS.REPORTS_B.AUX_SQL IS '';
COMMENT ON COLUMN BARS.REPORTS_B.RPT_TEMPLATE IS '';
COMMENT ON COLUMN BARS.REPORTS_B.LINK_FIELDS IS '';
COMMENT ON COLUMN BARS.REPORTS_B.PARAMS_DESC IS '';
COMMENT ON COLUMN BARS.REPORTS_B.FORM_PROC IS '';
COMMENT ON COLUMN BARS.REPORTS_B.R_TYPE IS '';
COMMENT ON COLUMN BARS.REPORTS_B.PARAMS_DEFAULTS IS '';



PROMPT *** Create  grants  REPORTS_B ***
grant SELECT                                                                 on REPORTS_B       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_B       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_B       to START1;
grant SELECT                                                                 on REPORTS_B       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORTS_B.sql =========*** End *** ===
PROMPT ===================================================================================== 
