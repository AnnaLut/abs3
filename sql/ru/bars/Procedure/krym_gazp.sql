

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KRYM_GAZP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KRYM_GAZP ***

  CREATE OR REPLACE PROCEDURE BARS.KRYM_GAZP ( pp_DAT  date )  is

/*
�� 08.05.2012 10:14  Legostaeva Mariya [m_a_l@ukr.net]
   ���������� ��������� "������" ��� ���� �� ��
   ��� ����� ���=322669
   ������ ���=335106 ���� ����� "2603_30_384022"
----------------------------

24-01-2012
krym_gazR.n=S1 \                / ������
            S3 | - ��� = ������ | ���������
            S5 /                \ ��� ( i�.������ )
      ����� S� |                | . . . .

            S2 \                / ������
            S4 | - ��� �����    | ���������
            S6 /                \ ��� ( i�.������ )
        ��� S� |                | . . . .

����������� ���� krym_gazR.n = SI
���� I - ����� (�.�. 1,3,5,7, . . ., �� ��� = ������,
���� I -   ��� (�.�. 2,4,6,8, . . ., �� ��� = �����
---------------------------------------------------

16-11-2011
krym_gazR.n=S1 \                / ������
            S3 | - ��� = ������ | ���������
            S5 /                \ ���

            S2 \                / ������
            S4 | - ��� �����    | ���������
            S6 /                \ ���

10-11-2011 � ����� ��������� ��� ���� ����
 � ��� ������� 2 ����� ��������
   260323001626 - ���������
   260313011626 - ������

   ��������� ����� ����       26030300022627   - ���
   ������� ������������� c ����� �����:
   �� ��� ��������  �� �����  -( 26039301045660 - ��� 324805) � � ��� - 384049
   ��� ������

   � ��������� ����������� - �����  � �����  .

--------------------------------------------
23-08-2011 ��� �� ��_� ������� ������� !
           ���� 324805
           ���� 384049
09-06-2011 �������� ����/� ����� DEL <>0 (���� >0)
-------------------------------------------------------
04-05-2011 ����� ���������� �� ����� �������, ������� � ����������
08-12-2010 ������ ����� ����� ����������� ����������� �� 0,5 ���, �.� ������ ��� �����������
  - ��� ���� � ����������� ������������� ��������, ��� �� ����� - ������.
  ����������.
� ��� ������� 2 ����� ��������
  260323001626   - ���������
  260313011626   - ������
����� �������������� ����� ������ :
��������� �� ->( ����� � ������)
������    �� ->( ����� � ������)
*/

--l_BUD accounts.NLS%type;  l_NAS accounts.NLS%type; l_BTE accounts.NLS%type;
  p_DAT  date   := pp_DAT;  l_dat1 date   ;
  vosto_ number ;           zapad_ number ;
  del_   number ;           l_ost  number ;

BEGIN

/*
  If gl.amfo = '322669'   then   -- � � � �------
     l_BUD  := '26035302270'   ; --        ������
     l_NAS  := '26036301270'   ; --        ���������
     l_BTE  := '2'             ; --        ���
  else                           -- � � � �------
     l_BUD  := '260313011626'  ; --        ������
     l_NAS  := '260323001626'  ; --        ���������
     l_BTE  := '26030300022627'; --        ���
  end if;
*/

  --������� ���.����
  select  max(fdat) into l_dat1 from  fdat where fdat < p_DAT  and fdat not in (select holiday from holiday where kv=980) ;

  delete from KRYM_GAZT;

  for k in (select a.kv, a.nls, a.nms, c.okpo, a.acc, rownum*100 RN,
                   fost(a.acc, l_dat1)         OST  ,  -- ������� �� �����
                   fdos(a.acc, p_DAT, p_DAT  ) DOS  ,  -- ��� ������� �� �������
                   fkos(a.acc, l_dat1,l_dat1 ) KOS     -- ��� ������� �� �����
           from accounts a, customer c
           where a.kv  = 980   and a.nls in ( select nls from KRYM_GAZR)
             and a.rnk = c.rnk and a.dazs is null
             and a.ostc  > 0   and a.ostc =  a.ostb
           )
  loop
     If k.dos=0 and k.kos >0  then  vosto_ := 0; zapad_ := 0;  l_ost  := k.OST ;
        for d in (select o.ref, o.mfoa, o.nlsa, p.s
                  from oper o, opldok p
                  where o.ref  = p.ref
                    and p.acc  = k.acc
                    and p.dk   = 1
                    and p.fdat = l_DAT1
                  order by o.ref desc
                   )
        loop
           -- ����� ���������� �� ����� �������, ������� � ����������
           If l_ost >  0 then     l_ost := l_ost - d.S;

  --���� ������� ��� ������� ��.��� �� ������/�����
  If gl.aMFO   ='322669' then
     -- ��� ����� �� �� ���=322669
