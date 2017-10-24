

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_NLN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_NLN ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_NLN 
(flg_  SMALLINT      ,  -- ���� ������
 ref_  oper.ref%type ,  -- ����������
 VDAT_ oper.vdat%type,  -- ���� ������������
 tt_   oper.tt%type  ,  -- ��� ����������
 dk_   oper.dk%type  ,  -- ������� �����-������
 kv_   oper.kv%type  ,  -- ��� ������ �
 nlsm_ oper.nlsa%type,  -- ����� ����� �
 sa_   oper.s%type   ,   -- ����� � ������ �
 kvk_  oper.kv2%type ,  -- ��� ������ �
 nlsk_ oper.nlsb%type,  -- ����� ����� �
 ss_   oper.s2%type     -- ����� � ������ �
) is



---  ��������� ��� ������ ��������� ����-��, ���� ���������� ���� ��
---  ����� ����.����������:  1602/03, 2600/10, 2650/09, 2620/19


/*  SUF 14.05.2015
    ---------------

 ������ �� 1602/03, 2600/10, 2650/09, 2620/19 ����������� ��� �������
 ��        1919/05, 2603/06, 2603/06, 2622/07 ��������������, ������
 ���� ��� ������������ �� ����� ���� NLN � ������ ��������� 024 (����).
 -  ������� ����������� ��� �����-������ ���� NL7.
 -  ����� ������������, ���� �����-����� = 2608


    STA 26.05.2011
    ---------------
�i����i��� �� ����� �. 3.10 ����i�� 3 ��������� �����i��� ���i��������� ����� ������
�i� 10.08.2005 �. �280 "��� ������������ ������ i��������� i����������� � ������",
������������ � �i�i�������i �����i� ������ 29.08.2005�. �� �947/11227 (i� ��i����) :

1. ��� ��i� ����.���-���������� (��i� �����.� ������ 2900) ��
      1602/03, 2600/10, 2650/09, 2620/19 - ��� i��������� i��������
   ����� ��������� ����������� ���������� �� ��� ���� � ������ ��_����-����������
      1919/05, 2603/06, 2603/06, 2622/07 - ��� NLN (��� NL7)
                                                   ---------
2. � ���������� �i��� ��i������� �������� ��������� �i�����i���� ����� ������������ �����
   �   1919/05, 2603/06, 2603/06, 2622/07 - ��� NLN (��� NL7)
   ��  1602/03, 2600/10, 2650/����, 2620/19 - ��� i��������� i��������

3. � ���i �i��������i ��������i�, �� �i����������� ������i��i��� ��i������� ������i�
   ����� ������������ �  1919/05, 2603/06, 2603/06, 2622/07 - ��� NLN (��� NL7)
   ��  ������� �i���������.

*/

  -- ��� i��������� i��������
  l_nb_1602 accounts.nbs%type := '1602'; l_ob_1602 accounts.ob22%type := '03';
  l_nb_2600 accounts.nbs%type := '2600'; l_ob_2600 accounts.ob22%type := '10';
  l_nb_2650 accounts.nbs%type := '2650'; l_ob_2650 accounts.ob22%type := '09';
  l_nb_2620 accounts.nbs%type := '2620'; l_ob_2620 accounts.ob22%type := '19';

  -- ������������� ����� (��� NLN)
  l_nb_1919 accounts.nbs%type := '1919'; l_ob_1919 accounts.ob22%type := '05';
  l_nb_2603 accounts.nbs%type := '2603'; l_ob_2603 accounts.ob22%type := '06';
  ---------- ����
  l_nb_2622 accounts.nbs%type := '2622'; l_ob_2622 accounts.ob22%type := '07';
  l_tip     accounts.tip%type ;          l_rnkA    accounts.RNK%type  ;
  --------------------------
  l_nl2 accounts.nls%type  := nlsk_ ;
  l_nb1 accounts.nbs%type  := substr(nlsk_,1,4);
  --------------------------
  l_ob1 accounts.ob22%type ;
  l_nb2 accounts.nbs%type  ;
  l_ob2 accounts.ob22%type ;
  l_rnk accounts.rnk%type  ;
  --------------------------
begin

  l_nl2 :=  nlsk_ ;

  if l_nb1 not in ('1602','2600','2650','2620') then
     goto gl_PAYV;
  end if;

  Begin
    Select  ob22,rnk into l_ob1,l_rnk from accounts where kv=kv_ and nls=nlsk_;

    If tt_ ='024' then

       Select tip,rnk into l_tip,l_rnkA from accounts where kv=kv_ and nls=nlsm_;

       If l_rnk = l_rnkA   and
          (l_tip in ('NLN','NL7') or substr(nlsm_,1,4)='2608') then  --<-  ������ 14/05/2015
          goto gl_PAYV;
       End if;

    End if;

  Exception when NO_DATA_FOUND then
    goto gl_PAYV;
  End;
  ----------------------------

  If    l_nb1= l_nb_1602 and l_ob1= l_ob_1602 then l_nb2 := l_nb_1919; l_ob2 := l_ob_1919;
  elsIf l_nb1= l_nb_2600 and l_ob1= l_ob_2600 then l_nb2 := l_nb_2603; l_ob2 := l_ob_2603;
  elsIf l_nb1= l_nb_2650 and l_ob1= l_ob_2650 then l_nb2 := l_nb_2603; l_ob2 := l_ob_2603;
  elsIf l_nb1= l_nb_2620 and l_ob1= l_ob_2620 then l_nb2 := l_nb_2622; l_ob2 := l_ob_2622;
  else  goto gl_PAYV;
  end if;

  begin
     select nls into l_nl2  from accounts
     where kv   = kv_       and rnk  = l_rnk       and ob22 = l_ob2
       and nbs  = l_nb2     and dazs is null       and rownum = 1 ;
   exception when NO_DATA_FOUND then   raise_application_error(  -20203,
     '\9356 - PAY_NLN �� ������ ����: ���='|| l_nb2||' OB22='||l_ob2|| ' ��� ' || nlsk_,
      TRUE);
   end;
   <<gl_PAYV>> null;
                                                         ------
   gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_, l_nl2 , ss_);
                                                         ------
END PAY_NLN;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_NLN.sql =========*** End *** =
PROMPT ===================================================================================== 
