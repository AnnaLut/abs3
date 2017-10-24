

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2BUN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN2BUN ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN2BUN (p_MFO varchar2, p_DAT date) is

/*
 Sta 17-01-2011  Формирование SALDOB = за макс дат ( SALDOA, CUR_RATES$BASE)
*/

 o_Dat date ;   r_Dat date;  Dat1_ date;
 l_kv   accounts.kv%type  ; l_ostc accounts.ostc%type;

begin
   tuda;

   DELETE FROM SALDOB;

   --минимальная дата-1 из оборотов
   select nvl(min(fdat)+1,P_DAT) into o_Dat from saldoa where dos+kos>0;

   --минимальная дата-1 из курсов
   select nvl(min(vdate)+1, P_DAT) into r_Dat from cur_rates$base where kv<>980;

   -- переоценка за все дни. Долго
   Dat1_ :=greatest( o_Dat, r_Dat );

   LOGGER.INFO ('NACH_VN2B o_Dat=' || O_Dat || ' R_Dat=' || r_Dat );

   p_rev_OB ( Dat1_ );

   return;

-------------------------------------------------------
-- Довесок для стартовой балансировки вх.ост вешалок.

declare
  ref_  oper.REF%type     ;
  tt_   oper.TT%type      := '013';
  vob_  oper.VOB%type     := 6;
  s_    oper.S%type       ;
  dk_   oper.dk%type      ;
  gl_bd oper.vdat%type    ;
  nlsa_ oper.NLSA%type    ;
  nlsb_ oper.NLSB%type    ;
  nmsa_ oper.NAM_A%type   ;
  nmsb_ oper.NAM_B%type   ;
  acca_ accounts.acc%type ;
  accb_ accounts.acc%type ;
  -------------------------
begin
   select sum(ostf)  into s_  from saldob
   where ostf<>0 and pdat is null and acc in
    (select acc from accounts where nls like '3800_000000000' and nbs is null);

   If s_ = 0 then RETURN; end if;
   ------------------------------
   If s_ <0 then dk_:= 0; s_ := -s_;
   else          dk_:= 1;
   end if;

   gl.bdate := Dat1_;

   begin
     select a.acc, a.nls, substr(a.nms,1,38),
            b.acc, b.nls, substr(b.nms,1,38)
     into  acca_, nlsa_, nmsa_, accb_, nlsb_, nmsb_
     from accounts a, accounts b
     where b.nbs='6204' and b.kv=gl.baseval
       and a.nls like '3801_000000%' and a.nbs is null and a.kv=gl.baseval
       and a.dazs is null and b.dazs is null and rownum=1 and b.ostc<>0;

     update accounts set daos=gl.bdate where acc=acca_ and daos>gl.bdate;
     update accounts set daos=gl.bdate where acc=accb_ and daos>gl.bdate;

   EXCEPTION WHEN NO_DATA_FOUND THEN
      raise_application_error(-20100,'   Не знайдено 3801-0000% або 6204',TRUE);
   end;

   gl.ref (REF_);
   gl.in_doc3(ref_  => REF_,
            tt_    => TT_ ,
            vob_   => VOB_,
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
            nam_a_ => nmsa_,
            nlsa_  => nlsa_,
            mfoa_  => gl.aMfo,
            nam_b_ => nmsb_,
            nlsb_  => nlsb_,
            mfob_  => gl.aMfo,
            nazn_  => 'Стартове балансування екв.',
            d_rec_ => null,
            id_a_  => null,
            id_b_  => null,
            id_o_  => null,
            sign_  => null,
            sos_   => 1,
            prty_  => null,
            uid_   => 20094 );

     gl.payv(flg_  => 0,
             ref_  => REF_ ,
             dat_  => gl.bDATE ,
             tt_   => TT_  ,
             dk_   => dk_  ,
             kv1_  => gl.baseval,
             nls1_ => nlsa_,
             sum1_ => s_   ,
             kv2_  => gl.baseval,
             nls2_ => nlsb_,
             sum2_ => S_   );

     gl.pay(2, REF_, gl.bDATE );

     gl.bdate := gl_bd ;
end;

commit;

 -- есть ли баланс по saldob
 begin
    select kv, s into l_kv, l_ostc   from
      (select kv,sum(fostQ(acc,p_DAT)) s from accounts
       where nls not like '8%' group by kv having sum(fostQ(acc,p_DAT))<>0)
    where rownum =1 ;
    Raise_application_error(-20100,
       '     NACH_VN2b: НеБаланс по saldob ' || l_KV || ' '||l_ostc );
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;


end NACH_VN2bun;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2BUN.sql =========*** End *
PROMPT ===================================================================================== 
