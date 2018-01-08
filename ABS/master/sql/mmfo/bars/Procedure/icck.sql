

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ICCK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ICCK ***

  CREATE OR REPLACE PROCEDURE BARS.ICCK ( MODE_ int  ) is

 -- 0.Первинне (до)Наповнення даними з КП
 -- 3.Вiдображення на 9819* результатiв iнтентаризацiї
 -- 2.Гляделка текущих расхождений (Просьба Л.Н. Винница)

/*
 26.08.2011 Сухова.
            Виявлено в Луцьку :
            При рзгорненнi Не враховувались кредити, що знаходяться на 3-му рiвнi.
            Виправлено.
*/

 l_branch branch.branch%type ;
 l_ostC   accounts.ostC%type ;
 l_ostB   accounts.ostB%type ;
 l_nls    accounts.nls%type  ;
 l_ob22   accounts.ob22%type ;
 l_9910   accounts.nls%type  ;
 l_9910s  accounts.nms%type  ;
 l_02 number; l_03 number; l_83 number; l_79 number; l_i3 number; l_b8 number;

 ref_  oper.REF%type   ;
 tt_   oper.TT%type    := 'VS1';
 vob_  oper.VOB%type   := 6;

 n2_   number ;
begin
 If Mode_ not in (0,2,3) then RETURN; end if;
 ------------------------------------------

 If mode_ in ( 0, 3 ) then
    l_branch := sys_context('bars_context','user_branch');

    If length (l_branch ) <>15 then
       raise_application_error(-20100,
           '\8999 Ваш Бранч '|| l_branch ||' не є бранчем другого рівня ');
    end if;
 end if;

 -------------------------------
 If Mode_ = 2 then

    -- 2.Гляделка текущих расхождений (Просьба Л.Н. Винница)
    EXECUTE IMMEDIATE 'TRUNCATE TABLE CCK_AN_TMP';

    insert into CCK_AN_TMP ( acc, BRANCH, nls, NLSALT, NAME1, n1,  POROG)
    select a.acc, a.branch, a.nls, a.ob22, substr(a.nms,1,35), -a.ostc/100,
          (select VAL+0 from BRANCH_PARAMETERS where tag='REF_ICCK' and branch=a.branch)
    from accounts a
    where a.dazs is null and a.NBS ='9819' AND a.OB22 IN ('02','79','83','03','I3','B8') ;
--  where a.dazs is null and a.NBS ='9819' AND a.OB22 IN ('02','79','83'     ) ;

    for k in (select acc, porog, branch from  CCK_AN_TMP )
    loop

       n2_ := null;

       If k.porog is not null then

          select - nvl( sum ( DECODE(oo.DK,0,-1,1)*oo.S ), 0) /100
          into n2_
          from opldok oo
          where oo.sos = 5 and oo.acc = k.acc and oo.ref >= k.porog
            and exists (select 1 from operw where tag='ND' and ref= oo.REF) ;

       end if;

       update CCK_AN_TMP
       SET
         name  = (select substr(name,1,30) from branch where branch=k.branch),
         n2    = n2_
        where  acc = k.acc;

    end loop;

    RETURN;

