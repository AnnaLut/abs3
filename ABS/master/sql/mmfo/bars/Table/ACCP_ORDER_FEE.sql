

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCP_ORDER_FEE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCP_ORDER_FEE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCP_ORDER_FEE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCP_ORDER_FEE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCP_ORDER_FEE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCP_ORDER_FEE 
   (	ID NUMBER(2,0), 
	TEXT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCP_ORDER_FEE ***
 exec bpa.alter_policies('ACCP_ORDER_FEE');


COMMENT ON TABLE BARS.ACCP_ORDER_FEE IS 'Порядок зняття комісійної винагороди';
COMMENT ON COLUMN BARS.ACCP_ORDER_FEE.ID IS 'ID';
COMMENT ON COLUMN BARS.ACCP_ORDER_FEE.TEXT IS 'Опис';




PROMPT *** Create  constraint CC_ACCP_ORDERFEE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORDER_FEE MODIFY (TEXT CONSTRAINT CC_ACCP_ORDERFEE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCPORDERFEE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORDER_FEE ADD CONSTRAINT PK_ACCPORDERFEE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPORDERFEE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPORDERFEE ON BARS.ACCP_ORDER_FEE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCP_ORDER_FEE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCP_ORDER_FEE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCP_ORDER_FEE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCP_ORDER_FEE.sql =========*** End **
PROMPT ===================================================================================== 
