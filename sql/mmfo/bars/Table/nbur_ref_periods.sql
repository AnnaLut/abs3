

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_PERIODS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_PERIODS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_PERIODS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_PERIODS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_PERIODS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_PERIODS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_PERIODS 
   (	PERIOD_TYPE VARCHAR2(1), 
	DESCRIPTION VARCHAR2(70), 
	 CONSTRAINT PK_NBURREFPERIODS PRIMARY KEY (PERIOD_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_PERIODS ***
 exec bpa.alter_policies('NBUR_REF_PERIODS');


COMMENT ON TABLE BARS.NBUR_REF_PERIODS IS 'Довiдник перiодiв формування звiтностi';
COMMENT ON COLUMN BARS.NBUR_REF_PERIODS.PERIOD_TYPE IS 'Код перiоду';
COMMENT ON COLUMN BARS.NBUR_REF_PERIODS.DESCRIPTION IS 'Опис коду';




PROMPT *** Create  constraint PK_NBURREFPERIODS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_PERIODS ADD CONSTRAINT PK_NBURREFPERIODS PRIMARY KEY (PERIOD_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBURREFPERIODS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBURREFPERIODS ON BARS.NBUR_REF_PERIODS (PERIOD_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_PERIODS ***
grant SELECT                                                                 on NBUR_REF_PERIODS to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_REF_PERIODS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_PERIODS.sql =========*** End 
PROMPT ===================================================================================== 
