
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bm_300465.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BM_300465 IS
----------------------------------
s3622_ varchar2(14) := '36229005'      ; -- ��
s3903_ varchar2(14) ;
FIO_   varchar2(50) ;
PIDSTAVA_  varchar2(100) ;

BAGS_  varchar2(5);
PASP_  varchar2(15);
PASPN_ varchar2(15);
ATRT_  varchar2(50);

------------------------------------
xx1_ char(3) :='013'; vob1_ int := 6 ; -- ������� ���� ���-���
xx2_ char(3) :='013'; vob2_ int := 6 ; -- ����.������ � ��� � �����i - ��� �� ����
xx3_ char(3) :='007'; vob3_ int := 6 ; -- �������� ������ ���-���
xx4_ char(3) :='Z13'; vob4_ int := 16; -- ���������
xx5_ char(3) :='Z17'; vob5_ int := 6 ; -- ������� � ����  ��
xx6_ char(3) :='007'; vob6_ int := 6 ; -- �������� ������ �� ��
xx7_ char(3) :='007'; vob7_ int := 6 ; -- ���

N_ number ;
E_ number ;
V_ number ;

ro oper%rowtype;
bm bank_metals%rowtype;
ks bm_nls%rowtype;
--------------------
PROCEDURE SET_NLS (
T varchar2,
D varchar2,
G varchar2,  -- 1. ʳ������ �������������� �����  - BAGS
F varchar2,
I varchar2,
P varchar2,  -- 2. ����������� ��������             - PASP
N varchar2, --- PASPN
A varchar2  -- - ATRT
) ;

---------------------
PROCEDURE SET_bm (p_kod bank_metals.kod%type);
--------------------
PROCEDURE SET_oper ;
--------------------
PROCEDURE pay_ro   ;
------------------------------------------------------
procedure RU  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type) ;
------------------------------------------------------
procedure FL  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type) ;
------------------------------------------------------
procedure upd_web (p_kod          bank_metals.kod%type,
                   p_kol          integer,
                   p_cena_prod    bank_metals.cena_prod%type);
------------------------------------------------------
END ;
/
CREATE OR REPLACE PACKAGE BODY BARS.BM_300465 IS

