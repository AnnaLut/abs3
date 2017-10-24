

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_RET_EARLY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_RET_EARLY ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_RET_EARLY 
 (p_mode int,    --        / = 1  - Заключення угоди – при первісному визнанні
                 -- p_mode | = 3  - Дострокове завершення
                      --        \ = 2  - Нормальне завершення угоди Окрема видача
  p_ID   number  ---- p_ID - ID нового договора по акции
 )   is


/*
  Sta + Inga + Baa 01.04.2014
  Демкович Марія Степанівна <DemkovichMS@oschadbank.ua>  Пт 28/03/2014 15:05
  Необхідність обліку нарахованих процентів по депозитних вкладах залучених на умовах акції «Ощадбанк завжди поруч»
  щодо залучення достроково вилучених коштів фізичних осіб за депозитними договорами.

  Постанова правління АТ «Ощадбанк» від 24.02.2014 року № 128.
*/

  rr dpt_political_instability%rowtype;
  aa accounts%rowtype;
  a2 accounts%rowtype;
  a3 accounts%rowtype;
  a6 accounts%rowtype;
  dd DPT_DEPOSIT%rowtype;
  oo oper%rowtype;
  p4_ int;

  acc2636 number := 0;
  dazs2636 date;
  acc3648 number := 0;
  dazs3648 date;
  ref_2636_3648 number := 0;

  already_payed number := 0;
  ----------------------
  procedure OPL1     (oo IN OUT oper%rowtype)
  is
    -- оплата 1 проводки
  begin
     If nvl(oo.s,0) <= 0
        then return;
     end if;

     oo.tt := NVL(oo.TT, 'DIR');
     oo.vob := nvl(oo.vob,6);

     if oo.ref is null
     then
        gl.ref (oo.REF);
        oo.nd := substr(to_char(oo.ref),1,10);
        gl.in_doc3( ref_      =>oo.ref,
                         tt_        => oo.tt,
                         vob_     => 6,
                         nd_       => oo.nd,
                         pdat_    =>SYSDATE,
                         vdat_    => gl.bdate,
                         dk_       => oo.dk,
                         kv_       => oo.kv,
                         s_        => oo.S,
                         kv2_     =>oo.kv,
                         s2_      => oo.s,
                         sk_      => null,
                         data_   =>gl.bdate,
                         datp_   =>gl.bdate,
                         nam_a_=>oo.nam_a,
                         nlsa_    =>oo.nlsa,
                         mfoa_   =>gl.aMfo,
                         nam_b_ =>oo.nam_b,
                         nlsb_     =>oo.nlsb,
                         mfob_   =>gl.aMfo,
                         nazn_    => oo.nazn,
                         d_rec_   => null,
                         id_a_     => null,
                         id_b_     => null,
                         id_o_     => null,
                         sign_     => null,
                         sos_      => 5,
                         prty_     => null,
                         uid_      => null);
     end if;
     gl.payv( 0, oo.ref, gl.bdate ,oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv, oo.nlsb , oo.s );

     update opldok
     set txt = oo.d_rec
     where ref = gl.aref
     and stmt = gl.aStmt;

  end opl1;
  -------------------

