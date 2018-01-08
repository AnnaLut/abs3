exec bpa.alter_policy_info( 'XOZ_OB22', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'XOZ_OB22', 'FILIAL', null, null, null, null );

begin    execute immediate ' CREATE TABLE BARS.XOZ_OB22(   DEB  CHAR(6 BYTE),  KRD  CHAR(6 BYTE)) ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('XOZ_OB22'); 

COMMENT ON TABLE BARS.XOZ_OB22 IS 'Бух.модели вариантов закрытия хоз.деб.';
COMMENT ON COLUMN BARS.XOZ_OB22.DEB IS 'Продукт-создания (Дебет)';
COMMENT ON COLUMN BARS.XOZ_OB22.KRD IS 'Продукт-закрытия (Кредит)';

begin    execute immediate ' alter TABLE BARS.XOZ_OB22 add (   txt varchar2(50)  ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.XOZ_OB22.txt IS 'Коментар';


GRANT DELETE, INSERT, SELECT ON BARS.XOZ_OB22 TO BARS_ACCESS_DEFROLE;
GRANT DELETE, INSERT, SELECT ON BARS.XOZ_OB22 TO START1;
--------------------------------------------------------------------------------------------