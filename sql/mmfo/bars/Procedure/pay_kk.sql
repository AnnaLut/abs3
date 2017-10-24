

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_KK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_KK ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_KK 
               (flg_ SMALLINT,  -- ���� ������
                ref_ INTEGER,   -- ����������
               VDAT_ DATE,      -- ���� ������������
                 tt_ CHAR,      -- ��� ����������
                dk_ NUMBER,    -- ������� �����-������
                kv_ SMALLINT,  -- ��� ������ �
               nlsm_ VARCHAR2,  -- ����� ����� �
                 sa_ DECIMAL,   -- ����� � ������ �
                kvk_ SMALLINT,  -- ��� ������ �
               nlsk_ VARCHAR2,  -- ����� ����� �
                 ss_ DECIMAL    -- ����� � ������ �
) IS
/*
25.03.2016 ������ �� ������
1)    ��.� �� ����� ��.�   ��� ��
2)    ���-� �� ��.����


���� ������� ����������� � ��������� ��������:
1) ������������� ����� �� ����� 2620 �� �� ��� � ����-��� ������� ���������, �.�. � �� , � ��� �������� 2620
2) ������������� ����� � 2620 �� ����-�� ������� � ����� ������� �����.
   ��� ���� �������, ����� ������: ��� ������ = 3 ���� 6110/10

22.03.2016 ����������/�������� - ������ �� ����� SS   - (��  ����� �� ���������) !
21.03.2016 ������ COBUSUPABS-4313
1. �� ��  � ������ ������ ������� � ����������� ������� �� �������� ������� 2620 (���� ��������������� ��� �������������� �������)
2. ��� ������� ��2 ��������� �����  (�.1.1.2.1. ����� ������� �� ������� ������� �� ���������)

   ��������  ������� ������ ��� ������������ �� ������� ��
   ��� ������ = 3
   ���� 6110/10
   ����� ��� �� ����� 2620
   �� ���� ����������� ������� ( �� �� ����� �������)
   ��� ���������� ������������� �� ������ ����������� - ������� �� ������������ ��������

*/
  l_Kod   tarif.kod%type      :=  3     ;
  l_nbs   accounts.nbs%type   := '6110' ;
  l_ob    accounts.ob22%type  := '10'   ;
  l_tag   operw.tag%type      := 'KTAR ';
  l_ttK   tts.tt%type         := 'KK1'  ;
  l_ttD   tts.tt%type         := 'D06'  ;
  -----------------------------
  l_ND    nd_acc.nd%type      ;
  l_br    accounts.branch%type;
  l_nls26 accounts.nls%type   ;
  l_nls61 accounts.nls%type   ;
  l_s     oper.s%type         ;
  -----------------------------
begin  ------���� �� "����-2620" ?
  begin

     select n.nd             into l_ND          from nd_acc n, accounts a
     where n.acc=a.acc and a.kv=kv_ and a.nls = nlsm_ and a.dazs is null and rownum = 1 and a.tip = 'SS ' ;

     select a.nls, a.branch  into l_nls26, l_br from nd_acc n, accounts a
     where n.acc=a.acc and a.kv=kv_ and a.nbs= '2620' and a.dazs is null and rownum = 1 and n.nd  = l_ND and a.nls <> nlsk_ ;


     gl.payv ( flg_, ref_, VDAT_, l_ttK, 1, kv_,   nlsm_, sa_, kv_, l_nls26, sa_ );
     gl.payv ( flg_, ref_, VDAT_, tt_, 1, kv_, l_nls26, sa_, kv_,   nlsk_, sa_ );


     begin select f_tarif ( l_Kod, kv_, l_nls26, sa_, 0, null) ,    nbs_ob22_bra ( l_nbs, l_ob, substr( l_br,1,15) )
           into l_s, l_nls61
           from dual
           where  not exists (select 1 from banks_ru where mfo = GL.doc.mfob) -- ���-� �� ��.����
              OR  gl.doc.id_a <> gl.doc.id_b  ;                               -- ��.� �� ����� ��.�
           if l_nls61 is null  then
              raise_application_error(-20203,'PAY_KK:
�� �������� ������� 6110 ��� �������� '||substr( l_br,1,15));
           end if;
           if l_s >=1  then
              gl.payv ( flg_, ref_, VDAT_, l_ttD, 1, kv_, l_nls26, l_s, gl.baseval,  l_nls61, gl.p_icurval(kv_, l_s, gl.bdate) );
           end if;
           update operw set value = to_char(l_kod) where ref = gl.aRef and tag = l_tag;
           if SQL%rowcount = 0 then insert into operw (ref,tag, value) values (Ref_, l_tag, to_char(l_kod) ) ;  end if;

     EXCEPTION WHEN NO_DATA_FOUND THEN  null;
     end;

EXCEPTION WHEN NO_DATA_FOUND THEN    gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);
END;

END PAY_KK;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_KK.sql =========*** End *** ==
PROMPT ===================================================================================== 
