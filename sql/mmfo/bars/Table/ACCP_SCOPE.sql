

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCP_SCOPE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCP_SCOPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCP_SCOPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCP_SCOPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCP_SCOPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCP_SCOPE 
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




PROMPT *** ALTER_POLICIES to ACCP_SCOPE ***
 exec bpa.alter_policies('ACCP_SCOPE');


COMMENT ON TABLE BARS.ACCP_SCOPE IS 'Область дії договору';
COMMENT ON COLUMN BARS.ACCP_SCOPE.ID IS 'ID';
COMMENT ON COLUMN BARS.ACCP_SCOPE.TEXT IS 'Опис';




PROMPT *** Create  constraint CC_ACCP_SCOPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_SCOPE MODIFY (TEXT CONSTRAINT CC_ACCP_SCOPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCPSCOPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_SCOPE ADD CONSTRAINT PK_ACCPSCOPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPSCOPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPSCOPE ON BARS.ACCP_SCOPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCP_SCOPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCP_SCOPE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCP_SCOPE      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCP_SCOPE.sql =========*** End *** ==
PROMPT ===================================================================================== 
