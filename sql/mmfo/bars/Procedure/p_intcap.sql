

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INTCAP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INTCAP ***

  CREATE OR REPLACE PROCEDURE BARS.P_INTCAP (dat_ date) is
  acc1_  accounts.acc%type;
  nlsk_  oper.nlsb%type   ;
  s2_    oper.s2%type     ;
  ref_   oper.ref%type    ;
  tt_    oper.tt%type     ;
  l_s    oper.s%type      ;
  s_ostc oper.s2%type     ;
----------------------------------------------------------------------------
---
---                        � � � � � � � � !
---                        =================
---
---   ������� �������� ������ �����, ����� � ��������� �� ���������� %%
---   (�������� %%1) ����� "����������� �������" ���������� ���:
---
---                    %% �� ���. �����������              ,
---
---   � ��             %% �� ����� �����������
---
---   ��� ����� ���.�����, ������� ��������� %%, ������ ���� ���������
---   "������"/"������������"/"����i ���������":
---
---        ID ���� i���������      =          UKR       (�� RUS !!!)
---
----------------------------------------------------------------------------
begin

 ACC1_ := null;
 -- ���� k1 �� ���������� �� ���������� %%
 for k in (select a.NLS,o.kv,o.nlsa,o.s,o.nam_a, o.nazn, o.id_a, a.acc, i.acra,
                  nvl(i.okpo, c.okpo )           OKPOB,
                  nvl(i.nlsb, a.nls )            NLSB ,
                  nvl(i.kvb , o.kv  )            KVB  ,
                  nvl(i.mfob,gl.amfo)            MFOB ,
                  substr(nvl(i.namb,c.nmk),1,38) NAMB ,
                  o.ref
           from oper o , accounts a, customer c, int_accn i
           where o.tt = '%%1'
             and o.sos = 5
             and o.vdat= dat_
             and o.dk  = 0
             and substr(o.nlsb, 1, 1) = '7'
             and a.kf  = o.kf                ---<--- !!!
             and a.kv  = o.kv
             and (
                  substr (o.nazn, 11,1)= ' '   and
                  a.nls = substr(o.nazn,12,instr(substr(o.nazn,12,15),' ')-1)
                   or
                  substr (o.nazn, 12,1)= ' '   and
                  a.nls = substr(o.nazn,13,instr(substr(o.nazn,13,15),' ')-1)
                 )
             and a.dazs is null
             and a.rnk = c.rnk
             and i.acc = a.acc
             and i.id  = 1
             and (i.APL_DAT is null  or  i.APL_DAT < dat_)
             and trim(nvl(i.NAMB,'0'))<>'N'  and  trim(nvl(i.NLSB,'0'))<>'N'
             and not exists (select 1 from dpu_deal d where d.acc = a.acc)
             and exists (select 1 from int_cap where nbs = a.nbs and
                           ( ob22 like '%*%' or ob22 = a.ob22)
                         )
          order by 1, 2
            )
 loop
    If acc1_ is not null and  acc1_  <> k.acc then
       update int_accn set apl_dat = dat_   where acc = acc1_ and id = 1;
    end if;
    acc1_ := k.acc;
    nlsk_    := NULL ;

    tt_      := '024';           ---<--  024 - ���������� ������� !!!

    If k.acra = k.acc  OR
       k.mfob = gl.amfo and k.kvb = k.kv and k.nlsb = k.nlsa  then null;
       --������� 1 (acra=acc) �������� �����:
       --������� 4 �������� �����  -- C��� ������� = ��� ����
    else
       --������� 2 ������� �����   -- ����������� �� ��� ���.����
       --������� 3 ������� �����
       nlsk_ := k.nlsb;
       If k.mfob<> gl.amfo then
          tt_ := 'PS2';          ---<--  PS2 - ������������� ������� !!!
       end if;
    end if;

    If NLSK_ is not null then


       select OSTC
       into   s_ostc
       from   Accounts
       where  ACC=k.acra;

       select sum(s*decode(dk,1,1,-1))
       into   l_s
       from   opldok
       where  ref = k.ref
         and  acc = k.acra;

       l_s := least(l_s,s_ostc);


       if k.kv = k.kvb then s2_ := l_s;                              -- �1 - �1
       elsif k.kv=980 then  s2_ := gl.p_ncurval(k.kvb,l_s,gl.bdate); -- ���-���
       else                 s2_ := gl.p_icurval(k.kv, l_s,gl.bdate); -- ���-���
       end if;

       gl.ref (ref_);


       -----------------
       SAVEPOINT DO_OPL;  -- ����� ������-1. ������ �� �����
       -----------------
       begin
          gl.in_doc3(ref_   => REF_,
                     tt_    => TT_ ,
                     vob_   => 6 ,
                     nd_    => substr(to_char(REF_),1,10),
                     pdat_  => SYSDATE ,
                     vdat_  => gl.BDATE,
                     dk_    => 1,
                     kv_    => k.kv,
                     s_     => l_s,
                     kv2_   => k.kvb,
                     s2_    => S2_,
                     sk_    => null,
                     data_  => gl.BDATE,
                     datp_  => gl.bdate,
                     nam_a_ => k.nam_a ,
                     nlsa_  => k.nlsa,
                     mfoa_  => gl.aMfo,
                     nam_b_ => k.NAMB ,
                     nlsb_  => NLSK_,
                     mfob_  => k.MfoB,
                     nazn_  => substr ('������� ' || k.nazn, 1, 160),
                     d_rec_ => null,
                     id_a_  => k.id_a,
                     id_b_  => k.okpob,
                     id_o_  => null,
                     sign_  => null,
                     sos_   => 1,
                     prty_  => null,
                     uid_   => null);

          paytt(flg_  => 0,
                ref_  => REF_ ,
                datv_ => gl.bDATE ,
                tt_   => TT_   ,
                dk0_  => 1     ,
                kva_  => k.kv  ,
                nls1_ => k.nlsa,
                sa_   => l_s   ,
                kvb_  => k.kvb ,
                nls2_ => nlsk_,
                sb_   => S2_  );

          If tt_ = '024'  then   ---<-- ��������� �������
             ------------------
             SAVEPOINT DO_fakt;  -- ����� ������-2 . ������ �� �����
             ------------------
             begin
               gl.PAY (2, ref_, gl.bdate);  --<-  s������ ������ �� ����� (��� ���)
             EXCEPTION  WHEN OTHERS THEN  ROLLBACK TO DO_fakt;
             END;
          end if;

       EXCEPTION  WHEN OTHERS THEN  ROLLBACK TO DO_OPL;
       END;

    end if; -- ������

  end loop;

  If acc1_ is not null then
     update int_accn set apl_dat = dat_   where acc = acc1_ and id = 1;
  end if;

end p_intcap;
/
show err;

PROMPT *** Create  grants  P_INTCAP ***
grant EXECUTE                                                                on P_INTCAP        to BARS010;
grant EXECUTE                                                                on P_INTCAP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_INTCAP        to DPT_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INTCAP.sql =========*** End *** 
PROMPT ===================================================================================== 
