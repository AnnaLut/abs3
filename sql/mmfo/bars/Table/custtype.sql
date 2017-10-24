

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTTYPE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTTYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTTYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTTYPE 
   (	CUSTTYPE NUMBER(1,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTTYPE ***
 exec bpa.alter_policies('CUSTTYPE');


COMMENT ON TABLE BARS.CUSTTYPE IS 'Типы клиентов';
COMMENT ON COLUMN BARS.CUSTTYPE.CUSTTYPE IS 'Код типа клиента';
COMMENT ON COLUMN BARS.CUSTTYPE.NAME IS 'Тип контрагента';




PROMPT *** Create  constraint CC_CUSTTYPE_CUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTTYPE MODIFY (CUSTTYPE CONSTRAINT CC_CUSTTYPE_CUSTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTTYPE MODIFY (NAME CONSTRAINT CC_CUSTTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTTYPE ADD CONSTRAINT PK_CUSTTYPE PRIMARY KEY (CUSTTYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTTYPE ON BARS.CUSTTYPE (CUSTTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTTYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTTYPE        to ABS_ADMIN;
grant SELECT                                                                 on CUSTTYPE        to BARSAQ with grant option;
grant SELECT                                                                 on CUSTTYPE        to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CUSTTYPE        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTTYPE        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTTYPE        to BARS_DM;
grant SELECT                                                                 on CUSTTYPE        to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTTYPE        to CUSTTYPE;
grant SELECT                                                                 on CUSTTYPE        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTTYPE        to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTTYPE        to WR_CUSTLIST;
grant FLASHBACK,SELECT                                                       on CUSTTYPE        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTTYPE.sql =========*** End *** ====
PROMPT ===================================================================================== 
