begin
  BPA.ALTER_POLICY_INFO( 'NBUR_OVDP_6EX_UPDATE', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'NBUR_OVDP_6EX_UPDATE', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table NBUR_OVDP_6EX_UPDATE
(
  date_fv       DATE,
  isin          VARCHAR2(20),
  kv            VARCHAR2(3),
  fv_cp         NUMBER(10,2),
  yield         NUMBER(10,6),
  kurs          NUMBER(10,6),
  koef          NUMBER(10,2),
  date_maturity DATE,
  chgdate       DATE default sysdate,
  chgaction     VARCHAR2(1),
  doneby        VARCHAR2(30)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

