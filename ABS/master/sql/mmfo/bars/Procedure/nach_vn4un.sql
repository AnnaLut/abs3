

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN4UN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN4UN ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN4UN (p_MFO varchar2, p_DAT date, p_mode int DEFAULT 0) is
  l_cnt     number;  -- признак наличи¤ индекса
  accd_     int;
  acck_     int;
  Ref_      int ;
  TT_       char(3) := '?v-';
  dk_       int;
  MFOB_     varchar2(12);
  DEB_      varchar2(15);
  KRD_      varchar2(15);
  MFOA_     varchar2(12);
  nlsa_     varchar2(15);
  nlsb_     varchar2(15);
  nmsa_     varchar2(38);
  nmsb_     varchar2(38);
  okpoa_    varchar2(15);
  okpob_    varchar2(15);
  SK_       int;
  dat01_    date := trunc(p_DAT,'yyyy');
  type      cur is ref cursor;
  cur_      cur;
  sql_      varchar2(32000);
  m_dtkt    varchar2(1);
  m_l_cnt   varchar2(14);
  m_r_cnt   varchar2(14);
  m_lcount  varchar2(14);
  m_rcount  varchar2(14);
  m_lmfo    varchar2(6);
  m_rlmfo   varchar2(6);
  m_sifn    varchar2(12);
  m_lnam    varchar2(34);
  m_rnam    varchar2(34);
  m_lknp    varchar2(10);
  m_rknp    varchar2(10);
  m_kv      varchar2(3);
  m_S       number;
  m_Q       number;
  m_zo      varchar2(1);
  m_ndoc    varchar2(10);
  m_DAT     date;
  m_DATDOC  date;
  m_DATIN   date;
  m_nazp    varchar2(240);
  m_So      varchar2(5);
  m_RI      varchar2(32);

begin
  tuda;
  -----
  begin
    EXECUTE IMMEDIATE 'alter table S6_UN_ALMOUT add (ref number)';
  exception  when others then
    -- ORA-01430: column being added already exists in table
    if sqlcode = -01430 then null; else raise; end if;
  end;

  select count(*) into l_cnt from user_indexes where index_name='I1_S6DY';
  If l_cnt>0 then
    execute immediate 'drop index I1_S6DY';
  end if;
  execute immediate 'create index I1_S6DY on S6_UN_ALMOUT (DAt) tablespace brsdyni';


  FOR d in (select distinct fDAT from saldoa where dos+kos>0 and fdat>dat01_ order by 1)
  loop

    sql_:='select dtkt                                 ,
                  substr(trim(nvl(l_cnt,lcount)),1,14) ,  -- l_cnt
                  substr(trim(nvl(r_cnt,rcount)),1,14) ,  -- r_cnt
                  substr(trim(lcount),1,14)            ,  -- lcount
                  substr(trim(rcount),1,14)            ,  -- rcount
                  nvl(lmfo,f_ourmfo_g)                 ,
                  rlmfo                                ,
                  sifn                                 ,
                  lnam                                 ,
                  rnam                                 ,
                  lknp                                 ,
                  rknp                                 ,
                  kv                                   ,
                  sumv*100                             ,  -- S
                  sumn*100                             ,  -- Q
                  zo                                   ,
                  substr(NDOC,1,10)                    ,  -- ndoc
                  DAT                                  ,
                  DATDOC                               ,
                  DATIN                                ,
                  substr(NAZp,1,60)                    ,  -- nazp
                  So                                   ,
                  rowid RI
           from   S6_UN_ALMOUT
           where  ref is null and
                  dat=to_date('''||d.fDAT||''')';

    open cur_ for sql_;
    LOOP
      fetch cur_ into m_dtkt  ,
                      m_l_cnt ,
                      m_r_cnt ,
                      m_lcount,
                      m_rcount,
                      m_lmfo  ,
                      m_rlmfo ,
                      m_sifn  ,
                      m_lnam  ,
                      m_rnam  ,
                      m_lknp  ,
                      m_rknp  ,
                      m_kv    ,
                      m_S     ,
                      m_Q     ,
                      m_zo    ,
                      m_ndoc  ,
                      m_DAT   ,
                      m_DATDOC,
                      m_DATIN ,
                      m_nazp  ,
                      m_So    ,
                      m_RI;
      exit when cur_%notfound;

