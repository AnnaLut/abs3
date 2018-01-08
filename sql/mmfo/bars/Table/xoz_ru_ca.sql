exec bpa.alter_policy_info( 'XOZ_RU_CA', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'XOZ_RU_CA', 'FILIAL', null, null, null, null );

begin    execute immediate ' CREATE TABLE BARS.XOZ_RU_CA  ( REF1 NUMBER, REFD_RU NUMBER, RECd_ru NUMBER,  
                                                                         RECd_CA NUMBER, REFK_CA NUMBER, ref2 number) ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('XOZ_RU_CA'); 

COMMENT ON TABLE  BARS.XOZ_RU_CA          IS 'Обмін запитами та платежами міх РУ та ЦА';
COMMENT ON COLUMN BARS.XOZ_RU_CA.ref1     IS 'Первинний реф виникнення деб заборг в РУ';
COMMENT ON COLUMN BARS.XOZ_RU_CA.reFd_ru  IS 'РЕФ деб запиту від РУ на ЦА ( в РУ)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.reCd_ru  IS 'Рек відправленого деб запиту від РУ на ЦА ( в РУ)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.reCd_CA  IS 'Рек отриманого деб запиту від РУ на ЦА ( в ЦА)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.reFk_CA  IS 'Реф сплати отриманого деб запиту від РУ на ЦА ( в ЦА)';
COMMENT ON COLUMN BARS.XOZ_RU_CA.ref2     IS 'реф закриття  деб заборг в РУ';

GRANT DELETE, INSERT, SELECT ON BARS.XOZ_RU_CA TO BARS_ACCESS_DEFROLE;
--------------------------------------------------------------------------------------------