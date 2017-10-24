

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RET_O.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RET_O ***

  CREATE OR REPLACE PROCEDURE BARS.RET_O ( DAT_ date) IS

 -- 28.10.2009  --Проверено на житом.БД
 --сделать OPER+OPLDOK из СКАРБА-6 за одну дату

 accd_ int   ;
 acck_ int   ;
 Ref_ int    ;
 TT_ char(3) :='МГР';
 VOB_ int    ;
 S_ number   ;
 Q_ number   ;
 MFOB_ varchar2(12) :='*';  MFOA_ varchar2(12) :='*';
 -------------
begin

--  logger.info ('RET_O beg DAT='||DAT_);
  --1) Создать дату в Fdat
    update fdat set stat=1 where fdat=DAT_;
    if SQL%rowcount=0  then
       insert into fdat (fdat, stat) values (DAT_,1);
    end if;

 --Часть 1 OPLDOK
 for k in (select id_oper ID,
                  DA      VDAT, -- дата валют oper.VDAT
                  DA_OD       ,
                  DA_FACT PDAT,
                  ROWID   RI,
                  nd      ND,
                  to_char(kb_a)    MFOA,
                  KK_A    NLSA,
                  to_char(KB_B)    MFOB,
                  KK_B    NLSB,
                  D_K     DK,
                  SUMMA*100   S,
                  I_VA    KV,
                  DA_DOC  DATD,
                  substr(NK_A,1,38)    NAM_A,
                  substr(NK_B,1,38)    NAM_B,
                  NP      NAZN,
                  KOD_A   ID_A,
                  KOD_B   ID_B,
                  substr(DB_S,1,4)||'_'||substr(DB_S,5,9)    DEB,
                  substr(KR_S,1,4)||'_'||substr(KR_s,5,9)    KRD,
                  DA_MB   FDAT, -- факт.дата opldok.FDAT
                  DA_REC  DATP,
                  CUR_VS  CURS
            from S6_DOCUM_Y
            where  DA_MB = DAT_ and  STATUS in (1,5)
                )
 loop
    begin
       select acc into accd_ from accounts where nls like k.deb and kv=k.kv;
       select acc into acck_ from accounts where nls like k.krd and kv=k.kv;
    EXCEPTION WHEN NO_DATA_FOUND THEN  GOTO nexrec;
    end;

    if    k.kv=980       then S_:= k.S ; q_:= k.S  ;
    elsIf k.CURS >0      then S_:= k.S ; q_:= round(k.S*k.CURS,0);
    else                      S_:= 0   ; Q_:= k.S  ;
    end if;

--  метал берем 2 знака !!
--    if k.kv in (959,961) then S_:=S_*10; Q_:= Q_*10;  end if;

    update S6_DOCUM_Y set STATUS= 6 where rowid=k.RI;

    gl.REF (ref_);
    --Корр.обороты
    If to_char(k.VDAT,'YYYYMM') < to_char(k.FDAT,'YYYYMM') and
       to_number(to_char(k.FDAT,'DD'))   < 10              and
       to_number(to_char(k.VDAT,'DD'))   > 25              then
       VOB_:=96;
    else
       Vob_:=6;
    end if;

    -- запись МФОА и  МФОБ в свои поля
    insert into oper (
      REF   , DEAL_TAG,  TT   ,VOB   ,  ND  ,  VDAT ,  KV  ,  DK  , S    ,
      DATD  , DATP    ,NAM_A  ,NLSA  ,  MFOA,NAM_B  , NLSB ,  MFOB,  NAZN,
      ID_A  , ID_B    , SOS   , pdat)
    values (
      REF_  , k.ID    ,  TT_  ,VOB_  ,k.ND  ,k.VDAT ,k.KV  ,k.DK  ,S_    ,
      k.DATD, k.DATP  ,
      k.NAM_A,k.NLSA, k.mfoa,
      k.NAM_B,k.NLSB, k.mfob,
      k.NAZN,
      k.ID_A, k.ID_B  , 5    , k.PDAT) ;


/*
    -- запись МФОА и  МФОБ в поля наименований из-за отсутствия в BANKS
    insert into oper (
      REF   , DEAL_TAG,  TT   ,VOB   ,  ND  ,  VDAT ,  KV  ,  DK  , S    ,
      DATD  , DATP    ,NAM_A  ,NLSA  ,  MFOA,NAM_B  , NLSB ,  MFOB,  NAZN,
      ID_A  , ID_B    , SOS   , pdat)
    values (
      REF_  , k.ID    ,  TT_  ,VOB_  ,k.ND  ,k.VDAT ,k.KV  ,k.DK  ,S_    ,
      k.DATD, k.DATP  ,
      substr(k.mfoa||'/'||k.NAM_A,1,38),k.NLSA, gl.aMFO,
      substr(k.mfob||'/'||k.NAM_B,1,38),k.NLSB, gl.amfo,
      k.NAZN,
      k.ID_A, k.ID_B  , 5    , k.PDAT) ;
*/

    -- платежнуе документы
    If k.DK<2 then
       insert into opldok(REF,TT,DK,ACC,FDAT,S,SQ,STMt,SOS) values
          (ref_, tt_,0, accd_, k.FDAT, S_, q_, 0, 5 );
       insert into opldok(REF,TT,DK,ACC,FDAT,S,SQ,STMt,SOS) values
          (ref_, tt_,1, acck_, k.FDAT, S_, q_, 0, 5 );
    end if;

    -----------------------
    <<nexrec>> null;

 end loop;

 logger.info ('RET_O end DAT='||DAT_);

end RET_O;
/
show err;

PROMPT *** Create  grants  RET_O ***
grant EXECUTE                                                                on RET_O           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RET_O.sql =========*** End *** ===
PROMPT ===================================================================================== 
