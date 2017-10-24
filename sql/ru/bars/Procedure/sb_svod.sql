

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SB_SVOD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SB_SVOD ***

  CREATE OR REPLACE PROCEDURE BARS.SB_SVOD (IDD_ int,  FDAT1_ date ) is
  ID_      NUMBER (38);       NAMEOT_  VARCHAR2 (70);
  USERID_  NUMBER (38);       PT_      VARCHAR2 (30);
  FIO_     VARCHAR2 (50);     TECH_    NUMBER (38);
  KL_      CHAR (1);          DK_      NUMBER (38);
  KV1_     NUMBER (38);       NLSB_    VARCHAR2 (15);
  FDAT_    DATE;              OTD_     VARCHAR2 (30);
  TT_      VARCHAR2 (5);      SK_      NUMBER (38);
  NAMTT_   VARCHAR2 (30);     SKK_     NUMBER (38);
  REF_     NUMBER (38);       SD_      NUMBER (38);
  STMT_    NUMBER (38);       SDD_     NUMBER (38);
  KV_      NUMBER (38);       S_       NUMBER (38);
  NLS_     VARCHAR2 (15);     SQ_      NUMBER (38);
  otbor_   int;               KAS_     NUMBER (38);
  kol_     int;               nbs3929_ varchar2(4);
 ern  CONSTANT POSITIVE := 021; erm  VARCHAR2(80); err  EXCEPTION;
/*
версии
      21-11-2008   Вариант для мультиМФО схемы
      18-12-2008   Добавила под реестр технологических
*/
begin
commit;
nbs3929_ := '0001';
begin
    SELECT VAL INTO NBS3929_ FROM PARAMS
	       WHERE UPPER(PAR)='NBS_3929';
    exception when no_data_found then null;
end;
for p in (
SELECT o.FDAT FDAT,   p.USERID USERID,   o.acc ACC, o.REF REF,
       o.S S,  P_icurval(o.kv,o.s,o.fdat) SQ,
       o.STMT STMT,   o.TT TT,o.nls NLS,o.kv KV,
       o2.nls NLSB
 FROM opl o, oper p,opl o2
 WHERE o.sos=5         and o.dk=0       and o.fdat=FDAT1_
       and o.ref=p.ref and o.ref=o2.ref and o.stmt=o2.stmt
       and o2.dk=1     and f_op_bal(o.ref,o.stmt)=1
       and substr(o.nls,1,4)<>nbs3929_
UNION ALL
SELECT  a.FDAT FDAT, -7 USERID, 0 ACC ,0 REF,
        0  S,  f_pereocD (a.kv, a.acc, a.fdat) SQ,
        0 STMT, '' TT, a.nls NLS,980 KV, to_char(a.kv) NLSB
FROM sal a
WHERE  a.fdat=FDAT1_ and  substr(a.nls,1,1)<>'9' and substr(a.nbs,1,1)<>'8'
       and f_pereocD (a.kv, a.acc, a.fdat)<>0
UNION ALL
SELECT  a.FDAT FDAT, -7 USERID, 0 ACC ,0 REF,
        0  S,  f_pereocD (a.kv, a.acc, a.fdat) SQ,
        1 STMT, '' TT, a.nls NLS, 980 KV,  to_char(a.kv) NLSB
FROM sal a
WHERE  a.fdat=FDAT1_ and  substr(a.nls,1,1)='9' and substr(a.nbs,1,1)<>'8'
       and f_pereocD (a.kv, a.acc, a.fdat)<>0
)
LOOP
ID_:=IDD_;          KV_:=0;               SK_:=0;
USERID_:=0;         NLS_:='';             SKK_:=0;
FIO_:='';           S_:=0;                SD_:=0;
KL_:='';            SQ_:=0;               SDD_:=0;
KV1_:=0;            NAMEOT_:='';
TT_:='';            PT_:='';
NAMTT_:='';         TECH_:=0;
REF_:=0;            DK_:=0;
STMT_:=0;           NLSB_:='';
OTD_:='';            KAS_:=0;
kol_:=0;
-- внебаланс-баланс
  if p.nls like '9%' or (p.ref=0 and p.stmt=1) then kl_:='9';
  else kl_:='Б';
  end if;
-- названия отделов для пользователей
  begin
--    select o.id,o.name,s.fio
--           into otd_, nameot_,fio_
--           from otdel o,otd_user u,staff s
--           where o.id=u.otd and p.userid=u.userid and u.pr=1
--           and p.userid=s.id;
     select o.branch,o.name,s.fio
     into otd_, nameot_,fio_
     from our_branch o,staff s
     where o.branch=s.branch  and p.userid=s.id;
     exception when NO_DATA_FOUND THEN
              otd_:='100';
              nameot_:='(100) Нерозподiленi';
  end;
-- название операций
  begin
    select ltrim(rtrim(substr(name,1,30)))
           into namtt_ from tts where tt=p.tt;
    exception when NO_DATA_FOUND THEN namtt_:='';
  end;
-- валюта-гривна
   kol_:=0;
   begin
     select count(*) into kol_ from opl  where ref=p.ref and kv<>980;
     exception when NO_DATA_FOUND THEN kol_:=0 ;
   end;
   if kol_=0 then KV1_:=1; ELSE KV1_:=2; end if;
