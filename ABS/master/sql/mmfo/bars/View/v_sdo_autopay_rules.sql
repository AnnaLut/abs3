create or replace view v_sdo_autopay_rules 
 as
 select r.rule_id, 
        r.rule_desc, 
        rf.FIELD_ID, 
        field_desc, 
        FIELD_DBNAME_COPR2, 
        FIELD_OPERATOR, 
        RULE_TEXT,
        FIELD_DBNAME_CL
   from sdo_autopay_rules r, sdo_autopay_rules_desc rd, sdo_autopay_rules_fields rf
  where r.rule_id = rd.rule_id
    and rd.field_id = rf.field_id
  order by rule_id, field_id;
  
comment on table  v_sdo_autopay_rules is 'Правила для отбора докумнетов для автооплаты';

comment on column  v_sdo_autopay_rules.rule_id              is 'Код правила';
comment on column  v_sdo_autopay_rules.rule_desc            is 'Описание правила';
comment on column  v_sdo_autopay_rules.FIELD_ID             is 'Код поля';
comment on column  v_sdo_autopay_rules.field_desc           is 'Описание поля';
comment on column  v_sdo_autopay_rules.FIELD_DBNAME_COPR2   is 'Наименование поля БД(корп2)';
comment on column  v_sdo_autopay_rules.FIELD_OPERATOR       is 'Оператор';
comment on column  v_sdo_autopay_rules.RULE_TEXT            is 'Текст правила';
comment on column  v_sdo_autopay_rules.FIELD_DBNAME_CL      is 'Наименование поля БД(корплайт)';


grant select on v_sdo_autopay_rules to bars_access_defrole;