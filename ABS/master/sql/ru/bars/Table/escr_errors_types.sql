

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_ERRORS_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_ERRORS_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_ERRORS_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_ERRORS_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_ERRORS_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_ERRORS_TYPES 
   (	ID NUMBER, 
	DESCRIPTION VARCHAR2(400)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_ERRORS_TYPES ***
 exec bpa.alter_policies('ESCR_ERRORS_TYPES');


COMMENT ON TABLE BARS.ESCR_ERRORS_TYPES IS 'Коди та опис валідацій для модуля';
COMMENT ON COLUMN BARS.ESCR_ERRORS_TYPES.ID IS '';
COMMENT ON COLUMN BARS.ESCR_ERRORS_TYPES.DESCRIPTION IS '';



PROMPT *** Create  grants  ESCR_ERRORS_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_ERRORS_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_ERRORS_TYPES.sql =========*** End
PROMPT ===================================================================================== 
