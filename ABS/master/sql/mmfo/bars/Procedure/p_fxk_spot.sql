

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FXK_SPOT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FXK_SPOT ***

  CREATE OR REPLACE PROCEDURE BARS.P_FXK_SPOT (p_par integer, p_nls1819 varchar2, p_dat date)
is

  /* p_par =0 �����, ������� ������� �����������, ����������� �� ������ ���
     p_par =1 ����� ����������� �� ����.�������� ������, ����������� �� ������ ���*/

MODCODE   constant varchar2(3) := 'FX';
-- ������� ����� ����������
l_nls3540 varchar2(15);  /*3540 - ������ �� ���� �����������*/
l_nms3540 VARCHAR2(38);
l_nls3640 varchar2(15);  /*3640 - �����'������ �� ���� �����������*/
l_nms3640 VARCHAR2(38);
l_nls6204 varchar2(15);  /*6204 - ��������� �_� ����.��.� _����� �_�. _������������*/
l_nms6204 VARCHAR2(38);
l_nls1819 varchar2(15);  /*���� 1819*/  -- ���� 1819 �������� � ���
                                          -- �� ���� ������� ��������� ��� ��������  ������
l_nms1819 VARCHAR2(38);

-- ������
l_dk   number;
l_ref1  int;
l_ref2  int;
l_ref3  int;
l_ref4  int;

l_fl   int;       -- ���� ������ ��� FXK (37 ���� - 1- �� ����, 0 - �� �����)
l_okpo VARCHAR2(15);
l_nlsd VARCHAR2(15);
l_nlsk VARCHAR2(15);
l_nmsa VARCHAR2(38);
l_nmsb VARCHAR2(38);
-- ����� ����������� �������� FXK  �� ����������
par2_      number;
par3_     varchar2(30);
/*
  ������
  qwa   08.01.2014 �� ������� ����� �������� � ���������� ������� ������� �������� ��������

  qwa   03.01.2014  ����������� ������� -
                    ���_��� �����_� - �_���
                           ������     �_��� � �_� ../../..
                           ���_��� "������� ������� �����"  "���� �����"


  qwa   14-05-2013  ������_��� ���� ���� ���� ����������
                    p_par=0  ����� �� �����_ ���, ��� ���� ��_ ������������
                    p_par=1  �� ������ ����������� � "��_��� ����" (��������� � �_��_ �_����), ��� ���� ��_ ����������
                             �� ��������� ���_�� (������ ������������ �����)

                    ���� ������_��� ���������� �������� (�� �����_ ��� �� ������) - ����������� �������_��_ ������_�
                    �� ������_��_ _ ���_� ���������� �������� ������_���.

                    ��_ ������_� ����������� � ����� FXK _ ����� �_��_ ��������_ �� ����������� �������
                    � ���������_ �_� ��_��� ������_�

                    "0". �� �����_ ��� ���������� �_���� �_ �����, �� ���� ������������ � ��������� ����_������� ��_
                    �������_ ������_� FX5,
                    ����� :
                    0.1. �������� �������_  �� ���������� ������_��� �� �����_� ����_ �������� (���� ����������
                       ������_��� �� ���� - �������_� ����)
                       ����������� �������
                         "�������� ������i��� ������� ������� ����� Ref <�������� �����> �����_� <����� �_����>"
                    0.2. �������� ������_���  ���� �� ������������  ��_��� ����� ��������� ���
                       ����������� �������
                          "������i��� ������� ������� ����� Ref <�������� �����> �����_� <����� �_����>"

                       ���� ������_��� : ��� ����_���(��) ������� - �� �������=s
                                 s>0   �� 3540 �� 6204
                                 s<0   �� 6204 �� 3640
                    0.3. ������� ������ �� ����������� (3540, 3640) �� ������� 1819 �� �_����_��_� ������_, ��������� ������_���
                      �� ���_� ��� ������ ���������� �� 6204. 1819 � ���� ����� ���� ��������� �� 6204 � �_��_ ��� ��� ��������_ �_�����������.

                      ����������� �������
                        "�������� ������_��� ����.������� ����� Ref <�������� �����>  �����_� �  <����� �_����> "
                    !!!!!!!!!!!!!!!!!!!!!!!!!!!
                    ��������_ �� �������_ ���� �����, � ���� ����_ ���� ����� �_�����

                    and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- ��_ ������������
                    or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat) )          -- ��_ ����������

                    "1" - �� ������ ��������� �_���� �_ �����, ��_ ���������� �� ��������� ��_���� ���_��
                    1.1. �������� �������_  �� ���������� ������_��� �� �����_� ����_ �������� (���� ����������
                       ������_��� �� ���� - �������_� ����)
                       ����������� �������
                         "�������� ������i��� ���� ������� ����� Ref <�������� �����> �����_� <����� �_����>"
                    1.2. �������� ������_���  ���� �� ������������  ��_��� ����� ��������� ���
                       ����������� �������
                          "������i��� ���� ������� ����� Ref <�������� �����> �����_� <����� �_����>"

                       ���� ������_��� : ��� ����_���(��) ������� - �� �������=s
                                 s>0   �� 3540 �� 6204
                                 s<0   �� 6204 �� 3640

*/