ElsIf Mode_ = 0 then
    -- 0.Первинне (до)Наповнення даними з КП
	--delete from nd_9819 where 15 != length(branch);
    insert into nd_9819 ( nd, k_02, k_03, k_83, k_79, branch)
               --Кредитнi~Угоди~02 = 1
               --      Страховi~Угоди~03 = null
               --            Iпотечнi~Угоди~83 = kolI
               --                      Iншi~Угоди~79     = kolz+kolp
    select d.nd, 1,   null, i.koli,  z.kolz+p.kolp, SYS_CONTEXT ('bars_context', 'user_branch') branch
    from cc_deal d,
     (select nd, count(distinct acc) KOLI from cc_accp where acc in
        (select acc  from accounts where dazs is null and nbs like '95%' and acc in
        (select acc  from pawn_acc where pawn in
        (select pawn from cc_pawn  where s031 in ('26','29','25','31' ) ) ) )
      group by nd
      ) i,
      (select nd, count(distinct acc) kolz from cc_accp where acc in
         (select acc  from accounts where dazs is null and nbs like '95%' and acc in
         (select acc  from pawn_acc where pawn in
         (select pawn from cc_pawn  where s031 NOT in ('26','29','25','31' ) ) ) )
       group by nd
      ) z,
      (select nd, count(distinct acc) kolP from cc_accp where acc in
         (select acc  from accounts where dazs is null  and nbs like '90%' )
       group by nd
      ) p
    where d.nd   = i.nd (+)
      and d.nd   = z.nd (+)
      and d.nd   = p.nd (+)
      and d.sos >= 10
      and d.sos  < 15
      and not exists (select 1 from nd_9819 where nd=d.ND and branch = SYS_CONTEXT ('bars_context', 'user_branch'))
	  and d.branch like case when SYS_CONTEXT ('bars_context', 'user_branch') like '/______/000000/' then substr(SYS_CONTEXT ('bars_context', 'user_branch'),1,8) else SYS_CONTEXT ('bars_context', 'user_branch') end||'%';

  elsIf Mode_ = 3 then

    -- 3.Вiдображення на 9819* результатiв iнтентаризацiї
    begin
      select nls into l_nls
      from accounts
      where nbs ='9819' and ob22 in ('02','03','83','79','I3','B8')
---   where nbs ='9819' and ob22 in ('02',     '83','79')
        and dazs is null
        and branch = l_branch
        and ostc <> ostb and rownum=1 ;
       raise_application_error(-20100,
           '\8999 По рахунку '|| l_nls ||' - плановий залишок не дорівнює фактичному залишку по рахунку.');
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;

    begin
     select ob22, kol  into l_ob22, ref_
     from (select ob22, count(*) kol from accounts
           where nbs ='9819'  and ob22 in ('02','03','83','79','I3','B8')
----       where nbs ='9819'  and ob22 in ('02',     '83','79')
             and dazs is null and branch = l_branch
             and ostc < 0   group by ob22  having count(*) >1)
     where rownum=1  ;
       raise_application_error(-20100,
        '\8999 У цьому бранчу'||l_branch || ' знайдено декілька рахунків 9819/'|| l_ob22 ||'(' || ref_ || ')' );
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;

    begin
      select r_02, r_03, r_83, r_79, r_i3, r_b8
      into   l_02, l_03, l_83, l_79, l_i3, l_b8
      from VR_9819
      where branch = l_branch
        and ( r_02<>0 or r_03<>0 or r_83<>0 or r_79<>0 or r_i3<>0 or r_b8<>0) ;
--      and ( r_02<>0 or            r_83<>0 or r_79<>0) ;
      raise_application_error(-20100,
          '\8999 Є розбіжності між результатами інвентаризації та залишками по рахункам 9819*');
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;

    begin
      select nls, substr(nms,1,38) into  l_9910, l_9910s
      from accounts
      where kv=gl.baseval
        and nbs= '9910' and ob22='01'
        and dazs is null
        and rownum=1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      raise_application_error(-20100,
          '\8999 Не знайдено контр.рахунок.9910/01');
    end;


begin
  delete from BRANCH_PARAMETERS where tag = 'REF_ICCK' and branch = l_branch;
  
  insert into BRANCH_PARAMETERS (val,tag, branch)
  select to_char(max(REF)) , 'REF_ICCK' , l_branch from oper;
exception  when others then
  --ORA-00001: unique constraint
  if sqlcode = -00001 then      null;  
                      else      raise;     
  end if;