-----If d.mfoa='394222' and d.nlsa like '2603_30_358'    then vosto_:= vosto_+d.s;
     If d.mfoa='335106' and d.nlsa like '2603_30_384022' then vosto_:= vosto_+d.s;
     else                                                     zapad_:= zapad_+d.s;
     end if;

  ElsIf gl.aMFO='324805' then   -----��� ���� ��
     If d.mfoa ='384049' and d.nlsa like '2603%'
     OR
     d.MFOA = gl.aMfo  and
     d.nlsa in ('26031301031348','26031302301710',
                '26030302031348','26032301301710',
                '26039301045660' )                       then vosto_:= vosto_+d.s;
   else                                                       zapad_:= zapad_+d.s;
   end if;
 end if;
           END IF;
        end loop ;  -- D
        ---------------
        If vosto_ + zapad_ >  k.OST then
           del_ :=  (vosto_ +  zapad_) -  k.OST ;
           If del_ < zapad_ then zapad_ := zapad_ - del_;
           else                  vosto_ := vosto_ - (del_ -zapad_); zapad_ := 0;
           end if  ;
        end if;

        insert into KRYM_GAZT (grp,REF,sos,ID,nlsa,kva,mfob,nlsb,kvb,tt,vob,nd,
                               datd,s,nam_a,nam_b,nazn,okpoa,okpob )
        select 99, k.RN + rownum, 0, k.RN + rownum,
           k.nls, k.kv, g.MFOB, g.nlsb, k.kv, g.tt, g.vob, rownum, gl.bdate,
          greatest(0, round(
--decode ( g.n, 'S1',vosto_, 'S3',vosto_, 'S5',vosto_, zapad_ )
  decode ( mod ( substr ( g.n, -1 ), 2 ), 1,   vosto_, zapad_ )
              * g.koef/100      , 0 ) ),
           substr(k.nms,1,38), substr(g.polu,1,38), g.nazn, k.okpo, g.okpo
        from KRYM_GAZR g  where nls = k.NLS ;

        select  (vosto_ +zapad_ ) - NVL(sum(s),0)
        into del_
        from  KRYM_GAZT
        where nlsa=k.nls and id > k.RN and id < k.RN + 99;

        if del_ <>0 then

           update KRYM_GAZT     set s = s + DEL_
            where nlsa=k.nls and id > k.RN  and id < k.RN + 99
              and s = (select max(s)
                       from KRYM_GAZT
                       where nlsa=k.nls and id > k.RN  and id < k.RN + 99)
              and rownum=1;

        end if;

        delete from KRYM_GAZT where s=0 ;

     end if;

  end loop;

end KRYM_GAZP;
/
show err;

PROMPT *** Create  grants  KRYM_GAZP ***
grant EXECUTE                                                                on KRYM_GAZP       to BARS015;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KRYM_GAZP.sql =========*** End ***
PROMPT ===================================================================================== 