procedure back_fxk_spot  is
 -- ����� ���� �����������, ���� ���������� ����������� ��������
 -- ����� �������� ����, ��� ������������ �������� � ���������� �����������

-- l_sos oper.ref%type;

 begin
         for p in (

         select  o.ref,o.nlsa,o.nlsb,o.s,o.sos,d.sos sos_ref,
                 to_number(substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,' �i��� � ')-(instr(o.nazn,'Ref ')+4))) deal_tag,
                 f.sumpa,f.sumpb,f.sump,f.kva,f.kvb,o.nazn
           from oper o, fx_deal f, fx_deal_ref d
          where o.tt='FXK'
            and (( p_par=0 and (  f.dat_a=p_dat and f.dat_b=p_dat )
                            and (o.nazn like '������%' or o.nazn like '������%' or o.nazn like '������%'
                            ))      -- ��� �������������
               or p_par=1 and (f.dat_a>p_dat and  f.dat_b>p_dat)
                          and (o.nazn like '������%'  or o.nazn like '������%'))       -- ��� �����������
            and o.sos>=1
            and o.datd=gl.bd
            and substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,' �i��� � ')-(instr(o.nazn,'Ref ')+4))=to_char(f.deal_tag)
            and d.ref=o.ref
            order by o.ref desc

                )
      loop
          bars_audit.info('1FXK'||'back='||p.ref);
          p_back_dok(p.ref,5,null,par2_,par3_,1);

          if    p.nazn like '������%' or p.nazn like '������%' then
                update fx_deal_ref
                set   sos=0
                where ref=p.sos_ref;
          end if;

          update operw
            set value='�������� ������i��� ����.���� �� 3*-6204'
          where ref=p.ref
            and tag='BACKR';

      end loop;
 end back_fxk_spot;


procedure pereoc_spot is

