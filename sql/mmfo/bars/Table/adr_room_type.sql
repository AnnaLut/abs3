

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/adr_room_type.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to adr_room_type ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''adr_room_type'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''adr_room_type'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''adr_room_type'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table adr_room_type ***
begin 
  execute immediate '
  CREATE TABLE BARS.adr_room_type 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(300 CHAR), 
	VALUE VARCHAR2(300 CHAR),
	name_eng varchar2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'alter table adr_room_type
add name_eng varchar2(50)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** ALTER_POLICIES to adr_room_type ***
 exec bpa.alter_policies('adr_room_type');


COMMENT ON TABLE BARS.adr_room_type IS 'Типы квартир';
COMMENT ON COLUMN BARS.adr_room_type.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.adr_room_type.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.adr_room_type.VALUE IS 'Значение';




PROMPT *** Create  constraint PK_CUSTADRROOMTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.adr_room_type ADD CONSTRAINT PK_CUSTADRROOMTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTADRROOMTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTADRROOMTYPE ON BARS.adr_room_type (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  adr_room_type ***
grant SELECT                                                                 on adr_room_type to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on adr_room_type to BARS_DM;
grant SELECT                                                                 on adr_room_type to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on adr_room_type to WR_ALL_RIGHTS;
grant SELECT                                                                 on adr_room_type to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/adr_room_type.sql =========*** End
PROMPT ===================================================================================== 
