begin

   execute immediate 'begin bpa.alter_policy_info(''MBDK_PRODUCT'', ''WHOLE'' , null , null, null, null ); end;'; 
   execute immediate 'begin bpa.alter_policy_info(''MBDK_PRODUCT'', ''FILIAL'', null , null, null, null ); end;';

end;
/

begin
   EXECUTE IMMEDIATE 'create table BARS.MBDK_PRODUCT'||
      '(code_product  integer,
        name_product  varchar2(100),
        nbs           char(4),
        ob22          char(2)
       ) TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 

end;
/

begin
   execute immediate 'begin   bpa.alter_policies(''MBDK_PRODUCT''); end;'; 
end;
/
commit;

-------------------------------------------------------------
COMMENT ON TABLE  BARS.MBDK_PRODUCT              IS 'Справочник продуктов МБДК';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.code_product IS 'Код продукта';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.name_product IS 'Наименование продукта';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.NBS          IS 'Бал.рах.продукту';
COMMENT ON COLUMN BARS.MBDK_PRODUCT.ob22         IS 'ОБ22 продукту';
                                             
PROMPT *** Create  index PK_MBDK_PRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MBDK_PRODUCT ON BARS.MBDK_PRODUCT (code_product) 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_REZ_DEB ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBDK_PRODUCT ADD CONSTRAINT PK_MBDK_PRODUCT PRIMARY KEY (code_product)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



exec bars_policy_adm.alter_policy_info(p_table_name => 'MBDK_PRODUCT', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null);
exec bars_policy_adm.alter_policy_info(p_table_name => 'MBDK_PRODUCT', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null);  
exec bars_policy_adm.alter_policies(p_table_name => 'MBDK_PRODUCT');

GRANT SELECT, INSERT, UPDATE, DELETE ON BARS.MBDK_PRODUCT TO RCC_DEAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON BARS.MBDK_PRODUCT TO START1;
GRANT SELECT, INSERT, UPDATE, DELETE ON BARS.MBDK_PRODUCT TO BARS_ACCESS_DEFROLE;

COMMIT;