/*

18.03.2013 ������ �.�. <MrishukVV@oschadnybank.com>

1)   � �������
�����                 ������               ��.��
980  39036000147547  959  39036000147547  Z43  �������� �� \
980  39036000147547  959  39036000147547  Z43  �������� �� / ��� ���

959  11070904547     959  11014904547     Z41  �i������� �� �/� ���\
959  11070904547     959  11014904547     Z41  �i������� �� �/� ���/ ��� ���

980  10072903547     980  1001590959      Z42   ³������� ���. ���. �� �/� ���
980  3907....        980  1001590959      Z42   ³������� ���. ���. �� �/� ��� � �� ���

959  39036000147547  959  11070904547     Z44  �������� ������ �� �� \
959  39036000147547  959  11070904547     Z44  �������� ������ �� �� / ��� ���

980  39036000147547  980  10072903547     Z45  �������� ������ �� ���. ���. ��
���������

------------------

19.02.2013 ����� ������� <sharadowiy@oschadnybank.com>
   ������� ���������� �������� Z42 :
   ���� ���� ��������� ����� (�������� "������" = 0),
   �� ���� ����� �� ���� �������� �������������� ����� ��������������� �o ������� 3907

21.12.2012
 �� ���������� ����������������� �������� ������������� ����� ��������� ��������� �������� ������������� �����  3907 ��
 ���� ���� ���������� ������ ������� ������������� ����� - �� 3907 �� 1001


16.11.2012 ����� �� = ����� �������
09.11.2012 ��������� ���� ( p_R)  �������� � ���� ������� (bm.CENA_NOMI), ������ ��� ��������� ��� ���� ������
           ���� ��� ������ ���� �������������.

20.09.2012 Sta +�������. ������ ��������

���� ���   ���   ������   TT  Vob  Ck ���� ��	���� ���.����
-----------------------------------------------------------------
������� 3903/980 3903/959 Z43 71     �������� �/�  (������, ?��.������, �������� �� �����������, ����� * ����������) ���������� �� ��?��� ���������	���������
������� 1107/959 1101/959 Z41 156    �?������� �/�  (������, ?��.������, �������� �� �����������, ����� * ����������) ���������� �� ��?��� ���������	���������
������� 3903/959 1107/959 Z44 6      �������� ������ �� �/�  (������, ?��.������, �������� �� �����������, ����� * ����������) ���������� �� ��?��� ���������	���� �������������, ���������
������� 1007/980 1001/980 Z42 56  72 �?������� ���?���� �/�  (������, ?��.������, �������� �� �����������, ����� * ����������) ���������� �� ��?��� ���������	������ �������� 72,  ���������
������� 3903/980 1007/980 Z45 6      �������� ������ �� ���?���� �/�  (������, ?��.������, �������� �� �����������, ����� * ����������) ���������� �� ��?��� ���������	���� �������������, ���������

13.11.2012
�������	3903/980 3903/959 Z43 71     �������� �� �� ������ �ӻ  ������ �� � ��������  ����� � ������ �� 1 ��  * �ʳ������ ��.�  �����  �ϳ������
�������	1107/959 1101/959 Z41 156    ³������� �� �� ������ �ӻ  ������ �� � ��������  ����� � ������ �� 1 ��  * �ʳ������ ��.� ����� �ϳ������
�������	3903/959 1107/959 Z44 6      �������� ������ �� �� ������ �ӻ  ������ �� � ��������  ����� � ������ �� 1 ��  *�ʳ������ ��.�  ����� �ϳ������
�������	1007/980 1001/980 Z42 56  72 ³������� ���. ���. �� �� ������ �ӻ  ������ �� � ��������  ����� � ������ �� 1 �� * �ʳ������ ��.�  ����� �ϳ������
������� 3903/980 1007/980 Z45 6	     �������� ������ �� ���. ���. �� ������ �ӻ + ������ �� � ��������  ����� � ������ �� 1 ��* �ʳ������ ��.� ����� �ϳ������

*/
---------------------------------------------
PROCEDURE SET_NLS (
T varchar2,
D varchar2,
G varchar2,  -- 1. ʳ������ �������������� �����  - BAGS
F varchar2,
I varchar2,
P varchar2,  -- 2. ����������� ��������             - PASP
N varchar2, --- PASPN
A varchar2  -- - ATRT
)
    is
--������� � ���-����������
begin
  PUL.Set_Mas_Ini ( 'TTTT'     , T, '����_�������'         );
  PUL.Set_Mas_Ini ( 'DOROGA'   , D, '������=1/0'           );
  PUL.Set_Mas_Ini ( 'FIO'      , F, 'FIO'         );
  PUL.Set_Mas_Ini ( 'PIDSTAVA' , I, '�i������ ��� ������i�');
  PUL.Set_Mas_Ini ( 'BAGS'     , G, 'ʳ� ���.�����');
  PUL.Set_Mas_Ini ( 'PASP'     , P, '��������');
  PUL.Set_Mas_Ini ( 'PASPN'    , N, '���,�');
  PUL.Set_Mas_Ini ( 'ATRT'     , A, '�����');

end SET_NLS;
--------------------------------------------------
PROCEDURE SET_bm (p_kod bank_metals.kod%type)
  is
begin
  E_ := null;

  begin
    select * into bm from bank_metals where  kod = p_kod;
  exception when NO_DATA_FOUND THEN
    raise_application_error(-20100, '��� ������ '||p_kod|| '�� ��������');
  end;

  begin
     select * into ks from bm_nls
     where kv= bm.kv and tip = bm.type_ and pdv= nvl(bm.pdv,0);
  exception when NO_DATA_FOUND THEN
    raise_application_error(-20100, '��� ������ '||p_kod|| ' ������� �� ��������');
  end;


  E_:= round(bm.VES_UN *1000/10,0) ;


