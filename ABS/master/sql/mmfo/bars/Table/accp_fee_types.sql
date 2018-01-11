

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCP_FEE_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCP_FEE_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCP_FEE_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCP_FEE_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCP_FEE_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCP_FEE_TYPES 
   (	FEE_TYPE_ID NUMBER(1,0), 
	FEE_TYPE_DESC VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCP_FEE_TYPES ***
 exec bpa.alter_policies('ACCP_FEE_TYPES');


COMMENT ON TABLE BARS.ACCP_FEE_TYPES IS 'Справочник типов комиссии';
COMMENT ON COLUMN BARS.ACCP_FEE_TYPES.FEE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.ACCP_FEE_TYPES.FEE_TYPE_DESC IS '';




PROMPT *** Create  constraint PK_ACCPFEETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_FEE_TYPES ADD CONSTRAINT PK_ACCPFEETYPES PRIMARY KEY (FEE_TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPFEETYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPFEETYPES ON BARS.ACCP_FEE_TYPES (FEE_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCP_FEE_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCP_FEE_TYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCP_FEE_TYPES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCP_FEE_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
