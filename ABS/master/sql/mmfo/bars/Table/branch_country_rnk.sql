

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_COUNTRY_RNK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_COUNTRY_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_COUNTRY_RNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_COUNTRY_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_COUNTRY_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_COUNTRY_RNK 
   (	BRANCH VARCHAR2(30), 
	COUNTRY NUMBER(3,0), 
	TAG VARCHAR2(16), 
	RNK NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_COUNTRY_RNK ***
 exec bpa.alter_policies('BRANCH_COUNTRY_RNK');


COMMENT ON TABLE BARS.BRANCH_COUNTRY_RNK IS 'РНК рахунків резерву';
COMMENT ON COLUMN BARS.BRANCH_COUNTRY_RNK.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.BRANCH_COUNTRY_RNK.COUNTRY IS 'Код країни';
COMMENT ON COLUMN BARS.BRANCH_COUNTRY_RNK.TAG IS 'Параметр РНК';
COMMENT ON COLUMN BARS.BRANCH_COUNTRY_RNK.RNK IS 'РНК';




PROMPT *** Create  constraint PK_BRANCH_COUNTRY_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_COUNTRY_RNK ADD CONSTRAINT PK_BRANCH_COUNTRY_RNK PRIMARY KEY (BRANCH, COUNTRY, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCH_COUNTRY_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCH_COUNTRY_RNK ON BARS.BRANCH_COUNTRY_RNK (BRANCH, COUNTRY, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_COUNTRY_RNK ***
grant SELECT                                                                 on BRANCH_COUNTRY_RNK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_COUNTRY_RNK to BARS_DM;
grant SELECT                                                                 on BRANCH_COUNTRY_RNK to RCC_DEAL;
grant SELECT                                                                 on BRANCH_COUNTRY_RNK to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_COUNTRY_RNK.sql =========*** En
PROMPT ===================================================================================== 
