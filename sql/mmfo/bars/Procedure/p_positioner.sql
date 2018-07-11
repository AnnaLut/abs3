PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_POSITIONER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_POSITIONER ***

create or replace procedure p_positioner(p_ref oper.ref%type, p_acc accounts.acc%type default null, p_type varchar2, p_103Bic varchar2 default null, p_202Bic varchar2 default null)
is
  l_rowacc  v_sw_corracc%rowtype;
  l_rowdocs v_sw_corracc_docs%rowtype;
  l_okpo_b customer.okpo%type;
  l_ref number;
  l_refl number;
  l_tabn staff$base.tabn%type;
begin
  if p_acc is not null
    then
   select t.* into l_rowacc from  v_sw_corracc t
   where t.acc=p_acc;
  end if;
  
  begin
   select t.* into l_rowdocs from v_sw_corracc_docs t
   where t.ref=p_ref;
  exception when no_data_found then
    raise_application_error(-20000, 'Документ № '||to_char(p_ref)||' вже оброблено!');
  end;
   
   select refl into l_refl from oper where ref=l_rowdocs.ref for update nowait;
   
  
   

 if p_type='DEL' then

  if l_rowdocs.mfoa=gl.aMFO then
  
    gl.pay_bck(p_ref, 5);
    
    INSERT INTO operw(ref,tag,value)
         VALUES(p_ref, 'BACKR', 'Повернено відділом коррахунків');

    UPDATE operw o SET o.value='-1' WHERE o.ref=p_ref AND o.tag='NOS_A';

    chk.PUT_NOS(p_ref,11);

    INSERT INTO oper_visa(ref, dat, userid, groupid, status)
        VALUES(p_ref, sysdate, user_id, 11, 3);
  else
    raise_application_error(-20000, 'Заборонено сторнувати документи чужого МФО! ');
  end if;

 elsif p_type='PAYCHECK' then

   if l_rowacc.kv!= l_rowdocs.kv
    then return;
   end if;
   
   if (l_refl is not null) then 
    return;
   end if;

   begin
    SELECT okpo
        INTO l_okpo_b
        FROM customer c,cust_acc u
    WHERE u.acc=l_rowacc.acc
      and u.rnk=c.rnk;
     exception when no_data_found then l_okpo_b:=f_ourokpo;
    end;

   select tabn into l_tabn from staff$base
   where id=user_id;

   gl.REF(l_ref);

    gl.in_doc3(ref_   => l_ref,
               tt_    => 'NOS',
               vob_   => 6,
               nd_    => l_rowdocs.nd,
               pdat_  => sysdate,
               vdat_  => case when l_rowdocs.vdat<bankdate then bankdate else l_rowdocs.vdat end,
               dk_    => 1,
               kv_    => l_rowdocs.kv,
               s_     => l_rowdocs.s*100,
               kv2_   => l_rowdocs.kv,
               s2_    => l_rowdocs.s*100,
               sk_    => null,
               data_  => bankdate,
               datp_  => bankdate,
               nam_a_ => l_rowdocs.nam_a,
               nlsa_  => l_rowdocs.nlsa,
               mfoa_  => l_rowdocs.mfoa,
               nam_b_ => substr(l_rowacc.nms,1,38),
               nlsb_  => l_rowacc.nls,
               mfob_  => gl.amfo,
               nazn_  => l_rowdocs.nazn,
               d_rec_ => l_rowdocs.d_rec,
               id_a_  => l_rowdocs.id_a,
               id_b_  => l_okpo_b,
               id_o_  => l_tabn,
               sign_  => null,
               sos_   => 1,
               prty_  => null,
               uid_   => user_id);

          paytt(flg_  => 0,
                ref_  => l_ref,
                datv_ => case when l_rowdocs.vdat<bankdate then bankdate else l_rowdocs.vdat end,
                tt_   => 'NOS',
                dk0_  => 1,
                kva_  => l_rowdocs.kv,
                nls1_ => l_rowdocs.nlsa,
                sa_   => l_rowdocs.s*100,
                kvb_  => l_rowdocs.kv,
                nls2_ => l_rowacc.nls,
                sb_   => l_rowdocs.s*100);

         p_nosw(l_rowdocs.ref,
                l_ref,
                l_rowacc.bic,
                l_rowacc.acc);


           UPDATE oper
           SET refl=l_ref
           WHERE ref=l_rowdocs.ref;

            bars_swift_msg.docmsg_process_document2(l_ref, '1');

 elsif p_type='PAY' then

   if l_rowacc.kv!= l_rowdocs.kv
    then return;
   end if;
   
   if (l_refl is not null) then 
    return;
    --raise_application_error(-20000, 'Nononon!');
   end if;

      begin
    SELECT okpo
        INTO l_okpo_b
        FROM customer c,cust_acc u
    WHERE u.acc=l_rowacc.acc
      and u.rnk=c.rnk;
     exception when no_data_found then l_okpo_b:=f_ourokpo;
    end;

   select tabn into l_tabn from staff$base
   where id=user_id;

   gl.REF(l_ref);

    gl.in_doc3(ref_   => l_ref,
               tt_    => 'NOS',
               vob_   => 6,
               nd_    => l_rowdocs.nd,
               pdat_  => sysdate,
               vdat_  => case when l_rowdocs.vdat<bankdate then bankdate else l_rowdocs.vdat end,
               dk_    => 1,
               kv_    => l_rowdocs.kv,
               s_     => l_rowdocs.s*100,
               kv2_   => l_rowdocs.kv,
               s2_    => l_rowdocs.s*100,
               sk_    => null,
               data_  => bankdate,
               datp_  => bankdate,
               nam_a_ => l_rowdocs.nam_a,
               nlsa_  => l_rowdocs.nlsa,
               mfoa_  => l_rowdocs.mfoa,
               nam_b_ => substr(l_rowacc.nms,1,38),
               nlsb_  => l_rowacc.nls,
               mfob_  => gl.amfo,
               nazn_  => l_rowdocs.nazn,
               d_rec_ => l_rowdocs.d_rec,
               id_a_  => l_rowdocs.id_a,
               id_b_  => l_okpo_b,
               id_o_  => l_tabn,
               sign_  => null,
               sos_   => 1,
               prty_  => null,
               uid_   => user_id);

          paytt(flg_  => 0,
                ref_  => l_ref,
                datv_ => case when l_rowdocs.vdat<bankdate then bankdate else l_rowdocs.vdat end,
                tt_   => 'NOS',
                dk0_  => 1,
                kva_  => l_rowdocs.kv,
                nls1_ => l_rowdocs.nlsa,
                sa_   => l_rowdocs.s*100,
                kvb_  => l_rowdocs.kv,
                nls2_ => l_rowacc.nls,
                sb_   => l_rowdocs.s*100);

         p_nosw(l_rowdocs.ref,
                l_ref,
                l_rowacc.bic,
                l_rowacc.acc);


           UPDATE oper
           SET refl=l_ref
           WHERE ref=l_rowdocs.ref;



 else
    raise_application_error(-20000, 'Не відомий тип операції, зверніться до розробника!');
 end if;
end;
/
show err;

PROMPT *** Create  grants  P_POSITIONER ***
grant EXECUTE                                                                on P_POSITIONER    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_POSITIONER.sql =========*** End 
PROMPT ===================================================================================== 
