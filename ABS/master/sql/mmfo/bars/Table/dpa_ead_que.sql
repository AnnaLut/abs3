PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/table/dpa_ead_que.sql =========*** Run
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'dpa_ead_que', 'WHOLE' , null, null, null, null ); 

exec bars.bpa.alter_policy_info( 'dpa_ead_que', 'FILIAL', null, null, null, null );

PROMPT *** Create  table dpa_ead_que ***
begin 
  execute immediate '
    create table dpa_ead_que
    (
      id         number(38) constraint cc_dpa_ead_que_id_nn not null,
      que_date   date,
      ead_doc_id number(38)
    )
    tablespace BRSBIGD
      pctfree 10
      initrans 1
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
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table dpa_ead_que is 'PDF Файли. Копія електронного файла-відповіді щодо взяття на облік/зняття з обліку рахунку платника податків в органі ДПС';

comment on column dpa_ead_que.id         is 'id запису';
comment on column dpa_ead_que.que_date   is 'Дата очікування формування та відправки файлу: (не пусто) - ознака, очікує формування та відправки PDF файлу в ЕА';
comment on column dpa_ead_que.ead_doc_id is 'ead_doc.id - id документа електронного архіву (не пусто - файл в ЕА відправлено)';

PROMPT *** Create  constraint pk_dpa_ead_que ***
begin   
  execute immediate '
    alter table dpa_ead_que
    add constraint pk_dpa_ead_que primary key (id)
    using index 
    tablespace BRSBIGI
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

PROMPT *** Create  index i_dpa_ead_que_que_date ***
begin
  execute immediate '
    create index i_dpa_ead_que_que_date on dpa_ead_que(que_date)
      tablespace BRSMDLI
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/

PROMPT *** Create  index i_dpa_ead_que_doc_id ***
begin
  execute immediate '
    create index i_dpa_ead_que_doc_id on dpa_ead_que(ead_doc_id)
      tablespace BRSMDLI
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table bars.dpa_ead_que add dpa_ead_nbs_id number(38)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

COMMENT ON COLUMN BARS.DPA_EAD_QUE.DPA_EAD_NBS_ID IS 'ID запису із довідника DPA_EAD_NBS';

PROMPT *** Create  index i_dpa_ead_que_ead_nbs_id ***
begin
  execute immediate '
    create index i_dpa_ead_que_ead_nbs_id on BARS.DPA_EAD_QUE(dpa_ead_nbs_id)
      tablespace BRSMDLI
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/

exec  bars.bpa.alter_policies('dpa_ead_que');

grant SELECT on bars.dpa_ead_que to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/table/dpa_ead_que.sql =========*** End
PROMPT ===================================================================================== 
