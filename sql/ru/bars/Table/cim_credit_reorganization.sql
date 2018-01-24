

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_REORGANIZATION.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_REORGANIZATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_REORGANIZATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_REORGANIZATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_REORGANIZATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_REORGANIZATION 
   (	ID NUMBER, 
	NAME VARCHAR2(256), 
        OPEN_DATE DATE,
	DELETE_DATE DATE
   ) TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_REORGANIZATION ***
 exec bpa.alter_policies('CIM_CREDIT_REORGANIZATION');


COMMENT ON TABLE BARS.CIM_CREDIT_REORGANIZATION IS 'Код типу реорганізації (kod_6a_3)';


begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_REORGANIZATION ADD CONSTRAINT PK_CIMCREDITREORG PRIMARY KEY (ID, OPEN_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  grants  CIM_CREDIT_REORGANIZATION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_REORGANIZATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_REORGANIZATION to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_REORGANIZATION to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_REORGANIZATION.sql =========*** 
PROMPT ===================================================================================== 
