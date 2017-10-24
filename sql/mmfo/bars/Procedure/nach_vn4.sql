

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN4.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN4 ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN4 
 ( p_MFO varchar2, p_DAT date, p_mode int DEFAULT 0 ) is

/*
 16-03-2011 Сухова Закомментарены индексы, их строит Боря ранее

 22-02-2010 Сухова Определение минимальной даты для импорта док

 13-04-2010 virko 29-03-2010 (по загрузке символов кассплана)
 ЧАСТЬ IV. очень желательная . Документы c начала года
*/

  branch_ varchar2(30) := '/'|| p_MFO || '/' ;
  nTmp_   int;
  l_cnt  number;  -- признак наличия индекса
  Dat31_  date;
  DAT0_   varchar2 (35);
  DATS_   varchar2 (35);
begin

  bars_context.subst_branch(branch_);

  select min(fdat) into Dat31_ from saldoa;
  Dat31_ := Dat31_ + 1 ;

  DAT0_ := 'to_date(''01-01-'|| to_char(Dat31_,'YYYY')||''',''dd-mm-yyyy'')';
  DATS_ :=  to_char(P_DAT,'ddmmyyyy');
  DATS_ := 'to_date('''|| DATS_ ||''',''DDMMYYYY'')';

logger.info('NACH_VN4:'|| DAT0_ || ',' || DATs_ );

  If p_mode > 0 then goto NOT_0; end if;
  -----------------------------------------

  -- слияние S6_DOCUM -> S6_DOCUM_Y
execute immediate '
begin
  for k in (select s.*, rowid RI
            from  S6_DOCUM  s
            where ( DA_MB >= '|| DAT0_ || ' or DA >= ' || DAT0_ ||' )
            and STATUS in (1)     )
  loop

    insert into S6_DOCUM_y
      (  id_oper,  DA,  DA_OD,  DA_FACT,  ND,     kb_a,  KK_A,
         KB_B,   KK_B,
         D_K,   SUMMA,  I_VA ,  DA_DOC ,  NK_A,   NK_B,  NP,
         KOD_A, KOD_B,
         DB_S,  KR_S ,  DA_MB,  DA_REC ,  CUR_VS, STATUS,
         SKO , ID_DOCUM, REE_COUNT, GROUP_U,ISP_OWNER, ID_PARENT  )
    values
      (k.id_oper,  k.DA , k.DA_OD,    k.DA_FACT, k.ND  ,      k.kb_a, k.KK_A,
       k.KB_B,   k.KK_B ,
       k.D_K,    k.SUMMA, k.I_VA ,    k.DA_DOC , k.NK_A,      k.NK_B, k.NP,
       k.KOD_A,  k.KOD_B,
       k.DB_S,   k.KR_S , k.DA_MB,    k.DA_REC , k.CUR_VS,    1 ,
       k.SKO ,k.ID_DOCUM, k.REE_COUNT,k.GROUP_U, k.ISP_OWNER, k.ID_PARENT
        );

    update S6_DOCUM set STATUS = 5 where ROWID=k.RI;

  end loop;
end;
';

/*
  --16-03-2011 Сухова Закомментарены индексы, их строит Боря
  select count(*) into l_cnt from user_indexes where index_name= 'I1_S6DY';
  If l_cnt >0 then
     execute immediate 'drop index I1_S6DY';
  end if;
  execute immediate 'create index I1_S6DY on S6_DOCUM_Y(DA_MB) tablespace brsdyni';
  select count(*) into l_cnt from user_indexes where index_name= 'I2_S6DY';
  If l_cnt >0 then
     execute immediate 'drop index I2_S6DY';
  end if;
  execute immediate 'create index I2_S6DY on S6_DOCUM_Y (DA) tablespace brsdyni';

*/

  begin
    EXECUTE IMMEDIATE 'alter table S6_DOCUM_Y add (ref number) ';
  exception  when others then
    -- ORA-01430: column being added already exists in table
    if sqlcode = -01430 then null; else raise; end if;
  end;

<<NOT_0>> null;
  If p_mode > 1 then goto NOT_1; end if;

execute immediate '
declare
  accd_ int   ;  acck_ int    ; Ref_ int    ; TT_ char(3) := ''МГР'' ;
  VOB_ int    ; S_ number     ; Q_ number   ;
  MFOB_ varchar2(12) ;  DEB_ varchar2(15)   ; KRD_ varchar2(15)   ;
  MFOA_ varchar2(12) ;
  mfo5_ char(5)      := Substr(gl.amfo,1,5) ;
  SK_  int;
begin
  FOR d in (select DA from (select distinct DA from S6_DOCUM_Y
                            where DA>'|| DAT0_ || ' )
            order by 1)
  loop
     FOR k in (select  id_oper               ID   ,
                       DA_FACT               PDAT ,
                       DA_DOC                DATD ,
                       DA_REC                DATP ,
                       ROWID                 RI   ,
                       DA                    FDAT , -- факт.дата opldok.FDAT
                       DA_MB                 VDAT , -- дата валют oper.VDAT
                       to_char(kb_a)         MFOA ,
                       KK_A                  NLSA ,
                       substr(NK_A,1,38)     NAM_A,
                       KOD_A                 ID_A ,
                       to_char(KB_B)         MFOB ,
                       KK_B                  NLSB ,
                       substr(NK_B,1,38)     NAM_B,
                       KOD_B                 ID_B ,
  substr(DB_S,1,4)||''0''||substr(DB_S,5,9)  DEB  ,
  substr(KR_S,1,4)||''0''||substr(KR_s,5,9)  KRD  ,
                       D_K                   DK   ,
                       SUMMA*100             S    ,
                       I_VA                  KV   ,
                       CUR_VS                CURS ,
                       NP                    NAZN ,
                       nd                    ND   ,
                       mod(SKO,100)          SK
                 from S6_DOCUM_Y
                 where  DA = d.DA and  STATUS in (1)
                 )
     LOOP
        begin
          DEB_ := vkrzn( mfo5_, k.deb);
          KRD_ := vkrzn( mfo5_, k.krd);
          select acc into accd_ from accounts where nls like DEB_ and kv=k.kv;
          select acc into acck_ from accounts where nls like KRD_ and kv=k.kv;
        EXCEPTION WHEN NO_DATA_FOUND THEN  GOTO nexrec;
        end;

        if    k.kv=980       then S_:= k.S ; q_:= k.S  ;
        elsIf k.CURS >0      then S_:= k.S ; q_:= round(k.S*k.CURS,0);
        else                      S_:= 0   ; Q_:= k.S  ;
        end if;

        gl.REF (ref_);
        --Корр.обороты
        If to_char(k.VDAT,''YYYYMM'') < to_char(k.FDAT,''YYYYMM'') and
           to_number(to_char(k.FDAT,''DD''))   < 10                and
           to_number(to_char(k.VDAT,''DD''))   > 25           then VOB_:=96;
        else                                                       Vob_:= 6;
        end if;

-- запись МФОА и  МФОБ в свои поля

SK_  := k.SK  ;
MFOA_:= k.mfoa;
MFOB_:= k.mfob;

while TRUE
loop
  begin

    insert into oper (
       REF   , DEAL_TAG,TT     ,VOB   ,  ND  ,  VDAT ,  KV  ,  DK  , S ,
       DATD  , DATP    ,NAM_A  ,NLSA  ,  MFOA,NAM_B  , NLSB ,  MFOB,
       NAZN  , ID_A    ,ID_B   , SOS  , pdat ,  SK)
    values (
       REF_  , k.ID    , TT_   ,VOB_  ,k.ND  ,k.VDAT ,k.KV  ,k.DK  ,S_ ,
       k.DATD, k.DATP  , k.NAM_A,k.NLSA, mfoa_, k.NAM_B,k.NLSB, mfob_,
       k.NAZN, k.ID_A  , k.ID_B , 5    , k.PDAT, SK_ ) ;
    EXIT;
  exception  when others then
    --ORA-02291: integrity constraint (BARS.FK_OPER_SK) violated - parent key not found
    if sqlcode = -02291 then
       If    sqlerrm like ''%FK_OPER_SK%''     then   SK_  := null   ;
       elsIf sqlerrm like ''%FK_OPER_BANKS2%'' then   MFOA_:= gl.amfo;
       elsIf sqlerrm like ''%FK_OPER_BANKS%''  then   MFOB_:= gl.amfo;
       else
          raise;
       end if;
    else
       raise;
    end if;
  end;
end loop;
--
        update S6_DOCUM_Y set STATUS= 6,ref=REF_ where rowid=k.RI ;

        -- платежнуе документы
        If k.DK<2 then
           insert into opldok(REF,TT,DK,ACC,FDAT,S,SQ,STMt,SOS) values
                  (ref_, tt_,0, accd_, k.FDAT, S_, q_, 0, 5 );
           insert into opldok(REF,TT,DK,ACC,FDAT,S,SQ,STMt,SOS) values
                  (ref_, tt_,1, acck_, k.FDAT, S_, q_, 0, 5 );
        end if;
        -----------------------
        <<nexrec>> null;

     END LOOP; --k
     commit;

     logger.info (''RET_O end DAT='' || d.DA );
  end loop; -- D
end ;
';

<<NOT_1>> null;
  If p_mode > 2 then goto NOT_2; end if;

/*

--16-03-2011 Сухова Закомментарены индексы, их строит Боря
select count(*) into l_cnt from user_indexes where index_name= 'I3_S6DY';
If l_cnt >0 then
 execute immediate 'drop index I3_S6DY';
end if;
execute immediate 'create index I3_S6DY on "S6_DocParam_Y" (ID_OPER, "Param") tablespace brsdyni';

*/

-----символа кас.плана
execute immediate '
declare
  DAT1_ date:= greatest( ' || DATS_|| ' - 31, ' || DAT0_ || ');
  VAL_ varchar2(9); tag_ char(6); nTmp_ number;
begin
for k in (select ref, deal_tag, nlsa, nlsb from  oper
          where vdat >= DAT1_   and  vdat <= ' || DATS_|| ' and sk is null
           and  (nlsa like ''100%'' or nlsb like ''100%'')  and kv =  980 )
loop
   begin
     nTmp_:= to_number(k.deal_tag);

     If    substr(k.NLSA,1,4) in (''1001'',''1002'',''1003'',''1004'') then TAG_ := ''SIO_DB'';
     elsIf substr(k.NLSB,1,4) in (''1001'',''1002'',''1003'',''1004'') then TAG_ := ''SIO_KR'';
     end if;

     select trim(substr("ParamVal",1,9)) into val_ from "S6_DocParam_Y"
     where  id_oper= nTmp_ and "Param" = TAG_  and
           "D_Modify"=(select max("D_Modify")
                      from "S6_DocParam_Y"
                      where  id_oper= nTmp_ and "Param" = TAG_);

     update oper set sk = to_number(VAL_) where ref=k.ref;
   EXCEPTION WHEN OTHERS THEN     null;
   end ;
end loop;
end;
';

<<NOT_2>> null;

 commit;

--OPLDOK готов.
 bc.set_context;

end NACH_VN4  ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN4.sql =========*** End *** 
PROMPT ===================================================================================== 
