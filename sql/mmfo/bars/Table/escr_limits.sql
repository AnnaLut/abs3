

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_LIMITS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_LIMITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_LIMITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_LIMITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_LIMITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_LIMITS 
   (	MFO VARCHAR2(6), 
	LIMIT NUMBER, 
	DATE_FROM DATE, 
	DATE_TO DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_LIMITS ***
 exec bpa.alter_policies('ESCR_LIMITS');


COMMENT ON TABLE BARS.ESCR_LIMITS IS 'Таблиця лімітів ';
COMMENT ON COLUMN BARS.ESCR_LIMITS.MFO IS '';
COMMENT ON COLUMN BARS.ESCR_LIMITS.LIMIT IS '';
COMMENT ON COLUMN BARS.ESCR_LIMITS.DATE_FROM IS '';
COMMENT ON COLUMN BARS.ESCR_LIMITS.DATE_TO IS '';



PROMPT *** Create  grants  ESCR_LIMITS ***
grant SELECT                                                                 on ESCR_LIMITS     to BARSREADER_ROLE;
grant SELECT                                                                 on ESCR_LIMITS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_LIMITS.sql =========*** End *** =
PROMPT ===================================================================================== 
