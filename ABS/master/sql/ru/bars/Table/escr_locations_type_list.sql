

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_LOCATIONS_TYPE_LIST.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_LOCATIONS_TYPE_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_LOCATIONS_TYPE_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_LOCATIONS_TYPE_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_LOCATIONS_TYPE_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_LOCATIONS_TYPE_LIST 
   (	ID NUMBER, 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_LOCATIONS_TYPE_LIST ***
 exec bpa.alter_policies('ESCR_LOCATIONS_TYPE_LIST');


COMMENT ON TABLE BARS.ESCR_LOCATIONS_TYPE_LIST IS '';
COMMENT ON COLUMN BARS.ESCR_LOCATIONS_TYPE_LIST.ID IS '';
COMMENT ON COLUMN BARS.ESCR_LOCATIONS_TYPE_LIST.NAME IS '';



PROMPT *** Create  grants  ESCR_LOCATIONS_TYPE_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_LOCATIONS_TYPE_LIST to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_LOCATIONS_TYPE_LIST.sql =========
PROMPT ===================================================================================== 