-- процессинг
  for k in (select tt from tts where fli=3)
  loop
    if p.tt=k.tt then 
       otd_:='101'; nameot_:='(101)Технологiчнi';
       tech_:=-1; fio_:='Авто+процесінг';
    end if;
  end loop;
-- автопроводки  по справочнику (PVP,OVR,AA1..) и эл.клиенты
  for k in (select tt from ttsavto)
  loop
    if p.tt=k.tt  
     then otd_:='101'; nameot_:='(101)Технологiчнi';
            tech_:=-2;  fio_:='Авто+процесінг';
    end if;
  end loop;
  if p.tt in ('KL1','KL2')   
     then  otd_:='101'; nameot_:='(101) Технологiчнi';
           tech_:=-3;  -- для реестра АВТО+процессинг, в РЕЕСТР технологических - отдельной  строкой
           fio_:='Документи ел.клієнтів';   
  end if;
  if p.userid=-7 
  then otd_:='101'; nameot_:='(101)Технологiчнi';   tech_:=-4;  -- признак переоценки
       fio_:='Переоцiнка залишкiв в Iнвал';
  end if;
 --
--
-- автопроводки  по списку  а также переоценки
--  if p.tt in ('RT2','RT3','OVR','OVD','PVP','OV-','KL1','KL2','KL3','KL4')
--     or p.userid=-7  -- переоценка
--  then otd_:='101'; nameot_:='(101) Технологiчнi'; KV1_:=1;
--  end if;
--
--
-- кассовые-некассовые (для кассовых гривна-валюта)
-- 1005 кассу не считаем кассой
--
-- все приходы по всем кассам
     if p.userid<>-7 and (SUBSTR(p.nls,1,2)='10' and SUBSTR(p.nls,1,4)<>'1005' )
-- расход по кассам без дороги
		 or
 		 (substr(p.nlsb,1,2)='10' and substr(p.nlsb,1,4) not in ('1005','1007')
	      and  substr(p.nls,1,2)<>'10' )
-- расход по кассам только дорога
-- (для 1007 бывает корреспонденция: ДТ 2924   КТ 1007 - это обычный платеж - не кассовый)
		 or
	 (substr(p.nlsb,1,2)='10' and SUBSTR(p.nlsb,1,4)<>'1005' and substr(p.nls,1,4)='1007'        )
     then
         kas_:=2;       otd_:='102';        nameot_:='(102) Касовi';
         if p.kv=980    then  kv1_:=1;    else kv1_:=2;    end if;
     else kas_:=1;
     end if;

-- замена по счетам допсоглашений модуля ДЕПО ЮЛ
-- дочерних в 8-м классе на родительские не 8 класс
  begin
    select  r.nls  into nls_     from    accounts d, accounts r
    where   p.acc=d.acc   and    d.accc=r.acc
           and substr(r.nbs,1,1)<>'8';
    exception when NO_DATA_FOUND THEN nls_:=p.nls ;
  end;
  logger.info('svod=ref,s,sq='||p.ref||'='||p.s||'='||p.sq);
  insert into tmp_svod
  (ID,    USERID,   FIO,   KL,     KV1,    FDAT,    TT,    NAMTT,  REF,  STMT,
   KV,    NLS,      S,     SQ,  NAMEOT,    PT,    TECH,    DK,     NLSB, OTD,
   SK,    SKK,      SD,    SDD, KAS)
values
  (ID_,  p.USERID,  FIO_,   KL_,   KV1_,  p.FDAT, p.TT,   NAMTT_, p.REF, p.STMT,
    p.KV,  NLS_,    p.S,   p.SQ,  NAMEOT_,  PT_,   TECH_,  DK_,   p.NLSB, OTD_,
    SK_ ,   SKK_,    SD_,   SDD_  , KAS_)  ;
END LOOP;
--
------- добавим данные по ответным
--
sk_:=0; skk_:=0;  sd_:=0;  sdd_:=0;
begin
  SELECT sum(a.s),count(*)
         into sk_,skk_
  FROM arc_rrp a
  WHERE trunc(a.dat_a)=FDAT1_
           and a.MFOB=gl.aMfo
           and a.MFOA<>gl.aMfo
           and a.sos>=5
           and a.s is not null
           and a.dk=1   group by a.dk;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
end;
begin
  SELECT sum(a.s),count(*)
         into sd_,sdd_
  FROM arc_rrp a
  WHERE trunc(a.dat_a)=FDAT1_
           and a.MFOB=gl.aMfo
           and a.MFOA<>gl.aMfo
           and a.sos>=5
           and a.s is not null
           and a.dk=2 group by a.dk;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
end;
update tmp_svod set sk=sk_,skk=skk_,sd=sd_,sdd=sdd_ where id=id_;
end  SB_SVOD; 
/
show err;

PROMPT *** Create  grants  SB_SVOD ***
grant EXECUTE                                                                on SB_SVOD         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SB_SVOD         to RPBN001;
grant EXECUTE                                                                on SB_SVOD         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SB_SVOD.sql =========*** End *** =
PROMPT ===================================================================================== 
