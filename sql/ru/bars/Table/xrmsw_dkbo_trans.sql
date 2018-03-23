-- ======================================================================================
-- Module : INTG_XRMSW XRMSW_DKBO_TRANS
-- Author : inga
-- Date   : 12.05.2017
-- ======================================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED

begin
  bpa.alter_policy_info( 'XRMSW_DKBO_TRANS', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'XRMSW_DKBO_TRANS', 'FILIAL', null, null, null, null );
end;
/
begin
execute immediate 
  'CREATE TABLE BARS.XRMSW_DKBO_TRANS
    (TransactionId  varchar2(30),
    Rnk             number          not null,
    DealNumber      varchar2(100),
    acc_list        varchar2(1000),
    dkbo_date_from  date            ,
    dkbo_date_to    date            ,
    dkbo_date_state number          ,
    deal_id         number,    
    startdate       date,
    StatusCode      number,
    ErrorMessage    varchar2(2000),
    external_id     VARCHAR2(300 CHAR),
    CONSTRAINT fk_XRMDKBO_TransactionId
    FOREIGN KEY (TransactionId)
    REFERENCES XRMSW_AUDIT (TransactionId),
	kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
    ) TABLESPACE BRSBIGD';
    exception
  when others then
    if sqlcode = -955 then null;
    else raise;
    end if;  
end;
/
begin
    execute immediate 'ALTER TABLE BARS.XRMSW_DKBO_TRANS add(kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/
begin
    execute immediate 'ALTER TABLE BARS.XRMSW_DKBO_TRANS add(external_id     VARCHAR2(300 CHAR))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/
grant select on BARS.XRMSW_DKBO_TRANS to bars_access_defrole;
/