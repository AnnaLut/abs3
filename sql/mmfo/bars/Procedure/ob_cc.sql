

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OB_CC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OB_CC ***

  CREATE OR REPLACE PROCEDURE BARS.OB_CC (DAT_ date) is
  SQ_     number;
  acc_    int;
  LIMIT_  number;
  IR_     number;
  s080_   int;
  nd_     number;
  vz_     number;
  charz_  varchar2(70);
  motive_ varchar2(70);
  S_ZAST_ number;
  wdate_  date;
  DATb_   date;
  DDAT_   date;
  KOL_    number;
  DAT1_   date;
  sdate_  DATE;
  accs_   number;


begin

  BEGIN
    DATB_:=DAT_;DDAT_:=DAT_;
    for i_ in 1..10
    LOOP
      BEGIN
        DDAT_:=DDAT_ - 1;
        select holiday into DAT1_ from holiday where kv=980 and holiday=DDAT_;
        KOL_:=KOL_+1;
        exception when NO_DATA_FOUND THEN  GOTO M1;
      end;
    END LOOP;
  END;
  <<M1>>
  deb.trace(1,'DAT_ - текущая',DAT_);
  deb.trace(1,'DDAT_- предыд.',DDAT_);
  delete from tmp_ob_cc;
  for k in ( select 'K'        PF,
                    c.okpo     OKPO,
                    c.nmk      NMK,
                    c.adr      ADR,
                    c.custtype CUSTTYPE,
                    decode(c.country, 804, 1, 2) REZ,
                    d.ND    ND,
                    ad.kv KV,
                    d.CC_ID CC_ID,
                    d.SDATE  SDATE,
                   decode(nvl(c.crisk,1),1,'А',2,'Б',3,'В',4,'Г',5,'Д') FIN,
                   d.WDATE WDATE,ai.name AIM, ad.accs ACCS, a.tip TIP,
                   a.nbs NBS,a.nls NLS,s.DOS DOS,c.rnk RNK,ad.accs ACC_O
          from cc_deal D,customer C,cc_add AD,cc_aim AI,cc_vidd V,
               accounts A, saldoa s
          where d.sos>9 and d.sos <15 and c.rnk=d.rnk and a.acc=ad.accs and
                d.nd  =ad.nd  and ad.adds=0 and ad.aim=ai.aim (+) and
                d.vidd=v.vidd and v.tipd =1 and ad.accs is not null
                and a.acc=s.acc and s.fdat=DDAT_ and s.dos>0 and
                c.custtype in (2,3) and a.nbs<>2202
     union all
     select 'O',
            c.okpo,
            c.nmk,
            c.adr,
            c.custtype,
            decode(c.country, 804, 1, 2),
            o.ND   ,
            a.kv,
            o.nDOC,
---            o.DATD,
            a.daos,
            decode(nvl(c.crisk,1),1,'А',2,'Б',3,'В',4,'Г',5,'Д'),
            o.DATD2,
            'Овердрафт',
            o.acco,
            a.tip, a.nbs,a.nls,s.DOS,c.rnk,o.acc
     from acc_over O,customer C, accounts A, saldoa s,cust_acc U
     where U.acc=o.acco and  c.rnk=u.rnk and a.acc=o.acco and
           a.acc=s.acc and s.fdat=DDAT_ and s.dos>0 and
           c.custtype in (2,3)
         )
  loop
    IF k.nbs=2202 and k.PF='O' then
       ACCS_:=k.acc_o;
    else
       ACCS_:=k.accs;
    END IF;
    WDATE_:=k.wdate;
    IF k.PF='K' THEN
       BEGIN
         select a.acc INTO acc_ from nd_acc n, accounts a
         where n.acc=a.acc and n.nd=k.nd and a.nbs='8999' and a.ostb<>0;
         EXCEPTION WHEN NO_DATA_FOUND THEN ACC_:=k.accs;
       END;
    end if;

    BEGIN
      -- вид залога
      select pb.S031 INTO VZ_ from cc_pawn pb,cc_accp p
      where p.pawn=pb.pawn and p.accs=k.accs and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN VZ_:=90;
    END;
    BEGIN
      -- Ринкова вартiсть застави
      SELECT Sum(rez.CA_FQ_ZALOG( a.ACC, DDAT_)) INTO S_ZAST_
      FROM accounts a, nd_acc n
      WHERE a.acc=n.acc and a.tip in ('SS ','SL ','SP ') and
          n.nd=k.nd;
      EXCEPTION WHEN NO_DATA_FOUND THEN S_ZAST_:=0;
    END;

    BEGIN
      -- Краткая характеристика залога
      select substr(txt,1,70) INTO CHARZ_ from nd_txt
      where nd=k.nd and ltrim(TAG)='PAWN';
      EXCEPTION WHEN NO_DATA_FOUND THEN CHARZ_:='000';
    END;

    BEGIN

    IF k.nbs=2202 and k.PF='O' then
       MOTIVE_:='Платiжнi картки';
    ELSE
       -- Пiдстава надання кредиту
       select substr(txt,1,70) INTO MOTIVE_ from nd_txt
       where nd=k.nd and ltrim(TAG)='AUTOR';
    END IF;

    EXCEPTION WHEN NO_DATA_FOUND THEN MOTIVE_:='Не заповнено';
    END;

