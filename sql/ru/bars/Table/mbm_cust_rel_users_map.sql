exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_CUST_REL_USERS_MAP','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_CUST_REL_USERS_MAP','FILIAL', null, null, null, null);

begin
  execute immediate 
'create table mbm_cust_rel_users_map
(
    cust_id         number          not null,
    rel_cust_id     number          not null,
    sign_number     number(10)      default 0 not null, 
    user_id         varchar2(128),
	is_approved		NUMBER,
	approved_type   VARCHAR2(100)
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE MBM_CUST_REL_USERS_MAP IS 'Повязані особи котрим надано доступ до CorpLight';
COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.cust_id IS 'ID клієнта';
COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.rel_cust_id IS 'ID повязаної особи';
COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.sign_number IS '№ підпису';
COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.user_id IS 'Id користувача з CorpLight';
COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.is_approved IS 'Признак чи підтверджено зміни бек офісом';
COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.approved_type IS 'Тип змін, що потрібно підтвердити';


grant all on mbm_cust_rel_users_map to bars_access_defrole;
