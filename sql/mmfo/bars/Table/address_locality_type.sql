

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADDRESS_LOCALITY_TYPE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADDRESS_LOCALITY_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADDRESS_LOCALITY_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_LOCALITY_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_LOCALITY_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADDRESS_LOCALITY_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADDRESS_LOCALITY_TYPE 
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




PROMPT *** ALTER_POLICIES to ADDRESS_LOCALITY_TYPE ***
 exec bpa.alter_policies('ADDRESS_LOCALITY_TYPE');


COMMENT ON TABLE BARS.ADDRESS_LOCALITY_TYPE IS 'Довідник типів населених пунктів';
COMMENT ON COLUMN BARS.ADDRESS_LOCALITY_TYPE.ID IS 'Код';
COMMENT ON COLUMN BARS.ADDRESS_LOCALITY_TYPE.NAME IS 'Назва типу';
COMMENT ON COLUMN BARS.ADDRESS_LOCALITY_TYPE.VALUE IS 'Скорочена назва типу населеного пункту';




PROMPT *** Create  constraint PK_LOCALITYTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADDRESS_LOCALITY_TYPE ADD CONSTRAINT PK_LOCALITYTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LOCALITYTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LOCALITYTYPE ON BARS.ADDRESS_LOCALITY_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADDRESS_LOCALITY_TYPE ***
grant SELECT                                                                 on ADDRESS_LOCALITY_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ADDRESS_LOCALITY_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADDRESS_LOCALITY_TYPE to BARS_DM;
grant SELECT                                                                 on ADDRESS_LOCALITY_TYPE to START1;
grant SELECT                                                                 on ADDRESS_LOCALITY_TYPE to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ADDRESS_LOCALITY_TYPE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADDRESS_LOCALITY_TYPE.sql =========***
PROMPT ===================================================================================== 
