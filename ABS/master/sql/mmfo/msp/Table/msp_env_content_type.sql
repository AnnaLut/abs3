PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_env_content_type.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to msp_env_content_type ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table msp_env_content_type ***
begin 
  execute immediate '
    create table msp_env_content_type
    (
      id    number(2) constraint cc_msp_env_content_type_id_nn not null,
      name  varchar2(256)
    )
    tablespace BRSSMLD
      pctfree 10
      initrans 1
      maxtrans 255
      storage
      (
        initial 64K
        next 64K
        minextents 1
        maxextents unlimited
      )
    ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table msp_env_content_type is 'Типи вмісту сформованих даних по конверту';

PROMPT *** Create  constraint pk_msp_env_content_type ***
begin   
 execute immediate '
    alter table msp_env_content_type
    add constraint pk_msp_env_content_type primary key (id)
    using index 
    tablespace BRSSMLI
    pctfree 10
    initrans 2
    maxtrans 255
    storage
    (
      initial 64K
      next 64K
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

comment on table msp.msp_env_content_type is 'Типи вмісту сформованих даних по конверту';
comment on column msp.msp_env_content_type.id is 'id типу сформованих даних';
comment on column msp.msp_env_content_type.name is 'Назва типу сформованих даних';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_env_content_type.sql =========*** End
PROMPT ===================================================================================== 
