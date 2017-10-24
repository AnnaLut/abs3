

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_COMPENSATION_TYPE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_COMPENSATION_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_COMPENSATION_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_COMPENSATION_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_COMPENSATION_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_COMPENSATION_TYPE 
   (	ID NUMBER, 
	NAME VARCHAR2(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_COMPENSATION_TYPE ***
 exec bpa.alter_policies('ESCR_COMPENSATION_TYPE');


COMMENT ON TABLE BARS.ESCR_COMPENSATION_TYPE IS 'Тип компенсації для регіональної програми (енергозбереження)';
COMMENT ON COLUMN BARS.ESCR_COMPENSATION_TYPE.ID IS '';
COMMENT ON COLUMN BARS.ESCR_COMPENSATION_TYPE.NAME IS '';



PROMPT *** Create  grants  ESCR_COMPENSATION_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_COMPENSATION_TYPE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_COMPENSATION_TYPE.sql =========**
PROMPT ===================================================================================== 
