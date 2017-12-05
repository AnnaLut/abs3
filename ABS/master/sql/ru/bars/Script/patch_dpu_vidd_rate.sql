-- ======================================================================================
-- Author : BAA
-- Date   : 11.07.2016
-- ===================================== <Comments> =====================================
-- reorganization PRIMARY KEY on table bars.DPU_VIDD_RATE
-- add column KF
-- add policy
-- recreate UNIQUE KEY
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     ON
SET DEFINE       OFF
SET LINES        300
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON
set VERIFY       OFF

begin
  
  bpa.disable_policies('DPU_VIDD_RATE');
  
  delete BARS.DPU_VIDD_RATE 
   where TYPE_ID not in ( select TYPE_ID from DPU_TYPES );
  
  delete BARS.DPU_VIDD_RATE 
   where ( VIDD, TYPE_ID ) not in ( select VIDD, TYPE_ID from DPU_VIDD );
  
  bpa.enable_policies('DPU_VIDD_RATE');
  
exception
  when OTHERS then
    bpa.enable_policies('DPU_VIDD_RATE');
    dbms_output.put_line( dbms_utility.format_error_stack() ||chr(10)||
                          dbms_utility.format_error_backtrace() );
end;
/

commit;

SET FEEDBACK     OFF

---
-- FK_DPUVIDDRATE_TABVAL
---

begin
  execute immediate 'ALTER TABLE BARS.DPU_VIDD_RATE DROP CONSTRAINT FK_DPUVIDDRATE_TABVAL';
  dbms_output.put_line( 'Table altered.' );
exception
  when OTHERS then 
    if (sqlcode = -02443) 
    then dbms_output.put_line( 'Cannot drop constraint - nonexistent constraint.' );
    else raise;
    end if;  
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_TABVAL FOREIGN KEY (KV) REFERENCES BARS.TABVAL$GLOBAL (KV)]';
  dbms_output.put_line('Constraint FK_DPUVIDDRATE_TABVAL created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.TABVAL$GLOBAL does not exist.');
      else raise;
    end case;
end;
/

---
-- FK_DPUVIDDRATE_DPUTYPES
---

begin
  execute immediate 'ALTER TABLE BARS.DPU_VIDD_RATE DROP CONSTRAINT FK_DPUVIDDRATE_DPUTYPES';
  dbms_output.put_line( 'Table altered.' );
exception
  when OTHERS then 
    if (sqlcode = -02443) 
    then dbms_output.put_line( 'Cannot drop constraint - nonexistent constraint.' );
    else raise;
    end if;  
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_DPUTYPES FOREIGN KEY (TYPE_ID) REFERENCES BARS.DPU_TYPES (TYPE_ID)]';
  dbms_output.put_line('Constraint FK_DPUVIDDRATE_DPUTYPES created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

---
-- FK_DPUVIDDRATE_DPUVIDD
---

begin
  execute immediate 'ALTER TABLE BARS.DPU_VIDD_RATE DROP CONSTRAINT FK_DPUVIDDRATE_DPUVIDD';
  dbms_output.put_line( 'Table altered.' );
exception
  when OTHERS then 
    if (sqlcode = -02443) 
    then dbms_output.put_line( 'Cannot drop constraint - nonexistent constraint.' );
    else raise;
    end if;  
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_DPUVIDD  FOREIGN KEY (VIDD, TYPE_ID) REFERENCES BARS.DPU_VIDD (VIDD, TYPE_ID)]';
  dbms_output.put_line('Constraint FK_DPUVIDDRATE_DPUTYPES created.');
exception
  when OTHERS then
    if (sqlcode = -02275)
    then dbms_output.put_line('Such a referential constraint already exists in the table.');
    else raise;
    end if;
end;
/

begin
  
  bpa.disable_policies('DPU_VIDD_RATE');
  
  bc.subst_mfo(bars.f_ourmfo_g);
  
  execute immediate q'[alter TABLE BARS.DPU_VIDD_RATE add KF VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo') CONSTRAINT CC_DPUVIDDRATE_KF_NN NOT NULL]';
  
  dbms_output.put_line('Table altered.');
  
  bc.set_context;
  
  bpa.enable_policies('DPU_VIDD_RATE');
  
exception
  when OTHERS then
    bc.set_context;
    bpa.enable_policies('DPU_VIDD_RATE');
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column KF already exists in table.');
    else raise;
    end if;
end;
/

SET FEEDBACK     ON

begin
  bpa.alter_policy_info( 'DPU_VIDD_RATE', 'CENTER', NULL, 'E', 'E', 'E' );
  commit;
exception
  when OTHERS then null;
end;
/

begin
  bpa.alter_policy_info( 'DPU_VIDD_RATE', 'WHOLE' , NULL, 'E', 'E', 'E' );
  bpa.alter_policy_info( 'DPU_VIDD_RATE', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

begin
  bpa.alter_policies('DPU_VIDD_RATE');
end;
/

commit;

COMMENT ON COLUMN BARS.DPU_VIDD_RATE.KF           IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';

SET FEEDBACK     OFF

--
-- drop UNIQUE KEY
--
begin
  execute immediate 'alter table BARS.DPU_VIDD_RATE drop constraint UK_DPUVIDDRATE DROP INDEX';
  dbms_output.put_line( 'Unique key UK_DPUVIDDRATE droped.' );
EXCEPTION
  when OTHERS then
    if ( sqlcode = -02443 ) 
    then dbms_output.put_line( 'Unique key UK_DPUVIDDRATE does not exist.' );
    else raise;
    end if;
END;
/

--
-- create CONSTRAINT UNIQUE KEY
--
BEGIN
  execute immediate 'alter table BARS.DPU_VIDD_RATE add constraint UK_DPUVIDDRATE UNIQUE ( KF, TYPE_ID, KV, VIDD, TERM, TERM_DAYS, LIMIT ) USING INDEX TABLESPACE BRSSMLI';
  dbms_output.put_line('Unique key UK_DPUVIDDRATE created.');
EXCEPTION
  when OTHERS then
    if (sqlcode = -02261) 
    then dbms_output.put_line('Such unique or primary key already exists in the table.');
    else raise;
    end if;
END;
/