--    bars_audit.info('NACH_VN4(i):'       ||chr(13)||chr(10)||
--                    'm_dtkt  ='||m_dtkt  ||chr(13)||chr(10)||
--                    'm_DATDOC='||m_DATDOC||chr(13)||chr(10)||
--                    'm_lmfo  ='||m_lmfo  ||chr(13)||chr(10)||
--                    'm_l_cnt ='||m_l_cnt ||chr(13)||chr(10)||
--                    'm_rlmfo ='||m_rlmfo ||chr(13)||chr(10)||
--                    'm_r_cnt ='||m_r_cnt ||chr(13)||chr(10)||
--                    'm_sifn  ='||m_sifn  ||chr(13)||chr(10)||
--                    'm_S     ='||m_S     ||chr(13)||chr(10)||
--                    'm_RI    ='||m_RI);

      If m_dtkt = 1 then
        DEB_ := m_l_cnt; krd_ := m_r_cnt ;
        If m_lmfo<>m_rlmfo and m_sifn like '_bccl9%' then
          -- 3) меж/банк ответные дебетовые (21)
          DK_   := 0;
          MFOb_ := m_lmfo  ;  MFOa_ := m_rlmfo ;
          NLSb_ := m_lcount;  NLSa_ := m_rcount;
          NMSb_ := m_lnam  ;  NMSa_ := m_rnam  ;
          OKPOb_:= m_lknp  ;  OKPOa_:= m_rknp  ;
        else
          -- 1) внут.кредитовые (25300)
          -- 2) меж/банк начальные кредитовые   (20365)
          DK_   := 1;
          MFOA_ := m_lmfo  ;  MFOB_ := m_rlmfo ;
          NLSA_ := m_lcount;  NLSB_ := m_rcount;
          NMSA_ := m_lnam  ;  NMSB_ := m_rnam  ;
          OKPOA_:= m_lknp  ;  OKPOB_:= m_rknp  ;
        end if;
      elsIf m_dtkt = 4 then
        DEB_ := trim(m_r_cnt); krd_:= trim(m_l_cnt);
        IF m_lmfo = m_rlmfo                          then
          -- 4) внут.дебетовые
          DK_   := 0;
          MFOb_ := m_lmfo  ;  MFOa_ := m_rlmfo ;
          NLSb_ := m_lcount;  NLSa_ := m_rcount;
          NMSb_ := m_lnam  ;  NMSa_ := m_rnam  ;
          OKPOb_:= m_lknp  ;  OKPOa_:= m_rknp  ;
        else
          If m_sifn like '_bccl9%' or m_sifn like '_acc%' then
            -- 6) меж/банк ответные кредитовые
            DK_ := 1;
            MFOb_ := m_lmfo  ;  MFOa_ := m_rlmfo ;
            NLSb_ := m_lcount;  NLSa_ := m_rcount;
            NMSb_ := m_lnam  ;  NMSa_ := m_rnam  ;
            OKPOb_:= m_lknp  ;  OKPOa_:= m_rknp  ;
          else
            -- 5) меж/банк начальные дебетовые
            DK_   := 0 ;
            MFOa_ := m_lmfo  ;  MFOb_ := m_rlmfo ;
            NLSa_ := m_lcount;  NLSb_ := m_rcount;
            NMSa_ := m_lnam  ;  NMSb_ := m_rnam  ;
            OKPOa_:= m_lknp  ;  OKPOb_:= m_rknp  ;
          end if;
        end if;
      else
        GOTO nexrec;
      end if;

      begin

