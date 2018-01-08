-- ======================================================================================
-- Module : GERC_PAYMENTS
-- Author : inga
-- Date   : 03.12.2015
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED
SET DEFINE ON

begin
  bpa.alter_policy_info( 'GERC_STATECODES', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'GERC_STATECODES', 'FILIAL', null, null, null, null );
end;
/

begin
execute immediate 
  'CREATE TABLE BARS.GERC_STATECODES
    ( ID    int,
      State  varchar2(70)
    ) TABLESPACE brssmld';
    exception
  when others then
    if sqlcode = -955 then null;
    else raise;
    end if;  
end;
/

COMMENT ON TABLE  BARS.GERC_STATECODES                IS 'Код обработки операций ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_STATECODES.ID             IS 'Код';
COMMENT ON COLUMN BARS.GERC_STATECODES.State          IS 'Описние кода обработки';

GRANT all ON BARS.GERC_STATECODES TO BARS_ACCESS_DEFROLE;

begin
  execute immediate 
  'ALTER TABLE BARS.GERC_STATECODES ADD ( CONSTRAINT PK_GERC_STATECODES PRIMARY KEY (ID))';
exception
  when others then
    if sqlcode = -02260 then null;
    else raise;
    end if;  
end;
/

begin
  execute immediate 'CREATE UNIQUE INDEX BARS.UK_GERC_STATECODES ON BARS.GERC_STATECODES (ID) TABLESPACE brssmli';
exception
  when others then
    if sqlcode = -01408 then null;
    else raise;
    end if;  
end;
/

begin 
  execute immediate 
  'ALTER TABLE BARS.GERC_STATECODES ADD ( CONSTRAINT FK_GERC_STATECODES
   FOREIGN KEY (ID) REFERENCES BARS.SOS (SOS))';
exception 
  when others then 
    if sqlcode = -2275 then null;
    else raise;
    end if;
end;
/
