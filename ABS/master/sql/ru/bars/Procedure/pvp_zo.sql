

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PVP_ZO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PVP_ZO ***

  CREATE OR REPLACE PROCEDURE BARS.PVP_ZO (DAT31_ date) is

/*
 07.08.2012
 Переоцiнка вал.поз.звiтного перiоду з корр.об.
 отдельно по АКТ и по ПАС
 рекоментовано вставить в формирование 02 файла
 p_f02_snp
 ПЕРЕД принудительной синхронизацией
 bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);
*/

 s3800a_ number;
 s3800p_ number;
 s3801a_ number;
 s3801p_ number;
 dat01_  date  ;
 id_    number ;
 ---------------

 nla_3801 accounts.nls%type;
 nma_3801 accounts.nms%type;

 nlp_3801 accounts.nls%type;
 nmp_3801 accounts.nms%type;

 s_ number;
 s1_ number;

 nls_6204 accounts.nls%type;
 nms_6204 accounts.nms%type;
 ref_ number;
 dk_  int;

 fl_    number := 0;
begin

  dat01_ := trunc(dat31_,'MM');

  select nvl( sum(decode(a.nbs,'3800', decode(z.ap,-1, z.sq,0), 0)),0),
         nvl( sum(decode(a.nbs,'3800', decode(z.ap, 1, z.sq,0), 0)),0),
         nvl( sum(decode(a.nbs,'3801', decode(z.ap,-1, z.sq,0), 0)),0),
         nvl( sum(decode(a.nbs,'3801', decode(z.ap, 1, z.sq,0), 0)),0)
  into  s3800a_, s3800p_ , s3801a_, s3801p_
  from accounts a,
       (select m.acc,
               sign(m.ostq - m.crdosq + m.crkosq) AP,
               m.ostq - m.crdosq + m.crkosq       SQ
        from ACCM_AGG_MONBALS m, ACCM_CALENDAR k
        where m.caldt_id = k.caldt_id and k.caldt_date = dat01_
        ) z
  where a.acc= z.acc  and a.nbs in ('3800','3801') ;

  If s3800a_ = s3801p_ and  s3800p_ = s3801a_ then
     RETURN;
  end if;
  -------------------------------------------------
  begin
    select nls, substr(nms,1,38) into nls_6204, nms_6204
    from accounts where nbs='6204' and dazs is null and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100, '\Не знайдено 6204');
  end;

  ----3800 АКТ -----------
  s_:= s3801p_ + s3800a_ ;
  If s_ = 0  then goto PASS; end if;

  If s_ >0 then dk_:= 1  ;
  else          dk_:= 0  ; s_:= -s_;
  end if;

  loop
      fl_:= 0;
      s1_ := s_;

      begin
        select a.nls, substr(a.nms,1,38) into nlp_3801, nmp_3801
        from accounts a ,
            (select m.acc,  m.ostq - m.crdosq + m.crkosq       SQ
             from ACCM_AGG_MONBALS m, ACCM_CALENDAR k
             where m.caldt_id = k.caldt_id and k.caldt_date = dat01_
             ) z
         where a.nbs='3801' and a.dazs is null and a.acc= z.acc
           and z.sq > 0 and abs(z.sq) >  s_    and rownum = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         begin
            select nls, nmp, sq into nlp_3801, nmp_3801, s1_
            from (
                select a.nls, substr(a.nms,1,38) nmp, sq
                from accounts a ,
                    (select m.acc,  m.ostq - m.crdosq + m.crkosq       SQ
                     from ACCM_AGG_MONBALS m, ACCM_CALENDAR k
                     where m.caldt_id = k.caldt_id and k.caldt_date = dat01_
                     ) z
                 where a.nbs='3801' and a.dazs is null and a.acc= z.acc
                   and z.sq > 0 and abs(z.sq) <= s_
                 order by sq desc)
             where rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            raise_application_error(-20100, '\Не знайдено 3801p');
         end;
      end;

      if s1_ > 0 then
          gl.ref (REF_);
          gl.in_doc3(ref_  => REF_,
                     tt_    => 'PVP',
                     vob_   => 96,
                     nd_    => substr(to_char(REF_),1,10),
                     pdat_  => SYSDATE ,
                     vdat_  => gl.BDATE,
                     dk_    => dk_,
                     kv_    => gl.baseval,
                     s_     => S1_,
                     kv2_   => gl.baseval,
                     s2_    => S1_,
                     sk_    => null,
                     data_  => gl.BDATE,
                     datp_  => gl.bdate,
                     nam_a_ => nmp_3801,
                     nlsa_  => nlp_3801,
                     mfoa_  => gl.aMfo ,
                     nam_b_ => nms_6204,
                     nlsb_  => nls_6204,
                     mfob_  => gl.aMfo ,
                     nazn_  => 'Переоцiнка вал.поз.(АКТ)звiтного перiоду з корр.об.',
                     d_rec_ => null,
                     id_a_  => null,
                     id_b_  => null,
                     id_o_  => null,
                     sign_  => null,
                     sos_   => 1,
                     prty_  => null,
                     uid_   => null);

          gl.payv(flg_  => 0,          ref_  => REF_    ,
                  dat_  => gl.bDATE ,  tt_   => 'PVP'   ,  dk_   => dk_,
                  kv1_  => gl.baseval, nls1_ => nlp_3801,  sum1_ => s1_ ,
                  kv2_  => gl.baseval, nls2_ => nls_6204,  sum2_ => S1_ );
          gl.pay(2, ref_, gl.bdate);
      end if;

      s_ := s_ - s1_;

      exit when s_ <= 0;
  end loop;

  ----3800 ПАС -----------
  <<PASS>> null;
  s_:= s3801a_ + s3800p_ ;
  If s_ = 0  then goto FINITA; end if;


  If s_ >0 then dk_:= 1;
  else          dk_:= 0; s_:= -s_;
  end if;

  begin
     select a.nls, substr(a.nms,1,38) into nla_3801, nma_3801
     from accounts a ,
         (select m.acc,  m.ostq - m.crdosq + m.crkosq       SQ
          from ACCM_AGG_MONBALS m, ACCM_CALENDAR k
          where m.caldt_id = k.caldt_id and k.caldt_date = dat01_
         ) z
     where a.nbs='3801' and a.dazs is null and a.acc= z.acc
       and z.sq < 0 and abs(z.sq) > s_     and rownum = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100, '\Не знайдено 3801a');
  end;

  gl.ref (REF_);
  gl.in_doc3(ref_  => REF_,
            tt_    => 'PVP',
            vob_   => 96,
            nd_    => substr(to_char(REF_),1,10),
            pdat_  => SYSDATE ,
            vdat_  => gl.BDATE,
            dk_    => dk_,
            kv_    => gl.baseval,
            s_     => S_,
            kv2_   => gl.baseval,
            s2_    => S_,
            sk_    => null,
            data_  => gl.BDATE,
            datp_  => gl.bdate,
            nam_a_ => nma_3801,
            nlsa_  => nla_3801,
            mfoa_  => gl.aMfo ,
            nam_b_ => nms_6204,
            nlsb_  => nls_6204,
            mfob_  => gl.aMfo ,
            nazn_  => 'Переоцiнка вал.поз.(ПАС)звiтного перiоду з корр.об.',
            d_rec_ => null,
            id_a_  => null,
            id_b_  => null,
            id_o_  => null,
            sign_  => null,
            sos_   => 1,
            prty_  => null,
            uid_   => null);

  gl.payv(flg_  => 0,          ref_  => REF_    ,
          dat_  => gl.bDATE ,  tt_   => 'PVP'   ,  dk_   => dk_,
          kv1_  => gl.baseval, nls1_ => nla_3801,  sum1_ => s_ ,
          kv2_  => gl.baseval, nls2_ => nls_6204,  sum2_ => S_ );
  gl.pay(2, ref_, gl.bdate);

  <<FINITA>>   null;
  --------------------
end PVP_zo; 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PVP_ZO.sql =========*** End *** ==
PROMPT ===================================================================================== 
