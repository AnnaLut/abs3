
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bm_cnt.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BM_CNT IS   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1/ 20.09.2017';
  ----------------------------------------------------------------------
  function  NVAL   (p_val varchar2) return number ;
  function  KVAL   (p_kv int, p_val varchar2) return varchar2 ;

  PROCEDURE PUL_BM (p_dat date, p_acc number, p_kod varchar2,  p_s int ) ;  -- установка пул-переменных
  PROCEDURE OST_BM (p_dat date, p_acc number, p_kod varchar2,  p_s int ) ;  -- ручной ввод остатков
  PROCEDURE STO_BM (p_dat date, p_acc number, p_kod varchar2,  p_s int ) ;  -- стартовое накопление оборотов
  PROCEDURE ALL_BM (p_dat date, p_acc number, p_kod varchar2,  p_s int ) ;  -- формирование всех остатков
  PROCEDURE ADD_BM (p_dat date, p_acc number, p_kod varchar2,  p_s int ) ;  -- Добавка нового текущего дня


function header_version return varchar2;
function body_version   return varchar2;
-------------------

END BM_CNT ;
/
CREATE OR REPLACE PACKAGE BODY BARS.BM_CNT IS   G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=   'ver.1.1 07.11.2017';
/*
07/11/2017 LitvinSO Обчисление исходящего остатка, не всегда дата за вчера по счету могла быть, поэтому ищу предыдущую запись
01.11.2017 Sta Накопление за выходные дни
26.09.2017 Sta Пересчет остатков в ежедневной процендуре
*/
-----------------------------------------------------------------
  k100 int;
  bm BM_count%rowtype ;

  ----------превращение симв.доп рекв в число ------------------------------------------------
  function  NVAL   (p_val varchar2) return number             is   n_val int ;
  begin     begin n_val  := to_number(p_val);
            exception when others then  n_val := 1;  ----- if sqlcode = -01722 then n_val := 1; else raise; end if;
            end;  -- ORA-01722: invalid number
            RETURN n_val ;
  end nval;

  --------- превращение симв.доп рекв в числовой код изделия ---------------------------
  function  KVAL   (p_kv int, p_val varchar2) return varchar2 IS   l_kod  varchar2(3) ;
  begin     If    p_val ='Замасковано' and p_kv = 959 then l_kod := '328';
            elsIf p_val ='Замасковано' and p_kv = 961 then l_kod := '321';
            else                                           l_kod := substr( p_val,1,3);
            end if;
            RETURN l_kod ;
  end KVAL;

  --------- установка пул-переменных ------------------------------
  PROCEDURE PUL_BM ( p_dat date, p_acc number, p_kod varchar2,  p_s int ) is
  BEGIN     PUL.PUT('DAT_BM', to_char( p_dat,'dd/mm/yyyy') );
            PUL.PUT('NLS_BM', p_kod) ;
  end       PUL_BM ;

  --------- ручной ввод остатков ----------------------------
  PROCEDURE OST_BM ( p_dat date, p_acc number, p_kod varchar2,  p_s int ) is
  begin     update BM_count set c_INP = p_S, C_Out = p_S + DOS0 + dos1- KOS0-kos1 where acc = p_acc and kod = p_kod and fdat = p_dat ;
            IF SQL%ROWCOUNT = 0 THEN  insert into BM_COUNT ( acc,kod,fdat,dos0,dos1,kos1,kos0,C_Inp,C_Out ) values (p_acc, p_kod, p_dat,0,0,0,0,p_s, p_s); end if ;
  end       OST_BM ;

  --------- стартовое накопление оборотов ----------------------------
  PROCEDURE STO_BM ( p_dat date, p_acc number, p_kod varchar2,  p_s int ) is
  begin  bm.FDAT := to_date ('01-04-2017','dd-mm-yyyy') ;

     FOR K IN  (select * from accounts where nbs in ('1101','1102') and dazs is null and dapp >= bm.FDAT and p_acc in ( 0, acc ) )
     LOOP delete from BM_COUNT  where acc = k.acc;
          insert into BM_COUNT ( acc, kod , fdat, dos0, dos1, kos1 , kos0 ) --,C_Inp ,  C_Out)
                         select K.acc, koD, fdat, Sum (CASE WHEN tt<>'TIK' and dk=0 THEN kol ELSE 0 END)    "Оприбутковано",
                                                  Sum (CASE WHEN tt ='TIK' and dk=0 THEN kol ELSE 0 END)    "Куплено",
                                                  Sum (CASE WHEN tt ='TMP' and dk=1 THEN kol ELSE 0 END)    "Продано",
                                                  Sum (CASE WHEN tt<>'TMP' and dk=1 THEN kol ELSE 0 END)    "Здано"
                         from (  select TRUNC (p.pdat) fdat,  p.tt, s.dk,
                                        (select BM_CNT.NVAL      (value) from operw where ref = p.ref and tag = 'BM__K') kol ,
                                        (select BM_CNT.KVAL (k.kv,value) from operw where ref = p.ref and tag = 'BM__C') KOD
                                 from oper p,
                                      (select o.ref, o.dk from saldoa f, opldok o where f.acc=K.ACC and f.fdat >= bm.FDAT and o.acc =f.acc and f.fdat = o.fdat) s
                                 where s.ref = p.ref
                               )
                         group by kod, fdat ;
     end loop ;

     FOR K IN  (select * from accounts where nbs ='9819' and ob22 in ('H0','H1','H2','H3','H4') and kv = 980 and dazs is null and dapp >= bm.FDAT and p_acc in ( 0, acc ) )
     LOOP delete from BM_COUNT  where acc = k.acc;

          If    k.ob22 ='H0' then k100 :=  100 ; bm.kod := 527 ;  --срібло, 1 гривня
          ElsIf k.ob22 ='H1' then k100 :=  200 ; bm.kod := 651 ;  --золото,2 гривень
          ElsIf k.ob22 ='H2' then k100 :=  500 ; bm.kod := 528 ;  --золото,5 гривень
          ElsIf k.ob22 ='H3' then k100 := 1000 ; bm.kod := 650 ;  --золото,10 гривень
          ElsIf k.ob22 ='H4' then k100 := 2000 ; bm.kod := 636 ;  --золото,20 гривень
          end if ;
          insert into BM_COUNT ( acc,   kod , fdat, dos0, dos1, kos1 , kos0 ) --,C_Inp ,  C_Out)
                         select K.acc, bm.koD, fdat, Sum (CASE WHEN tt <> 'TTI' and dk=0 THEN kol ELSE 0 END)    "Оприбутковано",
                                                     0, -----  Sum (CASE WHEN tt =  'TIK' and dk=0 THEN kol ELSE 0 END)    "Куплено",
                                                     Sum (CASE WHEN tt =  'TTI' and dk=1 THEN kol ELSE 0 END)    "Продано",
                                                     Sum (CASE WHEN tt <> 'TTI' and dk=1 THEN kol ELSE 0 END)    "Здано"
                         from (  select TRUNC (p.pdat) fdat,  p.tt, s.dk, s.KOL
                                 from oper p,   (select o.ref, o.dk, o.s/k100 KOL  from saldoa f, opldok o where f.acc=K.ACC and f.fdat >= bm.FDAT and o.acc =f.acc and f.fdat = o.fdat) s
                                 where s.ref = p.ref
                               )
                         group by fdat ;
     end loop ;

  end STO_BM  ;

  --------- формирование всех остатков -----------------------------
  PROCEDURE ALL_BM (p_dat date, p_acc number, p_kod varchar2,  p_s int ) is
  begin  BM.FDAT := To_date( PUL.GET('DAT_BM') , 'dd.mm.yyyy') ;
     for k in (select x.* from BM_COUNT x, accounts a  where a.nls = PUL.GET('NLS_BM') and a.acc = x.acc and fdat = bm.FDAT and c_OUT is not null )
     loop
       update BM_COUNT x set c_OUT= k.c_OUT- (select NVL(Sum(dos0+dos1-kos0-kos1),0) from BM_COUNT where ACC=x.ACC and kod=x.KOD and fdat<=BM.FDAT and fdat >x.fdat) where acc=k.ACC and kod=k.KOD and fdat<BM.FDAT;
       update BM_COUNT x set c_OUT= k.c_OUT+ (select NVL(Sum(dos0+dos1-kos0-kos1),0) from BM_COUNT where ACC=x.ACC and kod=x.KOD and fdat> BM.FDAT and fdat<=x.fdat) where acc=k.ACC and kod=k.KOD and fdat>BM.FDAT;
       update BM_COUNT x set c_inp= c_out +kos0 +kos1 - dos0-dos1 where acc = k.ACC and kod = k.KOD;
    end loop ;
  end ALL_BM ;

  --------- Добавка нового текущего дня ------------------------------
  PROCEDURE ADD_BM (p_dat date, p_acc number, p_kod varchar2,  p_s int ) is
  begin  If sysdate < trunc(sysdate) + 1/4 then RETURN; end if;
         BM.FDAT := NVL( p_dat, trunc (sysdate) ) ;

     If LengtH( sys_context('bars_context','user_branch') ) > 1 then
        delete                        from BM_COUNT where fdat >= BM.FDAT and acc in (select acc from accounts)  ;  -- удалить все за "сегодня" и более
        select max(fdat) into BM.FDAT from BM_COUNT where                     acc in (select acc from accounts)  ; -- найти "вчера"
     else
        delete from BM_COUNT where fdat >= BM.FDAT  ;  -- удалить все за "сегодня" и более
        select max(fdat) into BM.FDAT from BM_COUNT ; -- найти "вчера"
     end if;

     FOR K IN  (select * from accounts where nbs in ('1101','1102') and dazs is null and dapp > bm.FDAT  )
     loop  for xx in (select koD, fdat, Sum (CASE WHEN tt<>'TIK' and dk=0 THEN kol ELSE 0 END) dos0, ---- "Оприбутковано",
                             Sum (CASE WHEN tt ='TIK' and dk=0 THEN kol ELSE 0 END) dos1, ---- "Куплено",
                             Sum (CASE WHEN tt ='TMP' and dk=1 THEN kol ELSE 0 END) kos1, ---- "Продано",
                             Sum (CASE WHEN tt<>'TMP' and dk=1 THEN kol ELSE 0 END) kos0  ----  "Здано"
                      from (select trunc(p.pdat) fdat,  p.tt, s.dk,
                                   (select BM_CNT.NVAL      (value) from operw where ref = p.ref and tag = 'BM__K') kol ,
                                   (select BM_CNT.KVAL (k.kv,value) from operw where ref = p.ref and tag = 'BM__C') KOD
                             from oper p,  (select o.ref, o.dk from saldoa f, opldok o where f.acc=K.ACC and f.fdat > bm.FDAT and o.acc =f.acc and f.fdat = o.fdat) s  where s.ref = p.ref)
                             group by kod, fdat )
           loop  begin  insert into BM_COUNT (acc,kod,fdat,dos0,dos1,kos1,kos0) values (K.acc, xx.kod, xx.fdat, xx.dos0, xx.dos1, xx.kos1, xx.kos0);
                 exception when others then   if SQLCODE = - 00001 then null;   else raise; end if;   -- ORA-00001:unique constraint (BARS.XPK_BMCOUNT) violated
                 end;
           end loop ; --- xx
     end loop ;  -- K

     FOR K IN  (select * from accounts where nbs ='9819' and ob22 in ('H0','H1','H2','H3','H4') and kv = 980 and dazs is null and dapp > bm.FDAT )
     LOOP  If    k.ob22 ='H0' then k100 :=  100 ; bm.kod := 527 ;   --срібло, 1 гривня
           ElsIf k.ob22 ='H1' then k100 :=  200 ; bm.kod := 651 ;   --золото,2 гривень
           ElsIf k.ob22 ='H2' then k100 :=  500 ; bm.kod := 528 ;   --золото,5 гривень
           ElsIf k.ob22 ='H3' then k100 := 1000 ; bm.kod := 650 ;   --золото,10 гривень
           ElsIf k.ob22 ='H4' then k100 := 2000 ; bm.kod := 636 ;   --золото,20 гривень
           end if ;
           for xx in ( select fdat, Sum (CASE WHEN tt <> 'TTI' and dk=0 THEN kol ELSE 0 END) dos0, ---  "Оприбутковано",
                                    0 dos1, ---
----------------------------------  Sum (CASE WHEN tt =  'TIK' and dk=0 THEN kol ELSE 0 END) dos1, ---  "Куплено",
                                    Sum (CASE WHEN tt =  'TTI' and dk=1 THEN kol ELSE 0 END) kos1, ---   "Продано",
                                    Sum (CASE WHEN tt <> 'TTI' and dk=1 THEN kol ELSE 0 END) kos0  ---   "Здано"
                       from (select TRUNC (p.pdat) fdat,  p.tt, s.dk, s.KOL
                             from oper p, (select o.ref, o.dk, o.s/k100 KOL  from saldoa f, opldok o where f.acc=K.ACC and f.fdat >= bm.FDAT and o.acc =f.acc and f.fdat = o.fdat) s  where s.ref = p.ref )
                       group by fdat )
           loop  begin  insert into BM_COUNT (acc,kod,fdat,dos0,dos1,kos1,kos0) values (K.acc, bm.koD, xx.fdat, xx.dos0, xx.dos1, xx.kos1, xx.kos0);
                 exception when others then   if SQLCODE = - 00001 then null;   else raise; end if;   -- ORA-00001:unique constraint (BARS.XPK_BMCOUNT) violated
                 end;
           end loop ; --- xx
     end loop ; -- K

     update BM_COUNT x set   c_OUT = NVL ( (select c_OUT from BM_COUNT where ACC=x.ACC and kod=x.KOD and fdat=(select max(fdat) from  BM_COUNT where  fdat <= BM.FDAT and acc= x.acc and kod = x.kod) ) ,0 )
                                   + NVL ( (select Sum(dos0+dos1-kos0-kos1) from BM_COUNT where ACC=x.ACC and kod=x.KOD and fdat>BM.FDAT and fdat<=x.fdat) ,0 )
     where x.fdat > BM.FDAT;

     update BM_COUNT x set c_inp= c_out + kos0 + kos1 - dos0 - dos1 where x.fdat > BM.FDAT;

  end ADD_BM  ;
  ----------------------------------------
function header_version return varchar2 is begin  return 'Package header BM_CNT ' || G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body   BM_CNT ' || G_BODY_VERSION  ; end body_version;

---Аномимный блок --------------
begin   null ;
END BM_CNT   ;
/
 show err;
 
PROMPT *** Create  grants  BM_CNT ***
grant EXECUTE                                                                on BM_CNT          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bm_cnt.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 