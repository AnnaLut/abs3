

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_DJER.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_DJER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_DJER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_DJER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_DJER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_DJER ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_DJER 
   (	ID NUMBER, 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_DJER ***
 exec bpa.alter_policies('FM_DJER');


COMMENT ON TABLE BARS.FM_DJER IS 'Характеристика джерел надходження коштів';
COMMENT ON COLUMN BARS.FM_DJER.ID IS '';
COMMENT ON COLUMN BARS.FM_DJER.NAME IS '';




PROMPT *** Create  constraint PK_FM_DJER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_DJER ADD CONSTRAINT PK_FM_DJER_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FM_DJER_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FM_DJER_ID ON BARS.FM_DJER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_DJER ***
grant SELECT                                                                 on FM_DJER         to BARSREADER_ROLE;
grant SELECT                                                                 on FM_DJER         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_DJER         to BARS_DM;
grant SELECT                                                                 on FM_DJER         to CUST001;
grant SELECT                                                                 on FM_DJER         to FINMON01;
grant SELECT                                                                 on FM_DJER         to START1;
grant SELECT                                                                 on FM_DJER         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_DJER.sql =========*** End *** =====
PROMPT ===================================================================================== 