--  BEGIN
      --выдaно кредита
--    select gl.p_icurval(k.kv, ostf-dos+kos , DDAT_) into SQ_ from saldoa
--    where acc=acc_ and
--          (acc_,fdat)=(select acc, max(fdat) from saldoa
--                      where acc=acc_ and fdat<=DDAT_ group by acc) ;
--    EXCEPTION WHEN NO_DATA_FOUND THEN SQ_:=0;
--  END;

    BEGIN
        --сумма кредита(лимита) по договору
      LIMIT_:=0;
      IF k.PF='K' and k.nbs<>2202 then
        BEGIN
          select lim2 into LIMIT_ from cc_lim where nd=k.nd and
                 (k.nd,fdat)=(select nd,max(fdat) from cc_lim
          where nd=k.nd and fdat<=DDAT_ group by nd );
          EXCEPTION WHEN NO_DATA_FOUND THEN
          BEGIN
            select lim into LIMIT_ from accounts where acc=accs_;
            EXCEPTION WHEN NO_DATA_FOUND THEN LIMIT_:=0;
          END;
        END;
      END IF;
      IF k.PF='O' or (k.PF='K' and k.nbs=2202) then
        BEGIN
          select lim into LIMIT_ from accounts where acc=accs_;
          EXCEPTION WHEN NO_DATA_FOUND THEN LIMIT_:=0;
        END;
      END IF;
    END ;

    --    if LIMIT_ > 0 then
    BEGIN
      --% ставка
      select ir into IR_ from int_ratn where acc=acc_ and id=0 and
             (acc_,0,bdat)=(select acc,id,max(bdat) from int_ratn
      where acc=acc_ and id=0 and bdat<=DDAT_
      group by acc, id);
      EXCEPTION WHEN NO_DATA_FOUND THEN IR_:=acrn.fproc(k.accs,DDAT_);
    END;
    --    END iF;

    IF IR_=0 then
       IR_:=acrn.fproc(k.accs,DDAT_);
    END IF;

    BEGIN
      select to_number(nvl(s080,'1')) into s080_
      from specparam where acc=acc_;
      EXCEPTION WHEN NO_DATA_FOUND THEN S080_:=1;
    END;

    IF k.nd=0 or k.nd is NULL then
       ND_:=k.rnk;
    else
       ND_:=k.nd;
    END IF;

    if vz_=0 then
       VZ_:=90;
    END IF;

    if wdate_ is null then
       WDATE_:=trunc(add_months(DDAT_,1),'MON')+24;
    END IF;

    if k.sdate is null then
       SDATE_:=DDAT_;
    else
       SDATE_:=k.sdate;
    END IF;

    IF S_ZAST_ is NULL then
       S_ZAST_:=0;
    END IF;

    if k.NBS<>2625 then
       insert into tmp_ob_cc
         ( mfo,okpo,nmk,adr,custtype,rez,event_type,event_date,
           nd,kv,cc_id,sdate,limit,fin,wdate,aim,s,ir,s080,vz,
           charz,S_ZAST,motive,nls )
       values
         ( to_number(gl.AMFO),NVL(trim(substr(k.okpo ,1,14)),'Не заповнено'),
         NVL(trim(substr(k.nmk,1,70)),'Не заповнено'),
         NVL(trim(substr(k.adr,1,70)),'Не заповнено'),
         decode(k.CUSTTYPE,3,0,1),k.rez,1,DDAT_,ND_,
         NVL(trim (k.kv),'Не заповнено'),
         NVL(trim(substr(k.cc_id,1,16)),k.rnk),
         SDATE_,LIMIT_,NVL(trim(k.fin),'Не заповнено'),
         WDATE_,NVL(trim(substr(k.aim  ,1,70)),'Не заповнено'),
         k.DOS,IR_,s080_,vz_,charz_,S_ZAST_,motive_ ,k.nls );
     end if;
  end loop;

end ob_cc;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OB_CC.sql =========*** End *** ===
PROMPT ===================================================================================== 
