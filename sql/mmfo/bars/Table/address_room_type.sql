

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADDRESS_ROOM_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADDRESS_ROOM_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADDRESS_ROOM_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_ROOM_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_ROOM_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADDRESS_ROOM_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADDRESS_ROOM_TYPE 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(300 CHAR), 
	VALUE VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADDRESS_ROOM_TYPE ***
 exec bpa.alter_policies('ADDRESS_ROOM_TYPE');


COMMENT ON TABLE BARS.ADDRESS_ROOM_TYPE IS 'Типы квартир';
COMMENT ON COLUMN BARS.ADDRESS_ROOM_TYPE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.ADDRESS_ROOM_TYPE.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ADDRESS_ROOM_TYPE.VALUE IS 'Значение';




PROMPT *** Create  constraint PK_CUSTADRROOMTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADDRESS_ROOM_TYPE ADD CONSTRAINT PK_CUSTADRROOMTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTADRROOMTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTADRROOMTYPE ON BARS.ADDRESS_ROOM_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADDRESS_ROOM_TYPE ***
grant SELECT                                                                 on ADDRESS_ROOM_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADDRESS_ROOM_TYPE to BARS_DM;
grant SELECT                                                                 on ADDRESS_ROOM_TYPE to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ADDRESS_ROOM_TYPE to WR_ALL_RIGHTS;
grant SELECT                                                                 on ADDRESS_ROOM_TYPE to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADDRESS_ROOM_TYPE.sql =========*** End
PROMPT ===================================================================================== 
