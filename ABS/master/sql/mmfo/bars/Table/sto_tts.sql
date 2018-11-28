prompt TABLE STO_TTS
begin
    bpa.alter_policy_info('STO_TTS', 'FILIAL', null, 'E', 'E', 'E');
    bpa.alter_policy_info('STO_TTS', 'WHOLE', null, null, null, null);
end;
/
begin
    execute immediate '
create table bars.sto_tts
(
tt char(3),
name varchar2(70),
constraint XPK_STO_TTS primary key (tt), 
constraint FK_STO_TTS_TTS foreign key (tt) references bars.tts (tt)
)
organization index
tablespace brssmli
    ';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/  
comment on table sto_tts is 'Операции, доступные для регулярных платежей';
comment on column sto_tts.tt is 'Код операции';
comment on column sto_tts.name is 'Название операции (должно соответствовать tts)';