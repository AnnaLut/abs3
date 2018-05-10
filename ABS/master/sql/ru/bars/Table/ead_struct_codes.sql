

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_STRUCT_CODES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_STRUCT_CODES ***


execute bpa.alter_policy_info('EAD_STRUCT_CODES', 'FILIAL' , null, null, null, null);
execute bpa.alter_policy_info('EAD_STRUCT_CODES', 'WHOLE' , null, null, null, null);


-- 05.01.2018 перевод id number на varchar2 (part 1)
var ead_struct_codes_transform char
begin
  for i in (select * from user_tab_cols where table_name = 'EAD_STRUCT_CODES' and column_name = 'ID' and data_type = 'NUMBER') loop
    bars.bars_context.set_policy_group('WHOLE');
    execute immediate q'# create table bars.tmp_ead_struct_codes as select id, name, ' ' as FullTitle, 'N' as obsolete from bars.ead_struct_codes #';
    execute immediate 'drop table bars.ead_struct_codes cascade constraints';
    :ead_struct_codes_transform := 'Y';
  end loop;
end;
/


PROMPT *** Create  table EAD_STRUCT_CODES ***
begin 
  execute immediate '
create table EAD_STRUCT_CODES
(
  id        VARCHAR2(20) not null,
  name      VARCHAR2(300) not null,
  fulltitle VARCHAR2(300) not null,
  obsolete  CHAR(1) default ''N'' not null
)
tablespace BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


-- 05.01.2018 перевод id number на varchar2 (part 2)
begin
  if :ead_struct_codes_transform = 'Y' then
    execute immediate 'insert into ead_struct_codes select * from tmp_ead_struct_codes';
    execute immediate 'drop table tmp_ead_struct_codes';
  end if;
end;
/


PROMPT *** ALTER_POLICIES to EAD_STRUCT_CODES ***
exec bpa.alter_policies('EAD_STRUCT_CODES');


COMMENT ON TABLE BARS.EAD_STRUCT_CODES IS 'Довідник «Типи документів ЕА» для передачі у ЕА (OSHB-EA-INTEGRATION-SRS версія 2.54)';
COMMENT ON COLUMN BARS.EAD_STRUCT_CODES.ID IS 'Код структури документа';
COMMENT ON COLUMN BARS.EAD_STRUCT_CODES.NAME IS 'Назва типу документа';
COMMENT ON COLUMN BARS.EAD_STRUCT_CODES.FULLTITLE IS 'Повна назва типу документа';
COMMENT ON COLUMN BARS.EAD_STRUCT_CODES.OBSOLETE  is 'Признак "Вышедший из употребления код"';




PROMPT *** Create  constraint PK_EADSTRUCTCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_STRUCT_CODES ADD CONSTRAINT PK_EADSTRUCTCODES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  index PK_EADSTRUCTCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADSTRUCTCODES ON BARS.EAD_STRUCT_CODES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_STRUCT_CODES ***
grant SELECT                                                                 on EAD_STRUCT_CODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EAD_STRUCT_CODES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_STRUCT_CODES.sql =========*** End 
PROMPT ===================================================================================== 
