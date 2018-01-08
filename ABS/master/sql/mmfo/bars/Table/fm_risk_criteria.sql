

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_RISK_CRITERIA.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_RISK_CRITERIA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_RISK_CRITERIA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_RISK_CRITERIA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_RISK_CRITERIA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_RISK_CRITERIA ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_RISK_CRITERIA 
   (	ID NUMBER, 
	NAME VARCHAR2(1000), 
	INUSE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_RISK_CRITERIA ***
 exec bpa.alter_policies('FM_RISK_CRITERIA');


COMMENT ON TABLE BARS.FM_RISK_CRITERIA IS 'Критерії ризику';
COMMENT ON COLUMN BARS.FM_RISK_CRITERIA.ID IS 'Код';
COMMENT ON COLUMN BARS.FM_RISK_CRITERIA.NAME IS 'Найменування критерію';
COMMENT ON COLUMN BARS.FM_RISK_CRITERIA.INUSE IS 'Признак действующего критерия';




PROMPT *** Create  constraint CC_FMRISKCRITERIA_INUSE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_RISK_CRITERIA ADD CONSTRAINT CC_FMRISKCRITERIA_INUSE_NN CHECK (inuse is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_RIZIKCRITERIA ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_RISK_CRITERIA ADD CONSTRAINT PK_RIZIKCRITERIA PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMRISKCRITERIA_INUSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_RISK_CRITERIA ADD CONSTRAINT CC_FMRISKCRITERIA_INUSE CHECK (inuse in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RIZIKCRITERIA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RIZIKCRITERIA ON BARS.FM_RISK_CRITERIA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_RISK_CRITERIA ***
grant SELECT                                                                 on FM_RISK_CRITERIA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_RISK_CRITERIA to BARS_DM;
grant SELECT                                                                 on FM_RISK_CRITERIA to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_RISK_CRITERIA.sql =========*** End 
PROMPT ===================================================================================== 
