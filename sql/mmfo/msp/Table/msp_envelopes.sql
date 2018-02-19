PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_envelopes.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table msp_envelopes ***
begin
    execute immediate 'create table msp_envelopes
(
  id          number(38) not null,
  id_msp_env  number(38),
  code        varchar2(20),
  sender      varchar2(20),
  recipient   varchar2(20),
  partnumber  number(10),
  parttotal   number(10),
  ecp         clob,
  data        clob,
  data_decode clob,
  state       number(2),
  comm        varchar2(3000),
  create_date timestamp(6) default sysdate not null,
  filename    varchar2(50)
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
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table msp_envelopes
  is '��������';

PROMPT *** Create  index i_msp_envelope_state ***
begin
-- Create/Rebegin
    execute immediate '
    create index i_msp_envelope_state on msp_envelopes (state)
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  constraint pk_msp_envelopes ***
-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate '
    alter table msp_envelopes
    add constraint pk_msp_envelopes primary key (id)
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
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  constraint uk_msp_envelopes ***
begin
    execute immediate '
    alter table msp_envelopes
    add constraint uk_msp_envelopes unique (id_msp_env)
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
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  constraint fk_msp_envelopes ***
begin
    execute immediate 'alter table msp_envelopes
  add constraint FK_MSP_ENVELOPES foreign key (ID)
  references MSP_REQUESTS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  constraint fk_msp_envelope_state ***
begin
    execute immediate 'alter table MSP_ENVELOPES
  add constraint FK_MSP_ENVELOPE_STATE foreign key (STATE)
  references MSP_ENVELOPE_STATE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/

begin 
  execute immediate 'alter table msp_envelopes modify filename varchar2(256)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_envelopes.sql =========*** End
PROMPT ===================================================================================== 
