PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/TMP_PS_TTS_BACKUP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Drop table TMP_PS_TTS_BACKUP  ***
begin 
  execute immediate 'drop table BARS.TMP_PS_TTS_BACKUP';
  exception when others then null;
end; 
/

PROMPT *** Create table TMP_PS_TTS_BACKUP  ***
begin 
  execute immediate 'create table BARS.TMP_PS_TTS_BACKUP
as select * from BARS.PS_TTS';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** Create  grants  TMP_PS_TTS_BACKUP ***
grant DELETE,INSERT,SELECT,UPDATE     on TMP_PS_TTS_BACKUP          to BARS_ACCESS_DEFROLE;

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/TMP_PS_TTS_BACKUP.sql =========*** End *** ==
PROMPT ===================================================================================== 