---- прописываемся в полиси
exec bars.bars_policy_adm.alter_policy_info( 'W4_KD_TTS', 'WHOLE' , null, null, null, null ); 
exec bars.bars_policy_adm.alter_policy_info( 'W4_KD_TTS', 'FILIAL', null, null, null, null );
 
/
 
begin

execute immediate
q'{CREATE TABLE w4_kd_tts
(
    tt            CHAR (3 BYTE),
    description   VARCHAR2 (50 BYTE),
    CONSTRAINT fk_kd_tt FOREIGN KEY (tt) REFERENCES tts (tt),
    constraint uq_kd_tt unique (tt) 
)}';
exception when others then 
if SQLCODE = -00955 then null; end if; --[1]: ORA-00955: name is already used by an existing object

end;
 
 /
comment on table w4_kd_tts is 'Список кодов операция для погашения КД задолженности';
comment on column w4_kd_tts.tt is 'Код операции из tts.tt';
comment on column w4_kd_tts.description is 'Описание';
 /
 ---- права

GRANT SELECT,DELETE,INSERT, UPDATE, FLASHBACK  ON w4_sto_tts TO bars_dm ,obpc,bars_access_defrole ;
GRANT SELECT, FLASHBACK  ON w4_sto_tts TO wr_refread;
GRANT SELECT, INSERT,UPDATE  ON w4_sto_tts TO ow;
GRANT SELECT ON w4_sto_tts TO upld ,barsreader_role;

/
 