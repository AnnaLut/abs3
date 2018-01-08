------------------------------------------------------------------------------------
exec bpa.alter_policy_info( 'XOZ_OB22_CL', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'XOZ_OB22_CL', 'FILIAL', null, null, null, null );

begin    execute immediate ' CREATE TABLE BARS.XOZ_OB22_CL ( DEB  CHAR(6),  KDM int , KDX int ) ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; --ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('XOZ_OB22_CL'); 


begin    execute immediate ' alter TABLE BARS.XOZ_OB22_CL add (DZ int, RD int ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/


COMMENT ON TABLE  BARS.XOZ_OB22_CL      IS 'Планові Терміни знаходження на балансі';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.DEB  IS 'Продукт~R020 + Ob22';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.KDM  IS 'Кількість днів Min';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.KDX  IS 'Кількість днів Max';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.KDM  IS 'Кількість днів Min';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.KDX  IS 'Кількість днів Max';

COMMENT ON COLUMN BARS.XOZ_OB22_CL.DZ   IS 'Право на деб.запит до ЦА';
COMMENT ON COLUMN BARS.XOZ_OB22_CL.RD   IS 'Право на поновлення дати виникнення при частковому погашенні';



GRANT SELECT, insert, update, delete  ON BARS.XOZ_Ob22_CL TO BARS_ACCESS_DEFROLE;