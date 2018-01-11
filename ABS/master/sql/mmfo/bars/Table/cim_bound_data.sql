

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_BOUND_DATA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_BOUND_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_BOUND_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_BOUND_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_BOUND_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_BOUND_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_BOUND_DATA 
   (	BOUND_ID NUMBER, 
	RNK NUMBER, 
	BENEF_ID NUMBER, 
	C_NUM VARCHAR2(60), 
	C_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_BOUND_DATA ***
 exec bpa.alter_policies('CIM_BOUND_DATA');


COMMENT ON TABLE BARS.CIM_BOUND_DATA IS 'Додаткові дані прив`язок';
COMMENT ON COLUMN BARS.CIM_BOUND_DATA.BOUND_ID IS 'Ідентифікатор привязки';
COMMENT ON COLUMN BARS.CIM_BOUND_DATA.RNK IS 'Внутрішній номер (rnk) контрагента';
COMMENT ON COLUMN BARS.CIM_BOUND_DATA.BENEF_ID IS 'Код клієнта-неризидента';
COMMENT ON COLUMN BARS.CIM_BOUND_DATA.C_NUM IS 'Номер контракту';
COMMENT ON COLUMN BARS.CIM_BOUND_DATA.C_DATE IS 'Дата контракту';




PROMPT *** Create  constraint CC_CIMBOUNDDATA_ID_UK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BOUND_DATA ADD CONSTRAINT CC_CIMBOUNDDATA_ID_UK UNIQUE (BOUND_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBOUNDDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BOUND_DATA MODIFY (BOUND_ID CONSTRAINT CC_CIMBOUNDDATA_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBOUNDDATA_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BOUND_DATA MODIFY (RNK CONSTRAINT CC_CIMBOUNDDATA_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBOUNDDATA_BENEFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BOUND_DATA MODIFY (BENEF_ID CONSTRAINT CC_CIMBOUNDDATA_BENEFID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_CIMBOUNDDATA_ID_UK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_CIMBOUNDDATA_ID_UK ON BARS.CIM_BOUND_DATA (BOUND_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_BOUND_DATA ***
grant SELECT                                                                 on CIM_BOUND_DATA  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BOUND_DATA  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_BOUND_DATA  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BOUND_DATA  to CIM_ROLE;
grant SELECT                                                                 on CIM_BOUND_DATA  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_BOUND_DATA.sql =========*** End **
PROMPT ===================================================================================== 
