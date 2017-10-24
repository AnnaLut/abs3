-- ======================================================================================
-- Module : GERC_PAYMENTS
-- Author : inga
-- Date   : 03.12.2015
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED
SET DEFINE ON


begin
  bpa.alter_policy_info( 'GERC_AUDIT', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'GERC_AUDIT', 'FILIAL', null, null, null, null );
end;
/

begin
execute immediate 
  'CREATE TABLE BARS.GERC_AUDIT
    (date_run               date default sysdate, 
     ExternalDocument_id    varchar2(30), 
     Rec_message            varchar2(2000)
     ) TABLESPACE brsbigd';
    exception
  when others then
    if sqlcode = -955 then null;
    else raise;
    end if;  
end;
/

COMMENT ON TABLE  BARS.GERC_AUDIT                       IS 'Журнал обработки операций ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_AUDIT.ExternalDocument_id   IS 'Номер документа в системе ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_AUDIT.Rec_message           IS 'Сообщение';

GRANT all ON BARS.GERC_AUDIT TO BARS_ACCESS_DEFROLE;
