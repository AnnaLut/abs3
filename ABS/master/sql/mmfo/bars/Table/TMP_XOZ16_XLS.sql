begin    execute immediate 
' CREATE TABLE BARS.TMP_XOZ16_XLS ( KF varchar2(6), dat01 date, cc_ID varchar2 (50), sdate date, nls_3519 varchar2(14),   RNKX number, RNKA number, nd  number,
s11 number,s12 number,
s21 number,s22 number,
s31 number,s32 number, s33 number) ';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

begin    execute immediate ' alter TABLE BARS.TMP_XOZ16_XLS add (NPP int, PROD varchar2(6) ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/

begin    execute immediate ' alter TABLE BARS.TMP_XOZ16_XLS add (NLS_3519_OLD varchar2(14) ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/

COMMENT ON TABLE  BARS.TMP_XOZ16_XLS          IS 'Прообрах XLS-табл для збереження СУМ ДЛЯ ПРОВОДОК ПО МСФЗ-16 ';
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.KF       IS 'MFO РУ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.DAT01    IS 'Звітна~дата   ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.CC_ID    IS 'Номер~договору~B' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.SDATE    IS 'Дата~договору~C' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.NLS_3519 IS 'Рахунок~3519*26~G' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.NPP      IS '№ строки в XLS' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.RNKA     IS 'РНК(АБС)~Клієнта' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.ND       IS 'Реф.дог~в АБС' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.PROD     IS '4600.**' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.s11  IS '1.1)ВСІ.Визнання активу:4600/**=>3615/04*КРЕД.заборг       ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S12  IS '1.2)ВСІ.Визнання активу:4600/**=>3519/26*ДЕБІТ.заборг      ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S21  IS '2.1)ВСІ.Нарахування витрат за місяць:7028/01=>3618/01      ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S22  IS '2.2)ВСІ.Переоцінка активу за місяць:3615=>4600      ' ;

COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.s31  IS '3.1)ВСІ.Закриття КРЕД на ДЕБ заборг.:3615/04=>3519/26      ' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S32  IS '3.2)ВСІ.Закриття Нар.Витрат на ДЕБ заборг.:3618/01=>3519/26' ;
COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.s33  IS '3.3)ВСІ.Закриття ДЕБ заборг. з ПДВ: 7410*09 => 3519/26     ' ;

GRANT  SELECT on BARS.tmp_XOZ16_XLS TO BARS_ACCESS_DEFROLE;
