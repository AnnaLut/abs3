
exec bpa.alter_policy_info( 'MBDK_ob22', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'MBDK_ob22', 'FILIAL', null, null, null, null );

begin    execute immediate ' create table MBDK_ob22 ( 
 VIDD  int,
 NAME  VARCHAR2(100),
 SS    VARCHAR2(6),
  SP   VARCHAR2(6),
  SN   VARCHAR2(6),
  SPN  VARCHAR2(6),
  SD_N VARCHAR2(6),
  SD_I VARCHAR2(6),
  IO   int , 
  d_close date ) ';

exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/
exec  bpa.alter_policies('MBDK_ob22'); 

COMMENT ON TABLE  BARS.MBDK_ob22         IS 'Довідник Бал.рах+Ob22 для модуля МБДК';
COMMENT ON COLUMN BARS.MBDK_ob22.SS      IS 'Бал.рах+Ob22 Нормальн.тіла'; 
COMMENT ON COLUMN BARS.MBDK_ob22.SP      IS 'Бал.рах+Ob22 Простроч.тіла'; 
COMMENT ON COLUMN BARS.MBDK_ob22.SN      IS 'Бал.рах+Ob22 Нормальн.проц'; 
COMMENT ON COLUMN BARS.MBDK_ob22.SPN     IS 'Бал.рах+Ob22 Простроч.проц'; 
COMMENT ON COLUMN BARS.MBDK_ob22.SD_N    IS 'Бал.рах+Ob22 % Дох/Витр від грн'; 
COMMENT ON COLUMN BARS.MBDK_ob22.SD_I    IS 'Бал.рах+Ob22 % Дох.Витр від вал'; 
COMMENT ON COLUMN BARS.MBDK_ob22.d_close IS 'Дата ДЕ-яктивації ';
COMMENT ON COLUMN BARS.MBDK_ob22.Io      IS 'Признак "Депозита" =1 , "Кдедита"=0 ';
                                 
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.MBDK_ob22 TO BARS_ACCESS_DEFROLE;

begin    execute immediate '  ALTER TABLE BARS.MBDK_ob22 ADD (  CONSTRAINT PK_MBDKob22  PRIMARY KEY  (Vidd )) ';
exception when others then   if SQLCODE = - 02260 then null;   else raise; end if; --ORA-02260: table can have only one primary key
end;
/