end;


    for k in (select nls, ob22, substr(nls,1,38) NMS, -ostc S, isp
              from accounts
              where kv=gl.baseval
                and nbs ='9819' and ob22 in ('02','03','83','79','I3','B8')
---             and nbs ='9819' and ob22 in ('02',     '83','79')
                and dazs is null
                and branch = l_branch
                and ostc = ostb and ostc<0
              )
    loop
       gl.ref (REF_);
       gl.in_doc3(ref_  => REF_,
                  tt_    => TT_ ,
                  vob_   => VOB_,
                  nd_    => substr(to_char(REF_),1,10),
                  pdat_  => SYSDATE ,
                  vdat_  => gl.BDATE,
                  dk_    => 1,
                  kv_    => gl.baseval,
                  s_     => k.S,
                  kv2_   => gl.baseval,
                  s2_    => k.S,
                  sk_    => null,
                  data_  => gl.BDATE,
                  datp_  => gl.bdate,
                  nam_a_ => l_9910s ,
                  nlsa_  => l_9910  ,
                  mfoa_  => gl.aMfo,
                  nam_b_ => k.nms,
                  nlsb_  => k.nls,
                  mfob_  => gl.aMfo,
                  nazn_  => 'Згорнення.Iнвентаризацiя кредитних справ у сховищi '|| l_Branch,
                  d_rec_ => null,
                  id_a_  => null,
                  id_b_  => null,
                  id_o_  => null,
                  sign_  => null,
                  sos_   => 1,
                  prty_  => null,
                  uid_   => gl.auid
                  );

       gl.payv(flg_  => 0,
               ref_  => REF_ ,
               dat_  => gl.bDATE ,
               tt_   => TT_  ,
               dk_   => 1    ,
               kv1_  => gl.baseval,
               nls1_ => l_9910,
               sum1_ => k.s  ,
               kv2_  => gl.baseval ,
               nls2_ => k.nls,
               sum2_ => k.S );
	     
		 
		 gl.pay2(p_flag  => 2,
                 p_ref   => REF_ ,
                 p_vdat  => gl.bDATE );
			   
       for z in (select nd, nmk, decode(k.ob22,
                   '02',k_02,
                   '03',k_03,
                   '83',k_83, 
				   '79',k_79, 
				   'I3',k_i3,
				   'B8',k_b8,
				   0
                                        )*100 S
                 from vv_9819 where branch_cx like l_branch || '%' )
--исп.26.08.2011 from vv_9819 where branch =l_branch)

       loop
         If z.S >0 then
            gl.ref (REF_);
            gl.in_doc3(ref_  => REF_,
                       tt_   => TT_ ,
                       vob_  => VOB_,
                       nd_   => substr(to_char(REF_),1,10),
                      pdat_  => SYSDATE ,
                      vdat_  => gl.BDATE,
                      dk_    => 0,
                      kv_    => gl.baseval,
                      s_     => z.S,
                      kv2_   => gl.baseval,
                      s2_    => z.S,
                      sk_    => null,
                      data_  => gl.BDATE,
                      datp_  => gl.bdate,
                      nam_a_ => l_9910s ,
                      nlsa_  => l_9910  ,
                      mfoa_  => gl.aMfo,
                      nam_b_ => k.nms,
                      nlsb_  => k.nls,
                      mfob_  => gl.aMfo,
                      nazn_  => 'Розгорнення.Iнвентаризацiя кредитних справ у сховищi '|| l_Branch,
                      d_rec_ => null,
                      id_a_  => null,
                      id_b_  => null,
                      id_o_  => null,
                      sign_  => null,
                      sos_   => 1,
                      prty_  => null,
                      uid_   => gl.auid
                  );

            gl.payv(flg_  => 0,
                    ref_  => REF_ ,
                    dat_  => gl.bDATE ,
                    tt_   => TT_  ,
                    dk_   => 0    ,
                    kv1_  => gl.baseval,
                    nls1_ => l_9910,
                    sum1_ => z.s  ,
                    kv2_  => gl.baseval ,
                    nls2_ => k.nls,
                    sum2_ => z.S );

            insert into operw (ref,tag,value) values (REF_,'FIO',z.NMK );
            insert into operw (ref,tag,value) values (REF_,'ND' ,z.ND  );
           
		     gl.pay2(p_flag  => 2,
                     p_ref   => REF_ ,
                     p_vdat  => gl.bDATE );
			
         end if;
       end loop;

    end loop;

end if;

  --------------
commit;
---------------------

end ICCK ;
/
show err;

PROMPT *** Create  grants  ICCK ***
grant EXECUTE                                                                on ICCK            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ICCK            to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ICCK.sql =========*** End *** ====
PROMPT ===================================================================================== 