--      if deb_ like '3900%' then
--        if    m_kv=980 then DEB_:= '3900991'       ; accd_ := 7040;
--        elsIf m_kv=643 then DEB_:= '39000904000810'; accd_ := 7037;
--        elsIf m_kv=978 then DEB_:= '39001908000978'; accd_ := 7038;
--        elsIf m_kv=840 then DEB_:= '39005902000840'; accd_ := 7039;
--        elsIf m_kv=974 then DEB_:= '39007906000974'; accd_ := 7041;
--        elsIf m_kv=826 then DEB_:= '39000909000826'; accd_ := 7042;
--        end if;
--      else
        select acc into accd_ from accounts a where nls like DEB_ and kv=m_kv and
               exists (select 1 from saldoa where acc=a.acc and fdat=d.FDAT and dos>0);
--      end if;

--      if KRD_ like '3900%' then
--        if    m_kv=980 then KRD_:= '3900991'       ; acck_ := 7040;
--        elsIf m_kv=643 then KRD_:= '39000904000810'; acck_ := 7037;
--        elsIf m_kv=978 then KRD_:= '39001908000978'; acck_ := 7038;
--        elsIf m_kv=840 then KRD_:= '39005902000840'; acck_ := 7039;
--        elsIf m_kv=974 then KRD_:= '39007906000974'; acck_ := 7041;
--        elsIf m_kv=826 then KRD_:= '39000909000826'; acck_ := 7042;
--        end if;
--      else
        select acc into acck_ from accounts a where nls like KRD_ and kv=m_kv and
               exists (select 1 from saldoa where acc=a.acc and fdat=d.FDAT and kos>0);
--      end if;

      EXCEPTION WHEN NO_DATA_FOUND THEN
        GOTO nexrec;
      end;

      gl.REF (ref_);
      SK_ := m_SO;
      while TRUE
      loop
        begin

          If m_so is not null then
            begin
              select sk into sk_ from sk where sk=m_so;
            EXCEPTION WHEN NO_DATA_FOUND THEN
              sk_ := null;
            end;
          end if;

          insert into oper (REF,TT,VOB,ND,VDAT,KV,DK,S,DATD,DATP,NAM_A,NLSA,
                            MFOA,NAM_B,NLSB,MFOB,NAZN,ID_A,ID_B,SOS, pdat,SK)
                    values (REF_,TT_,6,substr(m_NDOC,1,10),d.FDAT,m_KV,DK_,m_S,
                            m_DATDOC,m_DATIN,NMsA_,NLSA_,mfoa_,NMsB_,NLSB_,
                            mfob_,substr(m_NAZp,1,160),okpoa_,okpob_,5,m_DATIN,
                            SK_);

--        bars_audit.info('NACH_VN4: -3 ref_='||ref_);

          EXIT;
        exception when others then
          if sqlcode = -02291 then
            If    sqlerrm like '%FK_OPER_BANKS2%' then
              MFOA_:= gl.amfo;
            elsIf sqlerrm like '%FK_OPER_BANKS%' then
              MFOB_:= gl.amfo;
            else
              raise;
            end if;
          else
            raise;
          end if;
        end;

      end loop;

      execute immediate 'update S6_UN_ALMOUT
                         set    ref='||to_char(REF_)||'
                         where  rowid='''||m_RI||'''';

--    bars_audit.info('NACH_VN4: rowid='||m_RI||', ref='||to_char(REF_));
--    bars_audit.info('NACH_VN4: -4 dk_='||dk_);

      If DK_<2 then
        insert into opldok (REF,TT,DK,ACC,FDAT,S,SQ,STMt,SOS)
                    values (ref_,tt_,0,accd_,d.FDAT,m_S,m_q,0,5);
        insert into opldok (REF,TT,DK,ACC,FDAT,S,SQ,STMt,SOS)
                    values (ref_,tt_,1,acck_,d.FDAT,m_S,m_q,0,5);
      end if;

      <<nexrec>> null;
    END LOOP; --k
    close cur_;
    commit;

    bars_audit.info('NACH_VN4: end DAT='||d.fDAt);
  end loop; -- D

--OPLDOK готов.

end NACH_VN4un;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN4UN.sql =========*** End **
PROMPT ===================================================================================== 
