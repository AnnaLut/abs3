
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/sdo_autopay_rules.sql =========*** Run *** =====
PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''sdo_autopay_rules'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''sdo_autopay_rules'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''sdo_autopay_rules'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table sdo_autopay_rules ***

begin 
  execute immediate '
       CREATE TABLE sdo_autopay_rules
        (rule_id      number,
         rule_desc    varchar2(500),
         is_active    smallint
        ) TABLESPACE brssmld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS.sdo_autopay_rules IS '���������� ������ ��� ���������� ���������� ���';
COMMENT ON COLUMN sdo_autopay_rules.rule_id  IS  '��� ';
COMMENT ON COLUMN sdo_autopay_rules.rule_desc  IS  '��������';
COMMENT ON COLUMN sdo_autopay_rules.is_active   IS  '����������';


begin   
 execute immediate '
  ALTER TABLE BARS.sdo_autopay_rules ADD CONSTRAINT xpk_sdoautopayrules_ruleid PRIMARY KEY (rule_id) USING INDEX TABLESPACE BRSsmld';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





grant SELECT                                                                 on sdo_autopay_rules          to BARSaq;
grant SELECt, insert, update, delete                                       on sdo_autopay_rules          to bars_access_defrole;
             



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TR_QT.sql =========*** End *** =====
PROMPT ===================================================================================== 