end set_bm ;
----------------------------------------------------
PROCEDURE SET_oper
  is
begin

  insert into tts(tt, name)
  select ro.tt, ro.tt|| ' XXX' from dual
  where not exists (select 1 from tts where tt=ro.TT);


  gl.ref (ro.REF);
  ro.nd := nvl(substr(to_char(ro.REF),-10),'1');
  ro.kv2 := nvl(ro.kv2, ro.kv);

logger.info('BM-2 '|| ro.nlsa || ',' || ro.kv || ' ,' || ro.nlsb|| ', '|| ro.kv2);

  begin
    select trim(substr(a.nms,1,38)), ca.okpo, trim(substr(b.nms,1,38)), cb.okpo
    into ro.nam_a, ro.id_a,  ro.nam_b, ro.id_b
    from accounts a, customer ca, accounts b, customer cb
    where a.dazs is null and a.nls=ro.nlsa and a.rnk=ca.rnk and a.kv=ro.kv
      and b.dazs is null and b.nls=ro.nlsb and b.rnk=cb.rnk and b.kv=ro.kv2;
  exception when NO_DATA_FOUND THEN
    raise_application_error(-20100, '�� �������� ��� '||
                         ro.nlsa ||'/'||ro.kv  || ', '||
                         ro.nlsb ||'/'||ro.kv2 );
  end;
end SET_oper;

------------------
PROCEDURE pay_ro
  is
begin
  SET_oper;
logger.info('BM-1 '|| ro.tt || ','||ro.vob||' ,' || ro.kv || ' ,' || ro.nlsa || ', '|| ro.s || ','||  ro.kv2 || ',' || ro.nlsb || ', '|| ro.s2);
  gl.in_doc3(ref_  => ro.REF   , tt_   => ro.tt   , vob_  => ro.vob  ,
             nd_   => ro.nd    , pdat_ => SYSDATE , vdat_ => ro.VDAT , dk_ => 1,
             kv_   => ro.kv    , s_    => ro.s    ,
             kv2_  => ro.kv2   , s2_   => ro.s2   ,
             sk_   => ro.sk    , data_ => gl.BDATE, datp_ => gl.bdate,
             nam_a_=> ro.nam_a , nlsa_ => ro.nlsa , mfoa_ => gl.aMfo ,
             nam_b_=> ro.nam_b , nlsb_ => ro.nlsb , mfob_ => gl.aMfo ,
             nazn_ => substr( ro.nazn,1,160),
             d_rec_=> null, id_a_ => ro.id_a, id_b_ => ro.id_b, id_o_ => null,
             sign_ => null, sos_  => 1,       prty_ => null,    uid_  => null);


  gl.payv(0,ro.REF,ro.VDAT,ro.tt,1, ro.kv,ro.nlsa,ro.s, ro.kv2,ro.nlsb,ro.s2);


  If BAGS_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'BAGS', BAGS_  );
  end if;

  If PASP_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'PASP', PASP_  );
  end if;

  If PASPN_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'PASPN', PASPN_);
  end if;

  If ATRT_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'ATRT', ATRT_  );
  end if;

  If FIO_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'FIO' , FIO_   );
  end if;


end pay_ro;
---------------------
procedure RU  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type)
  Is
  doroga_ varchar2(10);
  name_ru varchar2(38);
