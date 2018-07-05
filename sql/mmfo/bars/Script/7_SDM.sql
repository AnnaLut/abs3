create or replace function Get_NLS60 ( p_kv int, p_nls varchar2) return varchar2  is 
  l_nls6   varchar2 (16) ;
  l_acc    accounts.acc%type;
  l_nd     cc_deal.nd%type;
  l_prod   char(6) ;
  l_branch cc_deal.branch%type;
  l_NBS6   NBS_SS_SD.NBS6%type;
  l_Ob6    char(2) ; 
begin
   begin  select acc into l_acc from accounts where kv = p_kv and nls = p_nls;
          select nd  into l_nd  from nd_acc where acc = l_acc ;
          select substr(prod,1,6), substr(branch,1,15)  into l_prod , l_branch from cc_deal  where nd = l_nd ;
          select nbs6 into l_nbs6 from  nbs_ss_sd where nbs2 = substr(l_prod,1,4) ;
          select decode (p_kv, gl.baseval, sd_n, sd_i) into l_ob6 from cck_ob22 where nbs||ob22= l_prod;

          select nls into l_nls6
          from (  select nls from accounts a6 where nbs = l_nbs6 and ob22 = l_ob6 and dazs is null  order by decode ( l_branch, a6.branch,1, 2) )
          where rownum = 1;
   exception when others then null;
   end ;
   RETURN l_NLS6;

end get_NLS60;
/
show err;
--------------
declare   
  oo oper%rowtype ;
  ow operW%rowtype;
  cn number;
/*
Обнаружена такая ошибка :
Если в витрине FV  в одном отчетном периоде приходили одновременно суммы S3(возникновение)  и S4 (амортизация) ,
То мы ошибочно проводили сумму  S4 по тому же счету, что и S3
Но это разные бал.счета  !
Для S3 – это   73** и 63**
Для S4 – это  60**
Готовы сделать перекидку с неправильных 73** 63** на правильные счета 60**
со ссылкой на первичный реф. в назначении платежа
По оговоренным правилам маркировки  наших корр в этом месяце (доп.рекв DATN)
Пример на Киев РУ на одном дог = 18009451011(всего 963).
Имеем такую же проблему на др.РУ.
*/

begin
  ow.tag  := 'DATN' ;
  ------------------------
  for k in (select * from mv_kf  )
  loop bc.go ( k.KF);   ow.kf  := gl.aMfo   ;
     select count(*) into CN from oper where vdat=to_date ('27-06-2018', 'dd-mm-yyyy') and vob=96 and tt='013' and ND = 'FRS9_ZO7_K'; 
     if cn<>0 THEN RETURN; end if;
     --------------------------------------------------------------------------------------------------------------
     For x in ( select z.*, p2.dk, p2.s2, Get_NLS60 ( z.kv, z.nlsa)  NLS60
                from ( select p.vdat, p.kv, p.nlsa, p.nazn, p.nlsb, count(*), max(p.ref) REF2  
                       from oper p 
                       where sos = 5 and p.pdat > to_date ('22-06-2018', 'dd-mm-yyyy') and P.PDAT < to_date ('28-06-2018', 'dd-mm-yyyy') 
                         and p.nd = 'FRS9_R'
                         and (p.nazn like 'Доформування по МСФЗ-9*SDM%' )   ---or--nazn like 'Доформування по МСФЗ-9*SDF%'
                       group by  p.vdat, p.kv, p.nlsa, p.nazn, p.nlsb
                       having count(*) = 2
                      ) z, oper p2
                where p2.ref = z.ref2 
               ) 
     loop select * into oo from oper where ref = x.REF2 ;
          oo.tt   := '013' ;
          oo.vob  := 96 ;
          ow.value:= to_char( oo.Vdat, 'dd.mm.yyyy' );
          oo.vdat := to_date ('27-06-2018', 'dd-mm-yyyy') ;
          oo.ND   := 'FRS9_ZO7_K' ;
          oo.DK   := 1-oo.dk ;
          oo.Nazn := Substr ('R='|| oo.REF|| '*' || oo.nazn, 1, 160) ;
          oo.Ref  := null ;
          gl.ref (oo.REF)  ;
          oo.NLSA := x.NLS60 ;
          oo.kv   := 980 ;
          oo.kv2  := 980 ;
          oo.s    := oo.s2 ;
 select substr(nms,1,38) into oo.nam_a from accounts where kv = oo.kv   and nls = oo.nlsa;
 select substr(nms,1,38) into oo.nam_b from accounts where kv = oo.kv2  and nls = oo.nlsb;

 update accounts set pap = 3 where kv = oo.kv  and nls = oo.nlsa and pap <> 3 ;
 update accounts set pap = 3 where kv = oo.kv2 and nls = oo.nlsb and pap <> 3 ;
 
          gl.in_doc3 (ref_=>oo.REF, tt_=> oo.tt, vob_=> oo.vob, nd_ =>oo.nd , pdat_=>SYSDATE, vdat_ =>oo.vdat, 
                       dk_ =>oo.dk , kv_=> oo.kv, s_  => oo.S  , kv2_=>oo.kv2, s2_ =>oo.S2, sk_=> null,data_=>gl.bdate,datp_=>gl.bdate,
                    nam_a_ =>oo.nam_a, nlsa_ => oo.nlsA, mfoa_ => gl.aMfo,
                    nam_b_ =>oo.Nam_B, nlsb_ => oo.nlsB, mfob_ => gl.aMfo,
                     nazn_ =>oo.NAZN ,
                     d_rec_=>null, id_a_=> null, id_b_=>null, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null 
                      );
           ow.ref := oo.Ref ;
           insert into operw values ow;
           gl.payv(0, oo.REF, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsA, oo.s, oo.kv2, oo.nlsB, oo.s2);
           gl.pay (2, oo.ref, gl.bdate);  -- по факту
        
     end loop ; -- x
    commit ;
  end loop ; --k
end;
/

