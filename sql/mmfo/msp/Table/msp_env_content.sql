PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_env_content.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to msp_env_content ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table msp_env_content ***
begin 
  execute immediate '
    create table msp_env_content
    (
      id                number(38) constraint cc_msp_env_content_id_nn not null,
      type_id           number(2)  constraint cc_msp_env_content_typeid_nn not null,
      bvalue            blob,
      filename          varchar2(50),
      insert_dttm       date default sysdate,
      ecp               clob
    )
    tablespace BRSDYND
      pctfree 10
      initrans 1
      maxtrans 255
      storage
      (
        initial 128K
        next 128K
        minextents 1
        maxextents unlimited
      )
  ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Create comment on table msp_env_content ***
comment on table msp_env_content is 'Сформовані дані по конверту';
comment on column msp_env_content.type_id is 'Тип вмісту сформованих даних по конверту';
comment on column msp_env_content.insert_dttm is 'Дата формування';
comment on column msp_env_content.ecp is 'ECP';

PROMPT *** Create  constraint uk_msp_env_content ***
begin   
  execute immediate '
    alter table msp_env_content
    add constraint uk_msp_env_content unique (id, type_id)
    using index 
    tablespace BRSDYNI
    pctfree 10
    initrans 2
    maxtrans 255
    storage
    (
      initial 64K
      next 1M
      minextents 1
      maxextents unlimited
    )
  ';
exception when others then
  if sqlcode = -2261 or sqlcode = -2260 then 
    null; 
  else 
    raise; 
  end if; 
end;
/

PROMPT *** Create  constraint fk_msp_env_content_type_id ***
begin   
  execute immediate '
    alter table msp_env_content
      add constraint fk_msp_env_content_type_id foreign key (type_id)
      references msp_env_content_type (id)
  ';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT *** Create  constraint fk_msp_env_content_id ***
begin   
  execute immediate '
    alter table msp_env_content
      add constraint fk_msp_env_content_id foreign key (id)
      references msp_envelopes (id)
  ';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_env_content.sql =========*** End
PROMPT ===================================================================================== 