begin

  --������ �������
  set_bm (p_kod);

  --������ ���� � ������
  s3903_    := pul.get_mas_ini_val ('TTTT'     ) ;
  FIO_      := pul.get_mas_ini_val ('FIO'      ) ;
  PIDSTAVA_ := pul.get_mas_ini_val ('PIDSTAVA' ) ;
  doroga_   := pul.get_mas_ini_val ('DOROGA'   ) ;

  BAGS_  := substr(pul.get_mas_ini_val ('BAGS' ) ,1,5);
  PASP_  := substr(pul.get_mas_ini_val ('PASP' ) ,1,15);
  PASPN_ := substr(pul.get_mas_ini_val ('PASPN') ,1,15);
  ATRT_  := substr(pul.get_mas_ini_val ('ATRT' ) ,1,50);


  begin
    select substr(c.nmk,1,38) into name_ru from accounts a, customer c where a.kv=980 and a.nls=s3903_ and a.rnk=c.rnk;
--  select substr(nms,1,38)   into name_ru from accounts               where   kv=980 and nls = s3903_;
  exception when NO_DATA_FOUND THEN  name_ru := null;
  end;

  -------- 1. Z43  ��������� --------------------------
  ro.nlsa := s3903_      ;  ro.nlsb := s3903_     ;
  ro.tt   := 'Z43'       ;  ro.vob  := 71         ;
  ro.sk   := null        ;
  ro.kv   := 980         ;  ro.kv2  := bm.kv      ;
  ro.VDAT := gl.bdate    ;
  -- ��������� ���� ( p_R)  �������� � ���� ������� (bm.CENA_NOMI)
  -- ������ ��� ��������� ��� ���� ������
  ro.s    := ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl;
  ro.s2   := E_ * p_KOL  ;
  ro.nazn := Substr('�������� �� �� ' || trim(name_ru)  || ' ' ||   trim(bm.name) || ' '        ||
                     to_char(bm.VES)  || ' ��. * ' || to_char(p_kol)   || ' ��. ' || '��i��� '  || trim(PIDSTAVA_)
                     ,1,160);
  pay_ro  ;

  -------- 2.Z41 ������� ���� �� -----------------------
  If doroga_ = '1' then ro.nlsa := ks.s1107      ;
  else                  ro.nlsa := s3903_        ;
  end if;

  ro.nlsb := ks.s1101   ;
  ro.VDAT := gl.bdate   ;
  ro.tt   := 'Z41'      ;  ro.vob  := 156        ;
  ro.sk   := null   ;
  ro.kv   := bm.kv      ;  ro.kv2  := bm.kv      ;
  ro.s    := E_ * p_KOL ;  ro.s2   := E_ * p_KOL ;

  If doroga_ = '1' then
    -- � ������ �������� ����� ���������� �������������� ����� (������ = 1) �� ��������� Z41, Z42:
    -- ���������� �������� ����� ������� ��� (����� ��)� �������� ����� ��/� ��ѻ

     ro.nazn := Substr('�i������� �� �/� ��� �� ' || trim(name_ru)     || ' '     || trim(bm.name) || ' '       ||
                        to_char(bm.VES) || ' ��. * ' || to_char(p_kol) || ' ��. ' || '��i��� '     || trim(PIDSTAVA_)
                        ,1,160);
  else
     --	� ������ ����������  �������������� ����� (������ = 0)  ��� �������� Z41 � Z42
     --1. ���������� ������� ������ ���������� �� ���� ������� �� (����� ��)�, � �� �³������� �� �� (����� ��)�
     --2. ������ � ��������� ��������� � ���.���� �������� ����� �������� ����������/�������  -  ��� =FIO.

     ro.nazn := Substr('������ �� ' || trim(name_ru)   || ' ' ||  trim(bm.name)   || ' '     ||
                        to_char(bm.VES)          || ' ��. * ' || to_char(p_kol)   || ' ��. ' ||  '��i��� '  || trim(PIDSTAVA_)
                        ,1,160);
  end if;

  pay_ro  ;

  --------- 3. Z44 �������� ������ �� �� ------------------
  If doroga_ = '1' then
     ro.nlsa := s3903_    ;    ro.nlsb := ks.s1107     ;
     ro.kv   := bm.kv     ;    ro.kv2  := bm.kv        ;
     ro.VDAT := Dat_Next_U(gl.bdate,1) ;
     ro.sk   := null ;
     ro.s    := E_ * p_KOL;    ro.s2   := E_ * p_KOL   ;
     ro.tt   := 'Z44'     ;    ro.vob  := 6            ;
     ro.nazn := Substr('�������� ������ �� �� ' || trim(name_ru)    || ' '     ||  trim(bm.name)     || ' '       ||
                     to_char(bm.VES) || ' ��. * ' || to_char(p_kol) || ' ��. ' ||  '��i��� '         || trim(PIDSTAVA_)
                     ,1,160);
     pay_ro  ;
  end if;

  -- ���-���
  N_ := nvl(bm.CENA_NOMI,0) * p_kol ;


  If N_ > 0 then
     ----- 4. Z42 ������� ����--------------------
     --980  3907....        980  1001590959      Z42   ³������� ���. ���. �� �/� ��� � �� ���
     -- ������ 3907 !!!!!!

     begin
        select nls_3907 into             ro.nlsa  from bm_3903 where nls =s3903_;
     exception when NO_DATA_FOUND THEN  ro.nlsa := s3903_  ;
     end;

     ro.nlsb := ks.s1001   ;
     ro.VDAT := gl.bdate   ;
     ro.kv   := gl.baseval ;  ro.kv2  := gl.baseval ;
     ro.s    := N_         ;  ro.s2   := N_         ;
     ro.tt   := 'Z42'      ;  ro.vob  := 56         ;
     ro.sk   := 72         ;

     If doroga_ = '1' then
       -- � ������ �������� ����� ���������� �������������� ����� (������ = 1) �� ��������� Z41, Z42:
       -- ���������� �������� ����� ������� ��� (����� ��)� �������� ����� ��/� ��ѻ
        ro.nazn := Substr('³������� ���. ���. �� �/� ��� �� ' || trim(name_ru)   || ' ' || trim(bm.name)  || ' ' ||
                     to_char(bm.VES)   || ' ��. * ' || to_char(p_kol)  || ' ��. ' || '��i��� '  || trim(PIDSTAVA_)
                     ,1,160);

     else
        --	� ������ ����������  �������������� ����� (������ = 0)  ��� �������� Z41 � Z42
        --1. ���������� ������� ������ ���������� �� ���� ������� �� (����� ��)�, � �� �³������� �� �� (����� ��)�
        --2. ������ � ��������� ��������� � ���.���� �������� ����� �������� ����������/�������  -  ��� =FIO.
        ro.nazn := Substr('������ ���. ���. �� ' || trim(name_ru)   || ' '     || trim(bm.name) || ' '       ||
                   to_char(bm.VES)  || ' ��. * ' || to_char(p_kol)  || ' ��. ' || '��i��� '     || trim(PIDSTAVA_)
                     ,1,160);

     end if;

     pay_ro  ;