-- ���������� ���� ������
-- ��������� ����_��� ��� �(��� ��� �� ����) -��� ����_��� ��� �(��� ��� �� ����)
/* ��� ���������� ��� ���������� ������� ���� ������

     �� ����� - �� ���������  ������� �� ������ 2 ��� ���� �� �����. � ���� ����������
     �� ��������� �� 9200? 9210 -  FX5 ��������
     ����� ������ ����� �� ���� ������� �� ������ 9200(�), 9210(�)
oper
   */
  begin
     for k in (

           select f.deal_tag,f.ref,f.ref1,f.dat,f.dat_a,f.dat_b,f.kva,f.suma,f.kvb,f.sumb, f.dat_a fdat,
                decode (kvb, 980, f.sumb, gl.p_icurval(f.kvb,f.sumb,bankdate_g))-
                decode (kva, 980,  f.suma, gl.p_icurval(f.kva,f.suma,bankdate_g))  NKR,
 '������i��� ���� ����� Ref '||to_char(f.deal_tag)||' �i��� � '||f.ntik||' �i� '||to_char(f.dat,'dd-mm-yyyy')||' '||nvl(c.nmkk,'')
                                              NAZN1,
                               count_wday(f.dat,f.dat_a)-1 wday
           from fx_deal f, (select * from customer  where custtype=1 and date_off is null) c
           where    f.dat<f.dat_a and f.rnk=c.rnk
              and   f.dat<=bankdate_g  -- � ��� ����� �����������
                   and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- ��� �������������
                       or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat) )                                           -- ��� �����������
                   --and count_wday(f.dat,f.dat_a)-1>=1
                    and exists
                    (select ref
                       from opldok
                      where ref=nvl(f.ref1,f.ref)
                       and sos>=1
                       and tt='FX5')
              order by 1


         )
     loop
       SAVEPOINT do_fxk2;
       begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
         if  k.NKR=0 then goto kin2;
         elsif k.NKR<0 then   -- �����
              l_nlsd:=l_nls3540; l_nmsa:=l_nms3540;
              l_nlsk:=l_nls6204; l_nmsb:=l_nms6204;

         elsif k.NKR>0 then   -- ������
              l_nlsd:=l_nls6204; l_nmsa:=l_nms6204;
              l_nlsk:=l_nls3640; l_nmsb:=l_nms3640;
         end if;
         BEGIN
           gl.ref (l_ref1);
       --logger.info('3FXK NKR='||k.NKR||'ref='||l_ref1||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk);
           INSERT INTO oper
              (ref, tt, vob, nd, dk, pdat, vdat, datd, datp,
               nam_a, nlsa, mfoa, id_a,
               nam_b, nlsb, mfob, id_b,
             kv, s, kv2, s2, nazn, userid)
            VALUES
              (l_ref1, 'FXK', 6, l_ref1, 1, sysdate, bankdate_g, bankdate_g, bankdate_g,
               l_nmsa, l_nlsd, gl.aMFO, l_okpo, l_nmsb, l_nlsk, gl.aMFO, l_okpo,
               980, abs(k.nkr), 980, abs(k.nkr), k.nazn1, USER_ID);
            gl.payv(l_fl, l_ref1, bankdate_g, 'FXK', 1,980, l_nlsd, abs(k.nkr), 980, l_nlsk, abs(k.nkr) );
            EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk2;
            bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');

         END;


         if l_ref1 is not null then
            insert into fx_deal_ref (ref,deal_tag,sos)
                 values (l_ref1,k.deal_tag,0);   -- sos=0  ���������� ��������

          --  bars_audit.info('p_fxk0 ='||'k.nbs,l_nlsd,l_nlsk,k.nkr=='||k.nbs ||'='||l_nlsd||'='||l_nlsk||'='||k.nkr);
          -- ���� ���� �������������� ��� �������� ���, ��� ������� ��� ���� ������
          -- ����� ���� ������ �����

            if  k.NKR >0   and l_nlsk like '6204%' then
                --bars_audit.info('p_fxka 1 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpa=k.nkr
                where deal_tag=k.deal_tag;
            elsif k.NKR< 0 and l_nlsd like '6204%' then
                --bars_audit.info('p_fxka 2 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpb=abs(k.nkr)
                where deal_tag=k.deal_tag;
            end if;


            --bars_audit.info('p_fxkp ='||k.nkr||'= '||k.deal_tag);
         elsif  l_ref1 is null then
           --bars_audit.info('p_fxkp====>0'||k.nkr||'= '||k.deal_tag);
            update fx_deal
              set  sumpa=0, sumpb=0,  sump=0
             where deal_tag=k.deal_tag;
         end if;

       end;
       <<kin2>> NULL;
     end loop;
  end pereoc_spot;


procedure close_pereoc_spot  is
      /*
         ��������  3540, 3640 � ������� � 1819 ���� -980 �� �����. ������
     */

   -- ��������� ���� 1819 ��� 3801 �� ��������� ������ ������ ���������
   --
 begin

--  � ������ �������� ������ �����, �� ������� ��������� ���� �������� ������
     for k in (

            select  distinct f.kva, f.kvb,
                 o.nlsa, o.nlsb,
                 o.s s,
                 f.deal_tag,
          '�������� ������i��� ���� ����� Ref '||to_char(f.deal_tag)||' �i��� � '||f.ntik||' �i� '||to_char(f.dat,'dd-mm-yyyy')||' '||nvl(c.nmkk,'')
                                NAZN3
         from  (
         select ref,nlsa,nlsb,s,nazn
                  from oper
                 where tt='FXK'
                   and sos>=1
                   and nazn like '������%'
                   and vdat=gl.bd
                  ) o,
                 fx_deal_ref d,
                 fx_deal f,
                 (select * from customer  where custtype=1 and date_off is null) c
          where d.ref=o.ref   -- ���������� �������
            and d.sos=0
            and d.deal_tag=f.deal_tag and f.rnk=c.rnk
            and p_par=0 and   f.dat_a=p_dat and f.dat_b=p_dat  -- ������ �����������
            and  not exists (   -- ������� ���� ��� �� ���� �������� ���������� �� ������ ������
                     select 1
                       from fx_deal_ref
                      where deal_tag=d.deal_tag
                       and  ref in (
                             select ref
                               from oper
                              where tt='FXK'
                               and sos>=1
                               and nazn like '��������%'
                               and vdat=gl.bd))


         )
     loop
       SAVEPOINT do_fxk3;
       begin
       --bars_audit.info('2FXK NKR= '||k.S ||' deal_tag= '||k.deal_tag);

       if substr(p_nls1819,1,4)='1819' then
          begin
            select nls, substr(nms,1,38)
             into l_nls1819,l_nms1819
             from accounts
            where nls=p_nls1819 and kv=980;
              exception when no_data_found then
              bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
          end;
       elsif substr(p_nls1819,1,4)='3800' then goto KIN3;
       else goto KIN3;
       end if;


         bars_audit.info('p_fxk==s=='||k.s||'k.kva=='||k.kva||'k.kvb=='||k.kvb);

         if  k.s=0 then goto kin3;
         elsif k.kva<>980 and k.kvb<>980     then     -- ���������
               if substr(k.nlsa,1,4)='6204'  then     -- ������ �� ��� �
                  l_nlsd:=l_nls3640;     l_nmsa:=l_nms3640;
                  l_nlsk:=l_nls1819;     l_nmsb:=l_nms1819;
               elsif substr(k.nlsb,1,4)='6204' then   -- ����� �� ��� �
                  l_nlsd:=l_nls1819;   l_nmsa:=l_nms1819;
                  l_nlsk:=l_nls3540;  l_nmsb:=l_nms3540;
               end if;
         elsif k.kva<>980 and k.kvb=980    then  -- ������� ���
              if   substr(k.nlsa,1,4)='6204'  then  -- ������ �� ��� �
                 l_nlsd:=l_nls3640;   l_nmsa:=l_nms3640;
                 l_nlsk:=l_nls1819;   l_nmsb:=l_nms1819;
              elsif substr(k.nlsb,1,4)='6204' then  -- ����� �� ��� �
                 l_nlsd:=l_nls1819;   l_nmsa:=l_nms1819;
                 l_nlsk:=l_nls3540;     l_nmsb:=l_nms3540;
              end if;
         elsif k.kva=980 and k.kvb<>980   then    -- ������� ���
              if   substr(k.nlsa,1,4)='6204'  then  -- ������ �� ��� �
                 l_nlsd:=l_nls3640;   l_nmsa:=l_nms3640;
                 l_nlsk:=l_nls1819; l_nmsb:=l_nms1819;
              elsif substr(k.nlsb,1,4)='6204' then  -- ����� �� ��� �
                 l_nlsd:=l_nls1819;   l_nmsa:=l_nms1819;
                 l_nlsk:=l_nls3540;     l_nmsb:=l_nms3540;
              end if;
         else  goto kin3;
         end if;
         bars_audit.info('p_fxk== l_nlsd=='||l_nlsd||'l_nlsk=='||l_nlsk);
         BEGIN
           gl.ref (l_ref3);
       --bars_audit.info('3FXK S='||k.s||'ref='||l_ref3||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk||'l_nls3540='||l_nls3540||'l_nls3640='||l_nls3640);
           INSERT INTO oper
              (ref, tt, vob, nd, dk,
              pdat, vdat, datd, datp,
              nam_a, nlsa, mfoa, id_a,
              nam_b, nlsb, mfob, id_b,
              kv, s, kv2, s2, nazn, userid)
            VALUES
              (l_ref3, 'FXK', 6, l_ref3, 1,
              sysdate, bankdate_g, bankdate_g, bankdate_g,
              l_nmsa, l_nlsd, gl.aMFO, l_okpo,
              l_nmsb, l_nlsk, gl.aMFO, l_okpo,
              980, abs(k.s), 980, abs(k.s), k.nazn3, USER_ID);
            gl.payv(l_fl, l_ref3, bankdate_g, 'FXK', 1,980, l_nlsd, abs(k.s), 980, l_nlsk, abs(k.s) );
            --EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk3;
            --bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
         END;

         if l_ref3 is not null then
            insert into fx_deal_ref (ref,deal_tag,sos)
                 values (l_ref3,k.deal_tag,5);

          --bars_audit.info('p_fxk0 ='||'l_nlsd,l_nlsk,k.s==='||l_nlsd||'='||l_nlsk||'='||k.s);
         end if;

       end;
       <<kin3>> NULL;
     end loop;
 end close_pereoc_spot;

 --bars_audit.info('p_fxkp-- commit');
--procedure zvorot_fxk_spot (p_par integer) is      -- �������� � ��������� ����������
procedure zvorot_fxk_spot is      -- �������� � ��������� ����������

 dok oper%rowtype;
 l_nazn oper.nazn%type;
 l_s    oper.s%type;
 l_deal_tag fx_deal_ref.deal_tag%type;


 begin
   /*  ��������� ��������� ����������, �� ��� ����� ������� �������� ��������*/

 for k in (

  select r.ref,r.deal_tag,r.sos
     from fx_deal_ref r,fx_deal f
     where r.deal_tag=f.deal_tag
      and (( p_par=0 and   f.dat_a=p_dat and f.dat_b=p_dat  ) -- ��� �������������
         or (p_par=1 and   f.dat_a>p_dat and  f.dat_b>p_dat ))
      and r.sos=0
      and  exists (select 1 from oper
                     where ref=r.ref
                       and tt='FXK'
                       and sos>=1)


      )
 loop
    begin
      bars_audit.info('p_fxk=k.ref= ��� �������� '||k.ref);

      select  *
         into dok
         from oper
        where ref =k.ref;

    exception when no_data_found then goto kin4;
    end;
    -- ���������� ������ ��������

    l_nlsd:= dok.nlsb;
    l_nmsa:= dok.nam_b;
    l_nlsk:= dok.nlsa;
    l_nmsb:= dok.nam_a;
    l_s   := dok.s;
    l_nazn:= '�������� '||dok.nazn;
    l_deal_tag :=to_number( substr(dok.nazn,instr(dok.nazn,'Ref ')+4,instr(dok.nazn,' �i��� � ')-(instr(dok.nazn,'Ref ')+4)));

    SAVEPOINT do_fxk4;
    begin
      begin
          gl.ref (l_ref4);
       --logger.info('3FXK NKR='||k.NKR||'ref='||l_ref1||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk);
          INSERT INTO oper
              (ref, tt, vob, nd, dk, pdat, vdat, datd, datp,
               nam_a, nlsa, mfoa, id_a,
               nam_b, nlsb, mfob, id_b,
             kv, s, kv2, s2, nazn, userid)
           VALUES
              (l_ref4, 'FXK', 6, l_ref4, 1, sysdate, bankdate_g, bankdate_g, bankdate_g,
               l_nmsa, l_nlsd, gl.aMFO, l_okpo, l_nmsb, l_nlsk, gl.aMFO, l_okpo,
               980, l_s, 980, l_s, l_nazn, USER_ID);
            gl.payv(l_fl, l_ref4, bankdate_g, 'FXK', 1,980, l_nlsd, l_s, 980, l_nlsk, l_s );
            EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk4;
            bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
      END;

bars_audit.info ('p_fxk_u'||l_ref4);
         if l_ref4 is not null then

            insert into fx_deal_ref (ref,deal_tag,sos)
                 values (l_ref4,l_deal_tag,k.ref);   -- k.ref - ��������� ���. �������� �������� �� ����������

            update  fx_deal_ref
              set   sos=5
              where ref=k.ref and deal_tag=l_deal_tag;  -- ������� "���������" ��� "������" ����������

            -- ���� ���� ���� �� �����
            update fx_deal
              set  sumpa=0, sumpb=0,  sump=0
             where deal_tag=l_deal_tag;

         end if;

    end;
       <<kin4>> NULL;
 end loop;
end zvorot_fxk_spot;

---------------------------------------------------------------------
-- �������
---------------------------------------------------------------------
 begin

bars_audit.info ('FXK - �����');

  begin
      -- ��������� ����� 3540, 3640, 6204 �� ��������� �� FXK  -- !!

   SELECT to_number(substr(t.flags,38,1)),
          t.nlsa,  substr(a.nms,1,38),
          t.nlsb,  substr(b.nms,1,38),
          t.nlsk,  substr(c.nms,1,38)
    INTO l_fl,l_nls3540,l_nms3540,l_nls3640,l_nms3640,l_nls6204,l_nms6204
    FROM tts t,
         (select nls,nms from accounts where kv=980 and nbs='3540') a,
         (select nls,nms from accounts where kv=980 and nbs='3640') b,
         (select nls,nms from accounts where kv=980 and nbs='6204') c
    WHERE t.tt='FXK' and
          ltrim(rtrim(t.nlsa))=a.nls  and
          ltrim(rtrim(t.nlsb))=b.nls  and
          ltrim(rtrim(t.nlsk))=c.nls  ;

   exception when no_data_found then
    bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
  end;

 bars_audit.info('0FXK === l_nls3540='||l_nls3540||' l_nls3640='||l_nls3640||' l_nls6204='||l_nls6204);

  SELECT substr(f_ourokpo,1,15)
    INTO l_okpo
    FROM dual;

  back_fxk_spot   ;      -- ������� ����������� ���� ��������
  bars_audit.info('FXK = back');
  zvorot_fxk_spot ;    -- �������� � ��������� ����������
  bars_audit.info('FXK = zvorot');
  pereoc_spot;      --  ���������� ���� ������ (� ��� ����� ����)
  bars_audit.info('FXK = pereoc');

  if p_par=0 then
     close_pereoc_spot;     -- �������� 3540, 3640 �� 1819 ���� ��������� �� ������
     bars_audit.info('FXK = close');
  end if;

 commit;

end p_fxk_spot;
/
show err;

PROMPT *** Create  grants  P_FXK_SPOT ***
grant EXECUTE                                                                on P_FXK_SPOT      to ABS_ADMIN;
grant EXECUTE                                                                on P_FXK_SPOT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FXK_SPOT      to BARS_CONNECT;
grant EXECUTE                                                                on P_FXK_SPOT      to FOREX;
grant EXECUTE                                                                on P_FXK_SPOT      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FXK_SPOT.sql =========*** End **
PROMPT ===================================================================================== 