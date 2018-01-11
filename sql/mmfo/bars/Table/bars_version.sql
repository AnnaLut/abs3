

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARS_VERSION.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARS_VERSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BARS_VERSION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_VERSION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_VERSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARS_VERSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARS_VERSION 
   (	MODULE_NAME VARCHAR2(50), 
	SCCS_RELEASE NUMBER, 
	SCCS_LEVEL NUMBER, 
	SCCS_BRANCH NUMBER, 
	SCCS_SEQ NUMBER, 
	DELTA_DATE DATE, 
	TIMESTAMP DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARS_VERSION ***
 exec bpa.alter_policies('BARS_VERSION');


COMMENT ON TABLE BARS.BARS_VERSION IS '';
COMMENT ON COLUMN BARS.BARS_VERSION.MODULE_NAME IS '';
COMMENT ON COLUMN BARS.BARS_VERSION.SCCS_RELEASE IS '';
COMMENT ON COLUMN BARS.BARS_VERSION.SCCS_LEVEL IS '';
COMMENT ON COLUMN BARS.BARS_VERSION.SCCS_BRANCH IS '';
COMMENT ON COLUMN BARS.BARS_VERSION.SCCS_SEQ IS '';
COMMENT ON COLUMN BARS.BARS_VERSION.DELTA_DATE IS '';
COMMENT ON COLUMN BARS.BARS_VERSION.TIMESTAMP IS '';



PROMPT *** Create  grants  BARS_VERSION ***
grant SELECT                                                                 on BARS_VERSION    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_VERSION    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BARS_VERSION    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_VERSION    to START1;
grant SELECT                                                                 on BARS_VERSION    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARS_VERSION.sql =========*** End *** 
PROMPT ===================================================================================== 
