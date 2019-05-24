begin    execute immediate ' CREATE TABLE BARS.TMP_XOZ16( isp int, nd number NOT NULL,  S  NUMBER ) ';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;

/

begin    execute immediate ' alter TABLE BARS.TMP_XOZ16 add (NPP int ) ' ;
exception when others then   if SQLCODE = - 01430  then null;   else raise; end if; --ORA-01430: column being added already exists in table
end;
/

COMMENT ON TABLE  BARS.TMP_XOZ16     IS 'тимчасова табл для збереження СУМ ДЛЯ ПРОВОДОК ПО МСФЗ-16 ';

COMMENT ON COLUMN BARS.TMP_XOZ16.nd  IS 'Референс ДОГ';
COMMENT ON COLUMN BARS.TMP_XOZ16.S   IS 'План-сума ';
COMMENT ON COLUMN BARS.TMP_XOZ16.ISP IS 'ВИКОНАВЕЦЬ';
/*.
1.1)ВСІ.Визнання активу:4600/**=>3615/04*КРЕД.заборг
1.2)ВСІ.Визнання активу:4600/**=>3519/26*ДЕБІТ.заборг
1.3)ВСІ.Визнання активу:4600/**=>3500/04*Витрати майб
2.1)ВСІ.Нарахування витрат за місяць:7028/01=>3618/01
3.1)ВСІ.Закриття КРЕД на ДЕБ заборг.:3615/04=>3519/26
3.2)ВСІ.Закриття Нар.Витрат на ДЕБ заборг.:3618/01=>3519/26
3.3)ВСІ.Закриття ДЕБ заборг. з ПДВ: 7410*09 => 3519/26
*/

GRANT  SELECT on BARS.tmp_XOZ16 TO BARS_ACCESS_DEFROLE;

begin    execute immediate '  ALTER TABLE BARS.TMP_XOZ16 ADD (  CONSTRAINT PK_tmpxoz16  PRIMARY KEY  (nd)) ';
exception when others then   if SQLCODE = - 02260 then null;   else raise; end if; --ORA-02260: table can have only one primary key
end;
/

