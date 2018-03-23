-- ======================================================================================
-- Module : INTG_XRMSW XRMSW_FREESBON_TRANS
-- Author : inga
-- Date   : 18.04.2017
-- ======================================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED

begin
  bpa.alter_policy_info( 'XRMSW_FREESBON_TRANS', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'XRMSW_FREESBON_TRANS', 'FILIAL', null, null, null, null );
end;
/
begin
execute immediate 
  'CREATE TABLE BARS.XRMSW_FREESBON_TRANS
    (TransactionId  varchar2(30),    
     payer_account_id integer,
     start_date date,
     stop_date date,
     payment_frequency integer,
     holiday_shift integer,
     provider_id integer,
     regular_amount number,
     receiver_mfo varchar2(6),
     receiver_account varchar2(15),
     receiver_name varchar2(70),
     receiver_edrpou varchar2(10),
     purpose varchar2(160),
     extra_attributes clob,
     sendsms varchar2(1),
     orderid number,
     StatusCode      number,
     ErrorMessage    varchar2(2000),
	 kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
     CONSTRAINT fk_XRMREGfSbon_TransactionId
     FOREIGN KEY (TransactionId)
     REFERENCES XRMSW_AUDIT (TransactionId),
     CONSTRAINT fk_XRMfSbonFrequency
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
grant select on BARS.XRMSW_FREESBON_TRANS to bars_access_defrole;
/