/*
     If doroga_ = '1' then
        ----------- 5. Z45 �������� ������ ���-��� ----------------------
        ro.nlsa := s3903_     ;  ro.nlsb := ks.s1007   ;
        ro.kv   := gl.baseval ;  ro.kv2  := gl.baseval ;
        ro.s    := N_         ;  ro.s2   := N_         ;
        ro.tt   := 'Z45'      ;  ro.vob  := 6          ;  ro.sk := null ;
        ro.VDAT := Dat_Next_U(gl.bdate,1);
        ro.nazn := Substr('�������� ������ �� ���. ���. �� ' || trim(name_ru) || ' '       ||   trim(bm.name)   || ' ' ||
                   to_char(bm.VES) || ' ��. * ' || to_char(p_kol) || ' ��. '  || '��i��� ' || trim(PIDSTAVA_ )
                     ,1,160);
        pay_ro  ;
     end if;
 */

  end if;

  -------- 6. ��� -------��� �� �������� !!!!!---
  ---------------------------------
  If s3903_ like '39%' then  bm.pdv := 0;
  else                       bm.pdv := nvl(bm.pdv,0);
  end if;

  If bm.pdv = 1 then

     V_ := round( 0.2 * ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl,0) ;

     ro.VDAT := gl.bdate   ;
     ro.nlsa := s3903_     ; ro.nlsb := s3622_     ;
     ro.kv   := gl.baseval ; ro.kv2  := gl.baseval ;
     ro.s    := V_         ; ro.s2   := V_         ;
     ro.tt   := XX7_       ; ro.vob  := VOB7_      ;
     ro.sk   := null       ;
     ro.nazn := Substr(trim(bm.name)|| ' ' || p_kol || '��. ���',1,160);
     pay_ro  ;
  end if;


