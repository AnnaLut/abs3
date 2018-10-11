PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/sdo_autopay_rules_desc.sql =========*** Run *** =====
PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''sdo_autopay_rules_desc'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''sdo_autopay_rules_desc'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''sdo_autopay_rules_desc'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table sdo_autopay_rules_desc ***
begin 
  execute immediate '
       CREATE TABLE sdo_autopay_rules_desc
        (rule_id         number,
 	     field_id        number,
         field_operator  varchar2(50),
		 rule_text       varchar2(500)   
       ) tablespace brssmld ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE  sdo_autopay_rules_desc                  IS 'Описнаие правил для авто отбора ';
COMMENT ON COLUMN sdo_autopay_rules_desc.rule_id          IS 'Код ';
COMMENT ON COLUMN sdo_autopay_rules_desc.field_id         IS 'Описание';
COMMENT ON COLUMN sdo_autopay_rules_desc.field_operator   IS 'Оператор >, >=, <, <=, like, in , not like';
COMMENT ON COLUMN sdo_autopay_rules_desc.rule_text        IS 'Текст правила';

begin   
 execute immediate 'alter table sdo_autopay_rules_desc modify (field_operator  varchar2(50))';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



begin   
 execute immediate '
  ALTER TABLE BARS.sdo_autopay_rules_desc ADD CONSTRAINT xpk_sdoautopayrulesdesc_id PRIMARY KEY (rule_id, field_id) USING INDEX TABLESPACE BRSsmld';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.sdo_autopay_rules_desc ADD CONSTRAINT FK_sdoautopayrulesdesc_ruleid FOREIGN KEY (rule_id) REFERENCES BARS.sdo_autopay_rules (rule_id)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate '
  ALTER TABLE BARS.sdo_autopay_rules_desc ADD CONSTRAINT FK_sdoautopayrulesdesc_fieldid FOREIGN KEY (field_id) REFERENCES BARS.sdo_autopay_rules_fields(field_id)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


grant SELECT                                                                 on sdo_autopay_rules_desc          to BARSaq;
grant SELECt, insert, update, delete                                       on sdo_autopay_rules_desc          to bars_access_defrole;
             



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TR_QT.sql =========*** End *** =====
PROMPT ===================================================================================== 
