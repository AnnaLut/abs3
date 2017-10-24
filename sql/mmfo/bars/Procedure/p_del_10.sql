

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DEL_10.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DEL_10 ***

  CREATE OR REPLACE PROCEDURE BARS.P_DEL_10 ( DAT_s varchar2, DAT_po varchar2) Is
/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
/* %%%     Выборка таблицы проводок для Делойт-аудита         %%% */
/* %%%     12-NOV-2010                                        %%% */
/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  DAT1_  date := to_date(DAT_s ,'dd-mm-yyyy');
  DAT2_  date := to_date(DAT_po,'dd-mm-yyyy');
  DAT_ZO date ;    ACCC_ int  ;  NBS_ char(4)  ;
  LCV_   char(3);  KV_   int  ;  KV1_ int := -1;
  NLS_D varchar2(14) ;
  NLS_K varchar2(14) ;
  NAZN_ varchar2(255);
  FIO_  varchar2(27) ;
  Isp_  int  := -1   ;
  ND_   varchar2(12)   ;
  NAZP_ varchar2(35) := '"Переоцiнка вiд змiни оф.курсу"';
  OSTF_ number;
  DOS_  number;
  KOS_  number;
  Q_    number;
  AUTO_ varchar2(10) := '"АВТОМАТ"';
------------------------
 Function KV_LCV ( KV_ int) return char is
   Lcv_ char(3);
 begin
        If KV_ = 980 then LCV_ := 'UAH';
     elsIf KV_ = 840 then LCV_ := 'USD';
     elsIf KV_ = 978 then LCV_ := 'EUR';
     elsIf KV_ = 959 then LCV_ := 'XAU';
     elsIf KV_ = 962 then LCV_ := 'XPT';
     elsIf KV_ = 961 then LCV_ := 'XAG';
     elsIf KV_ = 954 then LCV_ := 'XEU';
     elsIf KV_ = 960 then LCV_ := 'XDR';
     elsIf KV_ = 643 then LCV_ := 'RUB';
     elsIf KV_ = 826 then LCV_ := 'GBP';
     elsIf KV_ = 974 then LCV_ := 'BYR';
     elsIf KV_ = 398 then LCV_ := 'KZT';
     elsIf KV_ = 440 then LCV_ := 'LTL';
     elsIf KV_ = 36  then LCV_ := 'AUD';
     elsIf KV_ = 124 then LCV_ := 'CAD';
     elsIf KV_ = 752 then LCV_ := 'SEK';
     elsIf KV_ = 756 then LCV_ := 'CHF';
     elsIf KV_ = 233 then LCV_ := 'EEK';
     elsIf KV_ = 498 then LCV_ := 'MDL';
     elsIf KV_ = 985 then LCV_ := 'PLN';
     elsIf KV_ = 703 then LCV_ := 'SKK';
     else
         select lcv into LCV_ from tabval where kv=KV_;
     end if;
     return LCV_;
 end;
 --------------------------------

begin
--  tuda;

--2) очистить  таблицу для выгрузки док
  EXECUTE IMMEDIATE 'TRUNCATE TABLE Test_DEL_10';

--3) читать в курсоре проводки
  for k in (select od.ref, od.stmt, od.S, od.SQ, od.FDAT, od.txt, od.tt TTD,
                   o.VDAT, o.PDAT, o.ND, o.DATD, o.nazn, o.tt, o.USERID,
                   od.acc ACCD, ok.acc ACCK,
                   o.VOB,
-- 07-04-2010                   NVL(o.vob,6) VOB,
                   o.kv
            from oper o, opldok od, opldok ok
            where od.fdat >= DAT1_  and od.fdat<= add_months(DAT2_,2)
              and od.ref   = o.ref  and od.ref  = ok.ref and od.stmt = ok.stmt
              and od.dk    = 0      and ok.dk   = 1      and od.sos  = 5
--            order by od.FDAT, od.ref
            )
  loop
     -- обраб корр.096
-- 07-04-2010
--     If k.vob in (96,99) then DAT_ZO := k.VDAT;

     If k.tt in ('096','%%1') and k.vob in (96,99) then DAT_ZO := k.VDAT;
        If k.VDAT < DAT1_ or k.VDAT > DAT2_ then
           goto RecNext;
        end if;
     else                                                DAT_ZO := k.FDAT;
        If k.FDAT > DAT2_ then    goto RecNext; end if;
     end if;


     -- обработка закр.года
     If k.tt in ('ZG1','ZG2','ZG9') then goto RecNext; end if;


     -- внесистемных Дебет
     begin
       select nls,nbs,accc,kv into NLS_D,NBS_,ACCC_,KV_ from accounts
              where acc=k.accD;
       If NBS_ is null or NBS_  like '8%' then
         select nls,nbs into NLS_D,NBS_ from accounts where acc=ACCC_;
         If NBS_ is null or NBS_  like '8%' then  goto RecNext; end if;
       end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN goto RecNext;
     end;

     -- внесистемных Кредит
     begin
       select nls,nbs,accc into NLS_K,NBS_,ACCC_ from accounts where acc=k.accK;
       If NBS_ is null or NBS_  like '8%' then
         select nls,nbs into NLS_K,NBS_ from accounts where acc=ACCC_;
         If NBS_ is null or NBS_  like '8%' then  goto RecNext; end if;
       end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN goto RecNext;
     end;

     -- исключить обороты между транзитами ГРН ----------
