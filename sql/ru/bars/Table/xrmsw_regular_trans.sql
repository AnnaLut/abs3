

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_REGULAR_TRANS.sql =========*** R
PROMPT ===================================================================================== 

begin
  bpa.alter_policy_info( 'XRMSW_REGULAR_TRANS', 'WHOLE',  null, null, null, null ); 
  bpa.alter_policy_info( 'XRMSW_REGULAR_TRANS', 'FILIAL', null, null, null, null );
end;
/
begin
execute immediate 
  'CREATE TABLE BARS.XRMSW_REGULAR_TRANS
    (TransactionId  varchar2(30),
    Rnk             number          not null,
    StartDate       date            not null,
    FinishDate      date            not null,
    Frequency       number          not null,
    KV              number          not null,
    NLSA            varchar2(15)    not null,
    OKPOB           varchar2(10)    not null,
    NAMEB           varchar2(37)    not null,
    MFOB            varchar2(6)     not null,
    NLSB            varchar2(15)    not null,
    Holyday         number(1)       not null,
    Sum             varchar2(200)   not null,
    Purpose         varchar2(160)   not null,
    DPT_ID          number,
    AGR_ID          number,
    StatusCode      number,
    ErrorMessage    varchar2(2000),
    CONSTRAINT fk_XRMREG_TransactionId
    FOREIGN KEY (TransactionId)
    REFERENCES XRMSW_AUDIT (TransactionId),
    CONSTRAINT fk_XRMFrequency
    FOREIGN KEY (Frequency)
    REFERENCES FREQ (FREQ),
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
    execute immediate 'ALTER TABLE BARS.XRMSW_REGULAR_TRANS add(kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/
grant select on BARS.XRMSW_REGULAR_TRANS to bars_access_defrole;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_REGULAR_TRANS.sql =========*** E
PROMPT ===================================================================================== 