end RU;

--------------------------------------------------------
procedure FL  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type)
  Is
begin
  --������ �������
  set_bm (p_kod);

  --������ ���� � ������
  s3903_    := pul.get_mas_ini_val ('TTTT')  ;
  FIO_      := pul.get_mas_ini_val ('FIO'  ) ;
  PIDSTAVA_ := pul.get_mas_ini_val ('PIDSTAVA' ) ;

  -- ���������
  ro.tt   := '013'       ;  ro.vob  := 16         ;
  ro.VDAT := gl.bdate    ;

  ro.nlsa := s3903_      ;  ro.nlsb := ks.s1101   ;
  ro.kv   := 980         ;  ro.kv2  := bm.kv      ;
  ro.s    := ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl;
  ro.s2   := E_ * p_KOL  ;
  ro.sk   := 30          ;
  ro.nazn := Substr(bm.name|| ' ' || p_kol || '��. �������i�.',1,160);
  pay_ro  ;

  -- ���
  bm.pdv := nvl(bm.pdv,0);

  If bm.pdv = 1 then
     V_ := round( 0.2 * ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl,0) ;
     ro.VDAT := gl.bdate   ;
     ro.nlsa := s3903_     ; ro.nlsb := s3622_     ;
     ro.kv   := gl.baseval ; ro.kv2  := gl.baseval ;
     ro.s    := V_         ; ro.s2   := V_         ;
     ro.tt   := XX7_       ; ro.vob  := VOB7_      ;
     ro.sk   := 30         ;
     ro.nazn := Substr(bm.name|| ' ' || p_kol || '��. ���',1,160);
     pay_ro  ;
  end if;

  -- ���-���
  N_ := nvl(bm.CENA_NOMI,0) * p_kol ;
  If N_ > 0 then
     -- ������� ����
     ro.VDAT := gl.bdate   ;
     ro.nlsa := s3903_              ;     ro.nlsb := ks.s1001   ;
     ro.kv   := gl.baseval          ;     ro.kv2  := gl.baseval ;
     ro.s    := N_                  ;     ro.s2   := N_         ;
     ro.tt   := '013'               ;     ro.vob  := VOB1_      ;
     ro.sk   := 73                  ;
     ro.nazn := Substr(bm.name|| ' ' || p_kol || '��.�������� ���-��� � ����',1,160);
     pay_ro  ;
  end if;

end FL;

procedure upd_web (p_kod          bank_metals.kod%type,
                   p_kol          integer,
                   p_cena_prod    bank_metals.cena_prod%type)
is
   l_nlst   accounts.nls%type;
begin
   l_nlst := pul.get_mas_ini_val ('TTTT');

   if l_nlst like '1001%'
   then
      bm_300465.fl (p_kod, p_kol, p_cena_prod);
   else
      bm_300465.ru (p_kod, p_kol, p_cena_prod);
   end if;
end upd_web;
------------------------------------------------
end ;
/
 show err;
 
PROMPT *** Create  grants  BM_300465 ***
grant EXECUTE                                                                on BM_300465       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BM_300465       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bm_300465.sql =========*** End *** =
 PROMPT ===================================================================================== 
 