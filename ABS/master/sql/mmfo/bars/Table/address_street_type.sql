

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADDRESS_STREET_TYPE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADDRESS_STREET_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADDRESS_STREET_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_STREET_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_STREET_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADDRESS_STREET_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADDRESS_STREET_TYPE 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(50), 
	VALUE VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADDRESS_STREET_TYPE ***
 exec bpa.alter_policies('ADDRESS_STREET_TYPE');


COMMENT ON TABLE BARS.ADDRESS_STREET_TYPE IS 'Довідник типів вулиць';
COMMENT ON COLUMN BARS.ADDRESS_STREET_TYPE.ID IS 'Код типу вулиці';
COMMENT ON COLUMN BARS.ADDRESS_STREET_TYPE.NAME IS 'Назва типу вулиці';
COMMENT ON COLUMN BARS.ADDRESS_STREET_TYPE.VALUE IS 'Скорочена назва типу вулиці';




PROMPT *** Create  constraint PK_STREETTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADDRESS_STREET_TYPE ADD CONSTRAINT PK_STREETTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STREETTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STREETTYPE ON BARS.ADDRESS_STREET_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADDRESS_STREET_TYPE ***
grant SELECT                                                                 on ADDRESS_STREET_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADDRESS_STREET_TYPE to BARS_DM;
grant SELECT                                                                 on ADDRESS_STREET_TYPE to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on ADDRESS_STREET_TYPE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADDRESS_STREET_TYPE.sql =========*** E
PROMPT ===================================================================================== 
