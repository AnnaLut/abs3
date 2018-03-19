-- ======================================================================================
-- Module : INTG_XRMSW XRMSW_SBON_TRANS
-- Author : inga
-- Date   : 18.04.2017
-- ======================================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED

begin
  bpa.alter_policy_info( 'XRMSW_SBON_TRANS', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'XRMSW_SBON_TRANS', 'FILIAL', null, null, null, null );
end;
/
begin
execute immediate 
  'CREATE TABLE BARS.XRMSW_SBON_TRANS
    (TransactionId  varchar2(30),
     SbonTYPE       varchar2(30), --Contr,NoContr     
     payer_account_id     INTEGER,
     start_date           DATE,
     stop_date            DATE,
     payment_frequency    INTEGER,
     holiday_shift        INTEGER,
     provider_id          INTEGER,
     personal_account     VARCHAR2(100),
     regular_amount       NUMBER,
     ceiling_amount       NUMBER,
     extra_attributes     CLOB,
     sendsms              VARCHAR2(1),
     order_id             NUMBER,    
     StatusCode      number,
     ErrorMessage    varchar2(2000),
	 kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),	 
     CONSTRAINT fk_XRMREGSbon_TransactionId
     FOREIGN KEY (TransactionId)
     REFERENCES XRMSW_AUDIT (TransactionId),
     CONSTRAINT fk_XRMSbonFrequency
     FOREIGN KEY (payment_frequency)
     REFERENCES FREQ (FREQ)
    ) TABLESPACE BRSBIGD';
    exception
  when others then
    if sqlcode = -955 then null;
    else raise;
    end if;  
end;
/
grant select on BARS.XRMSW_SBON_TRANS to bars_access_defrole;
/