--     if k.kv=980 and nls_d like '3929%' and nls_k like '3929%' then goto RecNext; end if;

     ---Сложное назн.пл-----------------
     NAZN_:= k.NAZN;
     If k.TTD<>k.TT then
       NAZN_:= substr( k.NAZN ||'/'||k.TXT, 1, 253);
     end if;
     NAZN_ := '"' || replace ( NAZN_ , '|', '/' ) || '"';

     FIO_ := '';
     IF k.userid is not null THEN
--        if k.USERID <> Isp_ and k.userid is not null then Isp_:= k.USERID;
       Isp_ := k.userid;
       begin
          select substr(fio,1,25) into FIO_ from staff where id=Isp_;
          FIO_ := '"' || replace(FIO_,'|','/') || '"' ;
       EXCEPTION WHEN NO_DATA_FOUND THEN FIO_ := AUTO_;
       end;
     END IF;

     If KV_ <> KV1_ then KV1_:= KV_;    LCV_ := KV_LCV(KV1_);  end if;

     ND_ := '"' || replace(k.ND,'|','/') || '"' ;
/*
Trans_No|Postdate|Effectdate|"Doc_NO"|Docdate|"User_ID"|DR|CR|Sysvalue|CCY|Postvalue|"Description"
*/

-- 31) вставка 1-й проводки в таблицу для выгрузки док
     insert into test_DEL_10 (TRANS_NO, POSTDATE, EFFECTDATE ,
                              DOC_NO, DOCDATE, USER_ID,
                              DR, CR, SYSVALUE, CCY, POSTVALUE, DESCRIPTION)
                   values    (k.REF || '#' || k.stmt, to_char(k.PDAT,'DD.MM.YYYY'), to_char(DAT_ZO,'DD.MM.YYYY'),
                              ND_, to_char(k.DATD,'DD.MM.YYYY'), FIO_,
                              NLS_D, NLS_K, k.SQ/100, LCV_, k.S/100, NAZN_ );
     commit;
     --------------------
     <<RecNext>> null;
  end loop;
--  commit;
  ---------------------------

  for k in (select kv,acc,nls from accounts where kv<>gl.baseval
              and (DAZS IS NULL or daZs >=DAT1_ ) and nbs not like '8%' )
  loop
--     for b in (select to_char(FDAT,'dd.mm.yyyy') fdat,dos,kos from saldob
     for b in (select fdat,dos,kos from saldob
               where acc=k.ACC and fdat >= DAT1_ and fdat <= DAT2_)
     loop
        begin
          select gl.p_icurval(k.KV,dos,b.FDAT),
                 gl.p_icurval(k.KV,kos,b.FDAT)
          into DOS_, KOS_
          from saldoa where acc=k.ACC and fdat=b.FDAT;
        EXCEPTION WHEN NO_DATA_FOUND THEN DOS_:=0; KOS_:=0;
        end;

        If k.KV <> KV1_ then kv1_:=k.KV;  LCV_ := KV_LCV(KV1_); end if;
        ND_ :=  '"' || to_char(k.ACC) || '"';
        If b.DOS>DOS_ then Q_:= b.DOS-DOS_ ;
           --вставка в таблицу-----------------
           insert into test_DEL_10 (TRANS_NO, POSTDATE, EFFECTDATE, DOC_NO, DOCDATE, USER_ID,
                                    DR, CR  , SYSVALUE, CCY       , POSTVALUE  , DESCRIPTION )
                            values (k.ACC ||'#'|| b.FDAT, b.FDAT, b.FDAT , ND_ ,  b.FDAT, AUTO_ ,
                                    k.NLS, null, Q_/100 , LCV_, 0   , NAZP_ );
        end if;

        If b.KOS>KOS_ then Q_:= b.KOS-KOS_ ;
           --вставка в таблицу-----------------
           insert into test_DEL_10 (TRANS_NO, POSTDATE, EFFECTDATE, DOC_NO, DOCDATE, USER_ID,
                                    CR,  DR , SYSVALUE, CCY       , POSTVALUE  , DESCRIPTION )
                            values (k.ACC ||'#'|| b.FDAT, b.FDAT, b.FDAT , ND_, b.FDAT, AUTO_ ,
                                    k.NLS, null, Q_/100 , LCV_  , 0, NAZP_ );
        end if;

        commit;

     END LOOP;
  end loop;

  COMMIT;

end p_DEL_10;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DEL_10.sql =========*** End *** 
PROMPT ===================================================================================== 
