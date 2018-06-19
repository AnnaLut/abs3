prompt ---------------------------------------------------------------
prompt 1.TABLE  BARS.SRR_XLS  Файл результтів розрахунків складової SRR
prompt ---------------------------------------------------------------

exec bars.bpa.alter_policy_info( 'SRR_XLS', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'SRR_XLS', 'FILIAL', null, null, null, null );

begin EXECUTE IMMEDIATE ' CREATE TABLE BARS.SRR_XLS
     ( ID_CALC_SET    NUMBER          NOT NULL,
       UNIQUE_BARS_IS VARCHAR2(100)   NOT NULL,
       ID_BRANCH      VARCHAR2(30 )   NOT NULL,
       ID_CURRENCY    VARCHAR2(30 )   NOT NULL,
       FV_CCY         NUMBER(24,2), 
       CLIENT_name    VARCHAR2(100 ),
       RNK_CLIENT     VARCHAR2 (30 ),
       Comm           VARCHAR2(100 )

)'; 
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('SRR_XLS'); 
commit;

begin execute immediate   'alter table SRR_XLS add (RNK_CLIENT  VARCHAR2 (30 )) ';
exception when others then  if SQLCODE = - 01430 then null;   else raise; end if;     -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON TABLE  BARS.SRR_XLS                  IS 'Файл результтів розрахунків складової SRR';
COMMENT ON COLUMN BARS.SRR_XLS.ID_CALC_SET      IS 'Ідентифікатор розрахунку';
COMMENT ON COLUMN BARS.SRR_XLS.UNIQUE_BARS_IS   IS 'Ідентифікатор договору в АБС "БАРС"';
COMMENT ON COLUMN BARS.SRR_XLS.ID_BRANCH        IS 'Номер РУ';
COMMENT ON COLUMN BARS.SRR_XLS.ID_CURRENCY      IS 'Ідентифікатор валюти (символьний)';
COMMENT ON COLUMN BARS.SRR_XLS.FV_CCY           IS 'Дельта суми переоцінки ( чи сальдо ) рахунку SRR ? ';
COMMENT ON COLUMN BARS.SRR_XLS.CLIENT_name      IS 'Назва клієнта ( для зручності)';
COMMENT ON COLUMN BARS.SRR_XLS.Comm             IS 'Результат обробки запису';
COMMENT ON COLUMN BARS.SRR_XLS.RNK_CLIENT       IS 'РНК клієнта ';

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS. SRR_XLS TO BARS_ACCESS_DEFROLE;
