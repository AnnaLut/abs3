

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_PAYFLAG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_PAYFLAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_PAYFLAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_PAYFLAG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_PAYFLAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_PAYFLAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_PAYFLAG 
   (	ID NUMBER, 
	NAME VARCHAR2(16)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_PAYFLAG ***
 exec bpa.alter_policies('CIM_PAYFLAG');


COMMENT ON TABLE BARS.CIM_PAYFLAG IS 'Класифікатор платежів';
COMMENT ON COLUMN BARS.CIM_PAYFLAG.ID IS 'ID';
COMMENT ON COLUMN BARS.CIM_PAYFLAG.NAME IS 'Назва';




PROMPT *** Create  constraint PK_CIMPAYFLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYFLAG ADD CONSTRAINT PK_CIMPAYFLAG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMPAYFLAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMPAYFLAG ON BARS.CIM_PAYFLAG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_PAYFLAG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PAYFLAG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_PAYFLAG     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PAYFLAG     to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_PAYFLAG.sql =========*** End *** =
PROMPT ===================================================================================== 
