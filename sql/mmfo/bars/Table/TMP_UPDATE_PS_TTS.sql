PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/TMP_UPDATE_PS_TTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Drop table TMP_UPDATE_PS_TTS  ***
begin 
  execute immediate 'drop table BARS.TMP_UPDATE_PS_TTS';
  exception when others then null;
end; 
/

PROMPT *** Create table TMP_UPDATE_PS_TTS  ***
begin 
  execute immediate 'create table BARS.TMP_UPDATE_PS_TTS
(
  old_nbs VARCHAR2(100),
  new_nbs VARCHAR2(100)
)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** Create  grants  TMP_UPDATE_PS_TTS ***
grant DELETE,INSERT,SELECT,UPDATE     on TMP_UPDATE_PS_TTS          to BARS_ACCESS_DEFROLE;

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/TMP_UPDATE_PS_TTS.sql =========*** End *** ==
PROMPT ===================================================================================== 