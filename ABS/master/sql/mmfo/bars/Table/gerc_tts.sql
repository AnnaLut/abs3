-- ======================================================================================
-- Module : GERC_PAYMENTS
-- Author : inga
-- Date   : 03.12.2015
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED
SET DEFINE ON


begin
  bpa.alter_policy_info( 'GERC_TTS', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'GERC_TTS', 'FILIAL', null, null, null, null );
end;
/

begin
execute immediate 
  'CREATE TABLE BARS.GERC_TTS
    ( TT    char(3),
      name  varchar2(70)
    ) TABLESPACE brssmld';
    exception
  when others then
    if sqlcode = -955 then null;
    else raise;
    end if;  
end;
/

COMMENT ON TABLE  BARS.GERC_TTS                IS 'Операции, доступные для приема из ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_TTS.TT             IS 'Код операции';
COMMENT ON COLUMN BARS.GERC_TTS.NAME           IS 'Описние операции/название';

GRANT SELECT                         ON BARS.GERC_TTS TO BARS_ACCESS_DEFROLE;

begin
  execute immediate 
  'ALTER TABLE BARS.GERC_TTS ADD ( CONSTRAINT PK_GERC_TTS PRIMARY KEY (TT))';
exception
  when others then
    if sqlcode = -02260 then null;
    else raise;
    end if;  
end;
/

begin
  execute immediate 'CREATE UNIQUE INDEX BARS.UK_GERC_TTS ON BARS.GERC_TTS (TT) TABLESPACE brssmli';
exception
  when others then
    if sqlcode = -01408 then null;
    else raise;
    end if;  
end;
/

begin 
  execute immediate 
  'ALTER TABLE BARS.GERC_TTS ADD ( CONSTRAINT FK_GERC_TTS
   FOREIGN KEY (TT) REFERENCES BARS.TTS (TT))';
exception 
  when others then 
    if sqlcode = -2275 then null;
    else raise;
    end if;
end;
/
