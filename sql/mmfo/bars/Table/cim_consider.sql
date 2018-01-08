

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONSIDER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONSIDER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONSIDER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONSIDER'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CONSIDER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONSIDER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONSIDER 
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




PROMPT *** ALTER_POLICIES to CIM_CONSIDER ***
 exec bpa.alter_policies('CIM_CONSIDER');


COMMENT ON TABLE BARS.CIM_CONSIDER IS 'Враховувати/Не враховувати';
COMMENT ON COLUMN BARS.CIM_CONSIDER.ID IS 'ID';
COMMENT ON COLUMN BARS.CIM_CONSIDER.NAME IS 'Назва';




PROMPT *** Create  constraint PK_CIMCONSIDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONSIDER ADD CONSTRAINT PK_CIMCONSIDER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONSIDER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONSIDER ON BARS.CIM_CONSIDER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONSIDER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONSIDER    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONSIDER    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONSIDER    to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONSIDER.sql =========*** End *** 
PROMPT ===================================================================================== 
