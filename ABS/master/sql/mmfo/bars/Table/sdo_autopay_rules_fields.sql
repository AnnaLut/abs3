PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/sdo_autopay_rules_fields.sql =========*** Run *** =====
PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''sdo_autopay_rules_fields'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''sdo_autopay_rules_fields'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''sdo_autopay_rules_fields'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table sdo_autopay_rules_fields ***
begin 
  execute immediate '
       CREATE TABLE sdo_autopay_rules_fields
                ( field_id           number,
				  field_dbname_copr2 varchar2(100),
				  field_dbname_cl    varchar2(100),
                  field_desc         varchar2(500)
               ) tablespace brssmld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS.sdo_autopay_rules_fields                 IS 'Справочник полей для построения правила';
COMMENT ON COLUMN sdo_autopay_rules_fields.field_id            IS  'Код ';
COMMENT ON COLUMN sdo_autopay_rules_fields.field_dbname_copr2  IS  'поля таблицы для корп2';
COMMENT ON COLUMN sdo_autopay_rules_fields.field_dbname_cl     IS  'Поля таблицы для корплайт';
COMMENT ON COLUMN sdo_autopay_rules_fields.field_desc           IS  'Описание для пользователя';


begin   
 execute immediate '
  ALTER TABLE BARS.sdo_autopay_rules_fields ADD CONSTRAINT xpk_sdoautorulesfields_fieldid PRIMARY KEY (field_id) USING INDEX TABLESPACE BRSsmld';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


grant SELECT                                                                 on sdo_autopay_rules_fields          to BARSaq;
grant SELECt, insert, update, delete                                       on sdo_autopay_rules_fields          to bars_access_defrole;
             



