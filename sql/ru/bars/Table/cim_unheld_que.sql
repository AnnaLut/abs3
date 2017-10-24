

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_UNHELD_QUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_UNHELD_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_UNHELD_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_UNHELD_QUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_UNHELD_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_UNHELD_QUE 
   (	BOUND_ID NUMBER, 
	REF NUMBER, 
	CONTR_ID NUMBER, 
	VDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_UNHELD_QUE ***
 exec bpa.alter_policies('CIM_UNHELD_QUE');


COMMENT ON TABLE BARS.CIM_UNHELD_QUE IS 'Черга непроведених платежів';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.BOUND_ID IS '';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.REF IS 'Id типу';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.CONTR_ID IS 'ID контракту';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.VDAT IS 'Планова дата валютування';




PROMPT *** Create  constraint FK_UNHELDQUE_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_UNHELD_QUE ADD CONSTRAINT FK_UNHELDQUE_REF FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UNHELDQUE_BOUNDID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_UNHELD_QUE ADD CONSTRAINT FK_UNHELDQUE_BOUNDID FOREIGN KEY (BOUND_ID)
	  REFERENCES BARS.CIM_PAYMENTS_BOUND (BOUND_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UNHELDQUE_CONTRID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_UNHELD_QUE ADD CONSTRAINT FK_UNHELDQUE_CONTRID FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_UNHELD_QUE ***
grant SELECT                                                                 on CIM_UNHELD_QUE  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_UNHELD_QUE  to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_UNHELD_QUE.sql =========*** End **
PROMPT ===================================================================================== 
