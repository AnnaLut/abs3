

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_PREPAY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_PREPAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_PREPAY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_PREPAY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CREDIT_PREPAY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_PREPAY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_PREPAY 
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




PROMPT *** ALTER_POLICIES to CIM_CREDIT_PREPAY ***
 exec bpa.alter_policies('CIM_CREDIT_PREPAY');


COMMENT ON TABLE BARS.CIM_CREDIT_PREPAY IS 'Можливість дострокового погашення';
COMMENT ON COLUMN BARS.CIM_CREDIT_PREPAY.ID IS 'ID дострокового погашення';
COMMENT ON COLUMN BARS.CIM_CREDIT_PREPAY.NAME IS 'Текстове значення';




PROMPT *** Create  constraint PK_CIMCREDITPREPAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_PREPAY ADD CONSTRAINT PK_CIMCREDITPREPAY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITPREPAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITPREPAY ON BARS.CIM_CREDIT_PREPAY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDIT_PREPAY ***
grant SELECT                                                                 on CIM_CREDIT_PREPAY to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_PREPAY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_PREPAY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_PREPAY to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDIT_PREPAY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_PREPAY.sql =========*** End
PROMPT ===================================================================================== 
