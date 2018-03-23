

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/cim_credit_state_calc.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to cim_credit_state_calc ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cim_credit_state_calc'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''cim_credit_state_calc'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table cim_credit_state_calc ***
begin 
  execute immediate '
  CREATE TABLE BARS.cim_credit_state_calc 
   (	ID NUMBER, 
	NAME VARCHAR2(256), 
        OPEN_DATE DATE,
	DELETE_DATE DATE
   ) TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to cim_credit_state_calc ***
 exec bpa.alter_policies('cim_credit_state_calc');


COMMENT ON TABLE BARS.cim_credit_state_calc IS 'Код стану розрахунків за кредитом (kod_34_2)';


begin   
 execute immediate '
  ALTER TABLE BARS.cim_credit_state_calc ADD CONSTRAINT PK_CIMCREDITSTCLC PRIMARY KEY (ID, OPEN_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  grants  cim_credit_state_calc ***
grant DELETE,INSERT,SELECT,UPDATE                                            on cim_credit_state_calc to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on cim_credit_state_calc to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on cim_credit_state_calc to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/cim_credit_state_calc.sql =========*** 
PROMPT ===================================================================================== 