begin

  if p_mode  =2
    then
        NULL;

      /*  select    *
        into       rr
        from     dpt_political_instability
        where   NEW_DPT_ID = p_id
        and       PENALTY_SUM  >0;


        select  *
        into     dd
        from   DPT_DEPOSIT
        where DEPOSIT_ID = p_id;

         if to_date(dd.dat_end,'dd/mm/yyyy') <= to_date(sysdate,'dd/mm/yyyy') then
                begin
                         -- Нормальне завершення угоди
                         -- Дт 3648-індивідуальний по угоді 2638 касса -індивідуальний по угоді  на суму S
                        select a.* into a3 from accounts a, DPT_ACCOUNTS n where n.DPTID = p_id and a.acc=n.accid and a.nbs = '3648';
                        select a.* into a2 from accounts a, DPT_ACCOUNTS n where n.DPTID = p_id and a.acc=n.accid and a.nbs = '2638';

                 exception when no_data_found then Return;
                 end;

                 select nvl(count(ref),0)
                 into already_payed
                 from oper
                 where ref in (select ref from dpt_payments where dpt_id = rr.new_dpt_id)
                 and nlsa = a3.nls
                 and nlsb = a2.nls
                 and s =  a3.ostc
                 and sos >0;

                 if nvl(already_payed,0) = 0 then

                         oo.ref := null;
                         oo.s :=  a3.ostc;
                         oo.s2 := oo.s;
                         oo.kv := a2.kv;
                         oo.kv2:= a3.kv;
                         oo.dk := 0;
                         oo.nam_a:= a3.nms;
                         oo.nlsa := a3.nls;
                         oo.nam_b := a2.nms ;
                         oo.nlsb :=a2.nls;
                         oo.d_rec :='Виплата амортизованого дисконту';
                         oo.nazn := substr( oo.d_rec||' в зв`язку з виплатою в кінці строку акційного вкладу '||dd.nd, 1,160);

                         opl1(oo);

                         insert into dpt_payments(dpt_id, ref, kf, branch,rnk)
                         values (rr.new_dpt_id, oo.ref, dd.kf, dd.branch, dd.rnk);
                 end if;*/
        --end if;

  Elsif p_mode  =3  then

     -- Дострокове завершення
     begin
        select * into rr from  dpt_political_instability where NEW_DPT_ID = p_id and ref is not null and PENALTY_SUM  >  0    ;
        select * into dd from  DPT_DEPOSIT               where DEPOSIT_ID = p_id  ;
        select * into aa from  accounts                  where acc =  dd.acc      ;
        select a.* into a2 from accounts a, DPT_ACCOUNTS n where n.DPTID = p_id and a.acc=n.ACCID and a.nbs = '2636' and a.ostc = a.ostb and a.ostc < 0 ;
        select a.* into a3 from accounts a, DPT_ACCOUNTS n where n.DPTID = p_id and a.acc=n.accid and a.nbs = '3648' and a.ostc = a.ostb ;
        a6.acc :=  DPT.get_expenseacc (p_dptype =>dd.vidd  , -- код вида вклада
                                       p_balacc =>aa.nbs   , -- бал.счет депозита
                                       p_curcode=>aa.kv    , -- код валюты депозита
                                       p_branch =>aa.branch, -- код подразделения
                                       p_penalty=> 1 )     ; -- 0-счет для начисления, 1-счет для штрафования

        select a.* into a6 from accounts a where acc = a6.acc ;

     exception when no_data_found then Return;
     end;

             --3648-індивідуальний по угоді    2636-індивідуальний по угоді    S1  = Залишок на 2636
             oo.ref := null;
             oo.s := - a2.ostc;
             oo.s2 := oo.s;
             oo.kv := a2.kv;
             oo.kv2:= a3.kv;
             oo.dk := 0;
             oo.nam_a:= a2.nms;
             oo.nlsa := a2.nls;
             oo.nam_b := a3.nms ;
             oo.nlsb :=a3.nls ;
             oo.d_rec :='Закриття неамортиз.дисконту';
             oo.nazn := substr( oo.d_rec||' в зв`язку з достроковим вилученням акційного вкладу '||dd.nd, 1,160);

             opl1(oo);

             --3648-індивідуальний по угоді 6399- котловий по бранчу-2     S2 = Залишок на 3648, що створився після X-1
             oo.s:= a3.ostc - oo.s;
             oo.s2:= oo.s;
             oo.d_rec:='Повернення амортизованої суми';
             oo.kv:= a3.kv;
             oo.kv2:=gl.baseval;
             oo.dk:= 1;
             oo.nlsa := a3.nls;
             oo.nlsb := a6.nls;

             opl1(oo);

  ---------------------------
  ElsIf p_mode = 1 then --  Заключення угоди – при первісному визнанні

     begin
        select    *
        into       rr
        from     dpt_political_instability
        where   NEW_DPT_ID = p_id
        and       ref is null
        and       PENALTY_SUM  >0;

        select    *
        into       dd
        from     DPT_DEPOSIT
        where   DEPOSIT_ID = p_id;

        select    *
        into       aa
        from     accounts
        where   acc =  dd.acc;
     exception when no_data_found then Return;
     end;

     a2.nls := vkrzn(substr( gl.aMfo,1,5) , '26360'|| substr(aa.nls,5,10));

     begin
         select     acc, dazs
         into        acc2636, dazs2636
         from       accounts
         where     nbs = 2636
         and         substr(nls,6,9) = substr(a2.nls,6,9)
         and         rnk = dd.rnk;
     exception when no_data_found then acc2636 := 0; dazs2636 := null;
     end;

     a2.acc := acc2636;

     if acc2636 = 0 and dazs2636 is null
     then
         op_reg( 99, 0, 0, 0, p4_, dd.rnk, a2.nls, aa.kv, substr('Дисконт за акцiєю.' || aa.nms, 1,38), 'ODB', aa.isp, a2.acc) ;


          insert into int_accn (acc, id, METR,   BASEM ,  BASEY ,  FREQ  ,acra, acrb, acr_dat, tt )
          select a2.acc, 0, 4, 0,0,1 , a2.acc, i.acrb, aa.daos, i.tt
          from  int_accn i
          where id = 1
          and acc=aa.acc;

          insert into DPT_ACCOUNTS (dptid,accid) values ( p_ID, a2.acc);

          update accounts
          set tobo = aa.branch,
          mdate = aa.mdate
          where acc = a2.acc;
     end if;


     select    *
     into       a2
     from     accounts
     where   acc = a2.acc;

     a3.nls := vkrzn ( substr( gl.aMfo,1,5) , '3648'|| substr( aa.nls,5,10) );

     begin
         select     acc, dazs
         into        acc3648, dazs3648
         from       accounts
         where     nbs = 3648
         and         substr(nls,6,9) = substr(a2.nls,6,9)
         and         rnk = dd.rnk;
     exception when no_data_found then acc3648 := 0; dazs3648 := null;
     end;

     a3.acc := acc3648;

     if acc3648 = 0 and dazs3648 is null
     then
       op_reg( 99, 0, 0, 0, p4_, dd.rnk, a3.nls, aa.kv, substr('Кр.заборг. за акцiєю. '|| aa.nms, 1,38), 'ODB', aa.isp, a3.acc) ;

       insert into DPT_ACCOUNTS (dptid,accid) values ( p_ID, a3.acc);

           update accounts
           set tobo = aa.branch,
           mdate = aa.mdate
           where acc = a3.acc;
     end if;

     select    *
     into       a3
     from     accounts
     where acc = a3.acc;

     begin
      select    ref
      into       ref_2636_3648
      from      oper
      where    nlsa = a2.nls and nlsb = a3.nls
      and       s =  rr.PENALTY_SUM * 100
      and       pdat >= dd.dat_begin
      and       sos > 0
      AND      ROWNUM = 1;
      exception when no_data_found then ref_2636_3648 := 0;
    end;

     if ref_2636_3648 = 0 then

         oo.ref := null;
         oo.s := rr.PENALTY_SUM * 100;
         oo.s2 := oo.s;
         oo.kv := a2.kv;
         oo.kv2 := a3.kv;
         oo.dk := 1;
         oo.nam_a:= a2.nms;
         oo.nlsa := a2.nls;
         oo.nam_b := a3.nms;
         oo.nlsb :=a3.nls;
         oo.d_rec:= 'Винагорода за залучення вкладу';
         oo.nazn  := substr(oo.d_rec||' '|| dd.nd, 1,160) ;

         opl1(oo);

         insert into dpt_payments(dpt_id, ref, kf, branch,rnk)
         values (rr.new_dpt_id, oo.ref, dd.kf, dd.branch, dd.rnk);
     end if;

     update dpt_political_instability set ref = nvl(oo.ref,ref_2636_3648) where NEW_DPT_ID = p_id ;
     update dpt_political_instability set acc_2636 = a2.acc where NEW_DPT_ID = p_id ;
     update dpt_political_instability set acc_3648 = a3.acc where NEW_DPT_ID = p_id ;

  end if;


end DPT_Ret_early  ;
/
show err;

PROMPT *** Create  grants  DPT_RET_EARLY ***
grant EXECUTE                                                                on DPT_RET_EARLY   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_RET_EARLY   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_RET_EARLY.sql =========*** End
PROMPT ===================================================================================== 
