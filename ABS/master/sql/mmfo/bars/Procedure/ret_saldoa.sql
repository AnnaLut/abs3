

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RET_SALDOA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RET_SALDOA ***

  CREATE OR REPLACE PROCEDURE BARS.RET_SALDOA ( p_MFO varchar2, p_DAT date) is

  branch_ varchar2(30) := '/'|| p_MFO || '/' ;
  nTmp_   int;
  DAT0_   varchar2 (35);
begin

  bars_context.subst_branch(branch_);
  DAT0_ := 'to_date(''01-01-'|| to_char(p_DAT,'YYYY')||''',''dd-mm-yyyy'')';

  ---- ==== 1 ) Подготовка =====
  --Исходная таблица S6_OBNLS, которую Боря импортит из СКАРБА.
  --Умножить все суммы на 100 .  S6_OBNLS не д.б. копеек !!
  begin
    select 1 into nTmp_ from s6_obnls
    where (mod(dos,1)   <> 0 or mod(kos,1)   <> 0 or
           mod(dos_v,1) <> 0 or mod(kos_v,1) <> 0 )
      and rownum=1;
    Update S6_OBNLS
       set dos=dos*100, kos=kos*100, dos_v=dos_v*100, kos_v=kos_v*100;
  EXCEPTION WHEN NO_DATA_FOUND THEN   null;
  end;

  -- создать железные копии
  begin
    EXECUTE IMMEDIATE 'create table TEST_SALDOA as select * from saldoA ';
  exception  when others then
    --ORA-00955: имя уже задействовано для существующего объекта
    if sqlcode = -00955 then null; else raise; end if;
  end;
  begin
    EXECUTE IMMEDIATE 'create table TEST_SALDOB as select * from saldoB ';
  exception  when others then
    --ORA-00955: имя уже задействовано для существующего объекта
    if sqlcode = -00955 then null; else raise; end if;
  end;

  --построть индекс на скарбовской таблице
  begin
    EXECUTE IMMEDIATE 'drop INDEX UI_S6OBNLS ';
  exception  when others then
    -- ORA-01418: заданного индекса не существует
    if sqlcode = -01418 then null; else raise; end if;
  end;
  EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX UI_S6OBNLS ON S6_OBNLS (NLS,I_VA,DA)';

  ---- ==== 2 ) SALDOA =====

  --построить табл TEST_ACC_A -аналог SALDOA (без вх.остатка);
  begin
    EXECUTE IMMEDIATE 'drop table TEST_ACC_A';
  exception  when others then
    --ORA-00942: таблица или представление пользователя не существует
    if sqlcode = -00942 then null; else raise; end if;
  end;

  EXECUTE IMMEDIATE
'create table TEST_ACC_A as
 select a.acc, s.DA FDAT, 0 OSTF, ' || p_MFO || ' KF,
   decode(s.I_VA, 980,s.DOS,s.DOS_V) DOS,
   decode(s.I_VA, 980, s.KOS, s.KOS_V )  KOS
 from accounts a, S6_OBNLS s
 where a.kv=s.I_VA and substr(a.nls,1,4)||substr(a.nls,6,9)=s.nls
   and (a.kv =980 or s.DOS_V <>0 or s.KOS_V <>0)
   and s.DA > '|| DAT0_ || '
 union all
 select acc,  '|| DAT0_ || ', 0 , ' || p_MFO || ' ,0,0
 from accounts where daos < '|| DAT0_ ;

  --индекс TEST_ACC_A
  EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX UI_TESTACC_A ON TEST_ACC_A (acc,fdat)';

  --удалить из SALDOA плохую истоию
  delete from saldoa where fdat <= p_DAT;
  commit;

  --добавить вх.остаток SALDOA
  EXECUTE IMMEDIATE
 'declare
    OSTF_ number; dos_ number; kos_ number;
  begin
    for k in (select acc,ostc from accounts )
    loop
       begin
         select nvl(sum(dos),0), nvl(sum(kos) ,0) into DOS_, KOS_
         from saldoa where acc=k.acc ;
       EXCEPTION WHEN NO_DATA_FOUND THEN dos_:=0; kos_:=0;
       end;
       OSTF_:= k.OSTC +dos_ -kos_;

       for p in (select * from TEST_ACC_A where acc=k.acc order by fdat desc)
       loop
          OSTF_ := OSTF_ + p.dos - p.kos;
          update TEST_ACC_A set ostf = OSTF_ where acc=k.acc and fdat=p.FDAT;
       end loop;
    end loop;

    insert into saldoa (acc,fdat, ostf,dos,kos, kf)
    select acc,fdat, ostf,dos,kos, kf from TEST_ACC_A;

    delete from saldoa
    where fdat<' || DAT0_ || ' and ostf=0 and dos=0 and kos=0;

  end ;' ;

  insert into fdat(fdat)
  select FDAT
  from (select distinct FDAT from saldoa ) s
  where s.FDAT not in (select fdat from fdat);

  ---- ==== 3) SALDOB=====
  --построить табл TEST_ACC_B -аналог SALDOB (без вх.остатка);
  begin
    EXECUTE IMMEDIATE 'drop table TEST_ACC_B';
  exception  when others then
    --ORA-00942: таблица или представление пользователя не существует
    if sqlcode = -00942 then null; else raise; end if;
  end;

  EXECUTE IMMEDIATE
'create table TEST_ACC_B as
 select a.acc, s.DA FDAT, 0 OSTF, ' || p_MFO || ' KF, s.DOS, s.KOS
 from accounts a, S6_OBNLS s
 where a.kv=s.I_VA and substr(a.nls,1,4)||substr(a.nls,6,9)=s.nls
   and a.kv <>980  and s.DA > '|| DAT0_ || '
 union all
 select acc,  '|| DAT0_ || ', 0 , ' || p_MFO || ' ,0,0
 from accounts where kv<>980 and daos < '|| DAT0_ ;

  --индекс TEST_ACC_B
  EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX UI_TESTACC_B ON TEST_ACC_B (acc,fdat)';

  --удалить из SALDOB плохую истоию
  delete from saldoB where fdat <= p_DAT;
  commit;

  --добавить вх.остаток SALDOB
  EXECUTE IMMEDIATE
'declare
   OSTF_ number; dos_ number; kos_ number;
 begin
   for k in (select acc,kv, nls, pos,
                    gl.p_icurval(kv,fost(acc,gl.BD),gl.BD) ostc
             from accounts where kv<>980 )
   loop
      If k.pos =2 then
         begin
           select ish*100 into OSTF_ from s6_saldo
           where i_va=k.kv and nls=substr(k.nls,1,4) || substr(k.nls,6,9) ;
         EXCEPTION WHEN NO_DATA_FOUND THEN ostf_:=0;
         end;
      else                     OSTF_:= k.OSTC ;
      end if;

      for p in (select * from TEST_ACC_B where acc=k.acc order by fdat desc)
      loop
         OSTF_ := OSTF_ + p.dos - p.kos;
         update TEST_ACC_B set ostf = OSTF_ where acc=k.acc and fdat=p.FDAT;
      end loop;
   end loop;

    insert into saldoB (acc,fdat, ostf,dos,kos, kf)
    select acc,fdat, ostf,dos,kos, kf from TEST_ACC_B;

    delete from saldoB
    where fdat<' || DAT0_ || ' and ostf=0 and dos=0 and kos=0;

  end ;' ;

  commit;

  --убрать 6204 в валюте навсегда
  delete from saldob where acc in
         (select acc from accounts where kv<>980 and nbs='6204');
  commit;


  -- опустить вешалки на нужную глубину
  --(минимум до начала мес, а можно и до начала года )
  EXECUTE IMMEDIATE
'declare
   DEL_ number;
 begin
   for F in (select fdat from fdat where fdat>=' || P_DAT || ' order by fdat)
   loop
      for T in (select acc, kv from test_ve)
      loop
         select  -nvl(sum(fostq(acc,F.fdat)),0) into DEL_
         from accounts  where nbs<''8000'' and kv=T.kv and acc<>T.acc;
         insert into saldob (acc,  fdat, ostf,dos,kos, kf     )
                values   (T.acc,F.fdat, DEL_,0  ,0  ,' || p_MFO || ');
      end loop;
   end loop;
 end ;' ;

 commit;

 bc.set_context;

end ret_SALDOA ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RET_SALDOA.sql =========*** End **
PROMPT ===================================================================================== 
