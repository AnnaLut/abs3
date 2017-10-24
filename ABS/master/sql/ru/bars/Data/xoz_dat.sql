begin suda;
      insert into tips (tip, name) values ('XOZ','ƒеб.заборг за госп д≥€льн≥стю банку');
exception when others then  if SQLCODE = -00001 then null;   else raise; end if; 
end;
/

/*
3510	11	1	ƒеб≥торська заборгован≥сть з придбанн€ активiв
3519	11	1	ƒебiторська заборгованiсть за послуги
3550	11	1	јванси прац≥вникам банку на витрати з в≥др€дженн€
3551	11	1	јванси прац≥вникам банку на господарськ≥ витрати
3552	11	1	Ќестач≥ та ≥нш≥ нарахуванн€ на прац≥вник≥в банку
3559	11	1	Iнша деб≥торська заборгован≥сть за розрахунками з прац≥вниками банку та iншими особами
*/

begin Insert into BARS.NBS_TIPS  (NBS, TIP) Values ('3510', 'XOZ'); exception when others then null; end;
/
begin Insert into BARS.NBS_TIPS  (NBS, TIP) Values ('3519', 'XOZ'); exception when others then null; end;
/
begin Insert into BARS.NBS_TIPS  (NBS, TIP) Values ('3550', 'XOZ'); exception when others then null; end;
/
begin Insert into BARS.NBS_TIPS  (NBS, TIP) Values ('3551', 'XOZ'); exception when others then null; end;
/
begin Insert into BARS.NBS_TIPS  (NBS, TIP) Values ('3552', 'XOZ'); exception when others then null; end;
/
begin Insert into BARS.NBS_TIPS  (NBS, TIP) Values ('3559', 'XOZ'); exception when others then null; end;
/

COMMIT;
----------------------------------------------------------------
begin
  for k in (select a.ROWID RI , a.KF   from accounts a, NBS_TIPS b 
            where a.dazs is null and a.nbs = b.nbs and b.tip ='XOZ' and a.tip <> b.tip and a.nbs not in ('3550', '3551'))
  loop bc.go (k.KF); update accounts set tip ='XOZ' where rowid = k.RI; end loop;
  suda;
  bc.home();
end;
/
commit;
-----------------

/*
3500 ј 	¬итрати майбутн≥х пер≥од≥в
03 Ц передоплата пер≥одичних видань;
04 - передоплата за обїЇкти оренди, прийн€т≥ в оперативний л≥зинг       (оренду);
05 Ц авансов≥ платеж≥ за супров≥д програмного забезпеченн€;
08 Ц витрати на виготовленн€ бланк≥в суворого обл≥ку;
09 Ц передплата за утриманн€ автотранспорту (в т.ч.сто€нка);
11 Ц аванси на охорону обТЇкт≥в;
12 Ц аванси на телекомун≥кац≥њ;
14 Ц аванси на маркетинг та рекламу;
25 - передоплата за комунальн≥ послуги
*/
begin
  for k in (select a.ROWID RI , a.KF    from accounts a
            where a.dazs is null and a.tip <> 'XOZ' and a.nbs = '3500' and ob22 in ('03','04','05','08','09','11','12','14','25')
           )
  loop bc.go (k.KF); update accounts set tip ='XOZ' where rowid = k.RI; end loop;
  suda;

end ;
/
commit;

begin  suda;
 
   insert into NBS_TIPS ( NBS , TIP)
   select distinct substr (deb,1,4), 'XOZ'
   from xoz_ob22_cl  x
   where not exists (select 1 from NBS_TIPS where  NBS=substr (deb,1,4) and  TIP='XOZ');

exception when others then  if SQLCODE = -00001 then null;   else raise; end if; 
end;
/
commit;

exec bpa.alter_policy_info( 'XOZ_REF', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'XOZ_REF', 'FILIAL', null, null, null, null );
exec bpa.alter_policies('XOZ_REF'); 

alter table bars.xoz_ref modify constraint FK_XOZREF_REF2 disable;

begin 
update bars.xoz_ref x 
      set ref2 = 0
 where ref2 is null
    and datz is not null; 
--    and (select ostc from bars.accounts a where a.acc = x.acc and a.kv = 980) = 0;
UPDATE XOZ_REF SET DATZ = CASE WHEN MDATE IS NOT NULL THEN MDATE ELSE FDAT END WHERE DATZ IS NULL AND REF2 IS NOT NULL;
UPDATE XOZ_REF SET DATZ  = NULL WHERE REF2 IS NULL AND DATZ IS NOT NULL;
UPDATE XOZ_REF SET s0 = s0*100 WHERE s0 != trunc(s0);
UPDATE XOZ_REF SET s = s0 WHERE DATZ IS NULL and (s = 0 or s is null);
end;
/
commit;   