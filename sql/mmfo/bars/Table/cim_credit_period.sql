

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_PERIOD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_PERIOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_PERIOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_PERIOD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CREDIT_PERIOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_PERIOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_PERIOD 
   (	ID NUMBER, 
	NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_PERIOD ***
 exec bpa.alter_policies('CIM_CREDIT_PERIOD');


COMMENT ON TABLE BARS.CIM_CREDIT_PERIOD IS 'Періодичність погашення/нарахування_відсотків по кредиту';
COMMENT ON COLUMN BARS.CIM_CREDIT_PERIOD.ID IS 'ID періодичності';
COMMENT ON COLUMN BARS.CIM_CREDIT_PERIOD.NAME IS 'Назва періодичності';




PROMPT *** Create  constraint PK_CIMCREDITPERIOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_PERIOD ADD CONSTRAINT PK_CIMCREDITPERIOD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITPERIOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITPERIOD ON BARS.CIM_CREDIT_PERIOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDIT_PERIOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_PERIOD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_PERIOD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_PERIOD to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_PERIOD.sql =========*** End
PROMPT ===================================================================================== 
