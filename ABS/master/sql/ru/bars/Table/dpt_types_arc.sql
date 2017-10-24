exec bpa.alter_policy_info( 'DPT_TYPES_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_TYPES_ARC', 'FILIAL', null, null, null, null );
/
begin
  execute immediate 'CREATE TABLE DPT_TYPES_ARC(
  TYPE_ID    NUMBER(38) CONSTRAINT CC_DPTTYPESARC_TYPEID_NN NOT NULL,
  TYPE_NAME  VARCHAR2(100 BYTE) CONSTRAINT CC_DPTTYPESARC_TYPENAME_NN NOT NULL,
  DATE_OFF   DATE  DEFAULT sysdate CONSTRAINT CC_DPTTYPESARC_DATE_OFF NOT NULL,
  USER_OFF   NUMBEr(38) DEFAULT sys_context(''bars_context'',''user_id'') CONSTRAINT CC_DPTTYPESARC_USER_OFF NOT NULL,
  TYPE_CODE  VARCHAR2(4 BYTE),
  SORT_ORD   NUMBER(38),
  FL_ACTIVE  NUMBER(1),
  FL_DEMAND  NUMBER(1)                          DEFAULT 0
  ) TABLESPACE brssmld';
exception when others then if (sqlcode = -00955) then null; else raise; end if;            
end;
/

COMMENT ON TABLE DPT_TYPES_ARC IS 'Типи депозитів фізичних осіб (Архів)';
COMMENT ON COLUMN DPT_TYPES_ARC.TYPE_ID IS 'Числ.код типу';
COMMENT ON COLUMN DPT_TYPES_ARC.DATE_OFF IS 'Дата видалення в архів';
COMMENT ON COLUMN DPT_TYPES_ARC.USER_OFF IS 'Користувач, видаливший тип в архів';
COMMENT ON COLUMN DPT_TYPES_ARC.TYPE_NAME IS 'Найменування типу';
COMMENT ON COLUMN DPT_TYPES_ARC.TYPE_CODE IS 'Симв.код типа договора';
COMMENT ON COLUMN DPT_TYPES_ARC.SORT_ORD IS 'Порядок сортировки';
COMMENT ON COLUMN DPT_TYPES_ARC.FL_ACTIVE IS 'Ознака активності продукту';
COMMENT ON COLUMN DPT_TYPES_ARC.FL_DEMAND IS 'Ознака депозитного продукту "До запитання"';
/
GRANT ALTER, DELETE, INSERT, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON DPT_TYPES_ARC TO BARS_ACCESS_DEFROLE;
/
