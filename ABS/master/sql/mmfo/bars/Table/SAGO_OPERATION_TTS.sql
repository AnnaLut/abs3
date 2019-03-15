BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_OPERATION_TTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_OPERATION_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

-- Create table
begin
    execute immediate 'create table SAGO_OPERATION_TTS
(
  id_sago_oper VARCHAR2(10),
  tts          CHAR(3)
)
tablespace BRSSMLD
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
comment on table SAGO_OPERATION_TTS
  is 'Связь операций САГО и наших операций';
-- Add comments to the columns 
comment on column SAGO_OPERATION_TTS.id_sago_oper
  is 'Код операцій САГО';
comment on column SAGO_OPERATION_TTS.tts
  is 'Код наших операцій';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SAGO_OPERATION_TTS
  add constraint FK_SAGO_OPERATION foreign key (ID_SAGO_OPER)
  references SAGO_OPERATION (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table SAGO_OPERATION_TTS
  add constraint FK_SAGO_OPERATION_TTS foreign key (TTS)
  references TTS (TT)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

