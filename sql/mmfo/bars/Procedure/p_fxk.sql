

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FXK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FXK ***

  CREATE OR REPLACE PROCEDURE BARS.P_FXK (p_par integer, p_nls1819 varchar2, p_dat date)
is
-- ��� p_par=1
l_nls3    varchar2(15);  /*���� 3811*/
l_nls6    varchar2(15);  /*���� 6204*/
l_nms3 VARCHAR2(38);
l_nms6 VARCHAR2(38);
-- ��� p_par=2,3
l_nls3041 varchar2(15);  /*���� 3041*/
l_nls3351 varchar2(15);  /*���� 3351*/
l_nls6209 varchar2(15);  /*���� 6209*/
l_nms3041 VARCHAR2(38);
l_nms3351 VARCHAR2(38);
l_nms6209 VARCHAR2(38);
l_nls1819 varchar2(15);  /* �������� ���-����    */
l_nms1819 VARCHAR2(38);  /* �� ���� �����������  */
-- ��� ������
l_dk   number;       /* ������� ��-�� */
l_ref1  int;
l_ref2  int;
l_ref3  int;
l_fl   int;
l_okpo VARCHAR2(15);
l_nlsd VARCHAR2(15);
l_nlsk VARCHAR2(15);
l_nmsa VARCHAR2(38);
l_nmsb VARCHAR2(38);
 --���������� ��� ������ ����������� �������� FXK  �� ����������
par2_      number;
par3_     varchar2(30);
/*
  ������
  qwa   31.08.2011  ����� ���������� ��� ���������� ������ - � �����. � ���������. 309
                    !!!���� �� ��������� ������ ��� �� ����-������� �� ����������� 9 �����!!!
                    !!!������ �������!!!
                     ---------------------   ��������� ������ 2 (���������� ���������� )
                                                              3 (�������� �������� �� ������ 3351, 3041 � ���� � 1819 )
        ������� ��������:
        ���������� ������ >2 ���.����, � ���� ����� ���������� 9 ����� ��������� FXF
        �������� �������� fx_spot
        1. 9 ����� ������������� ��� ������ (��� ��������� ���-����������� ������ �� ���� �������)
        � �������� !! �� ������ ��� !!  ������ ���������� ���������  ��������� ����������
                                       �� 3041-6209 ��� ������� ���������� ������.
                                       �� 6209-3351 ��� ������� ���������� ������.
        ��������� ��������� ���������� � fx_deal.sumpa ��� ��� �, fx_deal.sumpb ��� ��� �,
                           ���������   ���������    � fx_deal.sump (����� � 6209)
        2. �� ������ ��� �� �������, � ������� ����������� ���������� 9 ����� ��������� 2 ��������
           �������� (��������� 3041, 3351 � ����� ������� ������  � ��������������� � 1819� -��������)
           ��������� ���������� �������� �������� �� 6209 � ��� ������� ������ ��� ���� fx_deal.sump
        ������� �� ��������� � ���������� ������
        �. �� ��������� ������� �� ��������
        �. ������ ����� ��� ��������� ���������� (����� 3041,3351,6209 - ���� 3811 - 6204)
        �. ���������� ��������� ���������� � ������ � ���.���������� �� ���������� � fx_deal_ref
        �. ������������ ���������� ������������ � ������� ������ �� ������ ��� - ��������
           ������ ������� 3 .

*/
MODCODE   constant varchar2(3) := 'FX';

/*  qwa   08.08.2008  � ����� � ������� ��������� 1075
        ���������� ���� �����. ������ (������������ ��� ��, ��������, ���)
   ������ 1075
   ��������� ��������� ����������� ���������� ���� ���� (���� � �������) - ������ �� 3811-6204
   (9 ����� ��� ���� � ������� �������� ����������� fx_spot)
   ��������� ��� �135 + ������   ------------------------------ �������� ������ 1
   ������������� ��� ����������:
   �) ���������� ��������  FXK
   �) ����� 3811-6204 - ���� ���� ��� ���� �����, ���� ������
   �) ��������� ����������� �� ������ ��� � ������ ����� ���������� ��������
      � �������� (�������� ����� ��������� �� ����� ������������ ������������
      ����). ����������� ������ �������� �� ����� ���������� ������ � �����
      �������� ���������� ��� ������������ 3811
   �) ���� ��������� ����������� ��������, � ������� ��� ����� �������
      ��� ���������� "�����������"  FXK, ��������� �����. �������� �����
      �������������, ���� ����� �� �������� �� ���������, ���� �������� -
      ��������. ���� ����� ������� ���!!!
      ������� ����� ���������� ��������, ����������� �������

   ��� �� �������� ������������� � ������������� ���������
   ���������� ���� ������
   ����� �� - ��������������� ���������
1) ������� ������     ���� ������
   *** ���� 9200(�)  ***
   ������ ����  -100USD*4.5=-450.00
          ����� -100USD*4.6=-460.00   ��=-10.00 (��)
   ������������� ���������  ����������
         ��3811   ��6204  10.00
2) ������� ������     ���� ������
    ***  ����  9200(�) ***
   ������ ����  -100USD*4.5=-450.00
          ����� -100USD*4.4=-440.00   ��=10.00 (��)
   ������������� ���������  ����������
         ��6204   ��3811  10.00
3) ������� ������   ���� ������
   *** ����  9210(�)     ***
   ������ ����  100USD*4.5=450.00
          ����� 100USD*4.6=460.00   ��=10.00 (��)
   ������������� ���������  ����������
         ��6204   ��3811  10.00
4) ������� ������ ���� ������
   *** ����  9210(�)    ***
   ������ ����  100USD*4.5=450.00
          ����� 100USD*4.4=440.00   ��=-10.00 (��)
   ������������� ���������  ����������
         ��3811   ��6204  10.00
*/

begin
 if p_par=1 then   /*   ���������� �� 3811-6204 � ������������� ���������� ��������
                       ��������� 9202, 9212 */
    begin
   -- ��������� ����� 3811, 6204 �� ��������� �� FXK
    SELECT to_number(substr(t.flags,38,1)),t.nlsa,substr(a.nms,1,38),t.nlsb,substr(b.nms,1,38)
     INTO l_fl,l_nls3,l_nms3,l_nls6,l_nms6
     FROM tts t,accounts a,accounts b
     WHERE t.tt='FXK' and
          ltrim(rtrim(t.nlsa))=a.nls and a.kv=980 and
          ltrim(rtrim(t.nlsb))=b.nls and b.kv=980  ;
    exception when no_data_found then
    bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
    end;
--logger.info('0FXK NLS3='||l_nls3||'NLS6='||l_nls6);
   SELECT substr(f_ourokpo,1,15) INTO l_okpo FROM dual;
 -- �������� ���� �� "�������" �������� FXK
 -- ������� ��� �����������
   begin
      for p in (select ref  from oper  where tt='FXK'
                and ((nlsa=l_nls3 and nlsb=l_nls6) or
                    ( nlsa=l_nls6 and nlsb=l_nls3))
                and sos>0 and datd=gl.BDATE)
      loop
       -- logger.info('1FXK'||'back');
        p_back_dok(p.ref,5,null,par2_,par3_,1);
        update operw set value='�������� ������i��� ����-���� �� 3811-6204' where ref=p.ref and tag='BACKR';
      end loop;
   end;
 /* ��� ���������� ��� ���������� ������� ������ �� �������� ����
    -- �� ����� - �� ���������  ������� + 2 ��� ��� �� �����. � ���� ����������
    -- �� ��������� �� 9200 -  FX5 ��������
    -- ����� ������ ����� �� ���� ������� �� ������ 9200(�), 9210(�)
 */
    for k in (
           select f.deal_tag,f.ref,f.ref1,f.dat,f.dat_a,f.dat_b,f.kva,-f.suma,f.kvb,f.sumb, '9200' nbs,f.dat_a fdat,
              ( gl.p_icurval(f.kva,-f.suma,bankdate_g)-
                gl.p_icurval(f.kva,-f.suma,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
'������i��� �����.����-����� �'||f.ntik||'���i��� ���-'||f.kva||' �� ���� ' ||ltrim(rtrim(to_char(f.suma/100,'99999999999.99')))
                               NAZN1
  ,
'�������� �������� �� ������.�����.����-����� �'||f.ntik||'���i��� ���-'||f.kva||' �� ���� ' ||ltrim(rtrim(to_char(f.suma/100,'99999999999.99')))
                                NAZN2
           from fx_deal f
           where   f.dat<f.dat_a           and    f.dat<bankdate_g     and
                   f.dat_a>=bankdate_g     and    f.kva<>980           and
                   count_wday(f.dat,f.dat_a)-1 in (1,2) and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FX5') -- ��� FXF ------
         union all
         select deal_tag,ref,ref1,dat,dat_a,dat_b,kva,-suma,kvb,sumb, '9210' nbs,dat_b fdat,
               ( gl.p_icurval(kvb,sumb,bankdate_g)-
                gl.p_icurval(kvb,sumb,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
'������i��� �����.����-����� �'||ntik||'������ ���-'||kvb||' �� ���� ' ||ltrim(rtrim(to_char(sumb/100,'99999999999.99')))
                                NAZN1
,
'�������� �������� �� ������.�����.����-����� �'||ntik||'������ ���-'||kvb||' �� ���� ' ||ltrim(rtrim(to_char(sumb/100,'99999999999.99')))
                                NAZN2
        from fx_deal f
        where   dat<dat_b           and    dat<bankdate_g     and
                dat_b>=bankdate_g   and    f.kvb<>980           and
                count_wday(dat,dat_b)-1 in (1,2) and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FX5')  -- ��� FXF ------
         )
    loop
     SAVEPOINT do_fxk1;
     begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
        if  k.NKR=0 then goto kin1;
        elsif ((k.nbs='9200' and k.NKR<0)  or (k.nbs='9210' and k.NKR<0))  then
              l_nlsd:=l_nls3; l_nmsa:=l_nms3;
              l_nlsk:=l_nls6; l_nmsb:=l_nms6;
        elsif  ((k.nbs='9200' and k.NKR>0)   or (k.nbs='9210' and k.NKR>0)) then
              l_nlsd:=l_nls6; l_nmsa:=l_nms6;
              l_nlsk:=l_nls3; l_nmsb:=l_nms3;
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
              (l_ref1, 'FXK', 6, l_ref1, 1, sysdate, gl.bDATE, gl.bDATE, gl.bDATE,
               l_nmsa, l_nlsd, gl.aMFO, l_okpo, l_nmsb, l_nlsk, gl.aMFO, l_okpo,
               980, abs(k.nkr), 980, abs(k.nkr), k.nazn1, USER_ID);
          gl.payv(l_fl, l_ref1, GL.BDATE, 'FXK', 1,980, l_nlsd, abs(k.nkr), 980, l_nlsk, abs(k.nkr) );
          EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk1;
          bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
        END;
       /*  == �������� ==  */
        BEGIN
         gl.ref (l_ref2);
         --logger.info('3FXK NKR='||k.NKR||'ref='||l_ref2||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk);
         INSERT INTO oper
              (ref, tt, vob, nd, dk, pdat,
               vdat,
               datd, datp,
               nam_a, nlsa, mfoa, id_a,
               nam_b, nlsb, mfob, id_b,
	       kv, s, kv2, s2, nazn, userid)
         VALUES
              (l_ref2, 'FXK', 6, l_ref2, 1, sysdate,
               decode(k.nbs,'9200',k.dat_a,'9210',k.dat_b),
               gl.bDATE, gl.bDATE,
               l_nmsb, l_nlsk, gl.aMFO, l_okpo, l_nmsa, l_nlsd, gl.aMFO, l_okpo,
               980, abs(k.nkr), 980, abs(k.nkr), k.nazn2, USER_ID);
         gl.payv(l_fl, l_ref2, k.fdat, 'FXK', 1,980, l_nlsk, abs(k.nkr), 980, l_nlsd, abs(k.nkr) );
         EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk1;
         bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
        END;
     end;
     <<kin1>> NULL;
    end loop;

 elsif p_par in (2,3) then   /*   ���������� �� 3041, 3351,6209 � ������������ ����� ���������� � ������      p_par=2,
                                  � ���� �������� ���������� ������ ���������� �� ������ ��� ������ ��������� p_par=3
                                  ��������� �� 9202, 9212
                              */
  begin
   -- ��������� ����� 3401, 3351, 6209 �� ��������� �� FXK
   SELECT to_number(substr(t.flags,38,1)),
          t.nlsa,  substr(a.nms,1,38),
          t.nlsb,  substr(b.nms,1,38),
          t.nlsk,  substr(c.nms,1,38)
    INTO l_fl,l_nls3041,l_nms3041,l_nls3351,l_nms3351,l_nls6209,l_nms6209
    FROM tts t,
         (select nls,nms from accounts where kv=980 and nbs='3041') a,
         (select nls,nms from accounts where kv=980 and nbs='3351') b,
         (select nls,nms from accounts where kv=980 and nbs='6209') c
    WHERE t.tt='FXK' and
          ltrim(rtrim(t.nlsa))=a.nls  and
          ltrim(rtrim(t.nlsb))=b.nls  and
          ltrim(rtrim(t.nlsk))=c.nls  ;
   exception when no_data_found then
    bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
  end;
--logger.info('0FXK NLS3='||l_nls3||'NLS6='||l_nls6);

  SELECT substr(f_ourokpo,1,15)
    INTO l_okpo
    FROM dual;

  if p_par=2 then  -- ����������
   -- �������� ���� �� "�������" �������� FXK
   -- ������� ��� �����������
      begin
         for p in (

         select  o.ref,o.nlsa,o.nlsb,o.s,o.sos,
                 to_number(substr(o.nazn, instr(o.nazn,'���-')+4,3)) kv,
                 to_number( substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,'�')-(instr(o.nazn,'Ref ')+4))) deal_tag,
                 f.sumpa,f.sumpb,f.sump,f.kva,f.kvb
           from oper o, fx_deal f
          where o.tt='FXK'
            and o.sos>0
            and o.datd=bankdate_g
            and substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,'�')-(instr(o.nazn,'Ref ')+4))=to_char(f.deal_tag)
            and o.nazn like '������%'

                )
      loop
       -- logger.info('1FXK'||'back');
          p_back_dok(p.ref,5,null,par2_,par3_,1);

          update operw
            set value='�������� ������i��� ����-���� �� 3*-6209'
          where ref=p.ref
            and tag='BACKR';

          if      p.sos=5
             and  p.kv=p.kva
             and  p.nlsa like '3041%'
             and  p.nlsb like '6209%'
             and  nvl(p.sumpa,0)<>0 then
--bars_audit.info('p_fxk = sos1 = '||p.deal_tag);
             update fx_deal
               set  sumpa = nvl(sumpa,0)-p.s,
                    sump  = nvl(sump,0) -p.s
              where deal_tag=p.deal_tag;

          elsif   p.sos=5
             and  p.kv=p.kva
             and  p.nlsa like '6209%'
             and  p.nlsb like '3351%'
             and  nvl(p.sumpa,0)<>0  then
--bars_audit.info('p_fxk = sos2= '||p.deal_tag);
             update fx_deal
               set  sumpa = nvl(sumpa,0)+p.s,
                    sump  = nvl(sump,0) +p.s
              where deal_tag=p.deal_tag;

          elsif   p.sos=5
             and  p.kv=p.kvb
             and  p.nlsa like '3041%'
             and  p.nlsb like '6209%'
             and  nvl(p.sumpb,0)<>0  then
--bars_audit.info('p_fxk = sos3= '||p.deal_tag);
             update fx_deal
                set  sumpb = nvl(sumpb,0)-p.s,
                     sump  = nvl(sump,0) -p.s
              where deal_tag=p.deal_tag;

          elsif   p.sos=5
             and  p.kv=p.kvb
             and  p.nlsa like '6209%'
             and  p.nlsb like '3351%'
             and  nvl(p.sumpb,0)<>0  then
--bars_audit.info('p_fxk = sos4= '||p.deal_tag);
             update fx_deal
               set  sumpb = nvl(sumpb,0)+p.s,
                    sump  = nvl(sump,0) +p.s
              where deal_tag=p.deal_tag;

          end if;

      end loop;
      end;
   /* ��� ���������� ��� ���������� ������� ������ �� �������� ����
    -- �� ����� - �� ���������  ������� + 2 ��� ��� �� �����. � ���� ����������
    -- �� ��������� �� 9202? 9212 -  FXF ��������
    -- ����� ������ ����� �� ���� ������� �� ������ 9202(�), 9212(�)
   */
     for k in (

           select f.deal_tag,f.ref,f.ref1,f.dat,f.dat_a,f.dat_b,f.kva,-f.suma,f.kvb,f.sumb, '9202' nbs,f.dat_a fdat,
              ( gl.p_icurval(f.kva,-f.suma,bankdate_g)-
                gl.p_icurval(f.kva,-f.suma,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
 '������i��� �����.����-����� Ref '||to_char(f.deal_tag)||'�'||f.ntik||'���i��� ���-'||f.kva||' �� ���� ' ||ltrim(rtrim(to_char(f.suma/100,'99999999999.99')))
                               NAZN1
                               ,count_wday(f.dat,f.dat_a)-1 wday
           from fx_deal f
           where   f.dat<f.dat_a           and    f.dat<bankdate_g     and
                   f.dat_a>=bankdate_g     and    f.kva<>980
                   and count_wday(f.dat,f.dat_a)-1>=1
                   and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FXF')
         union all
         select deal_tag,ref,ref1,dat,dat_a,dat_b,kva,-suma,kvb,sumb, '9212' nbs,dat_b fdat,
               ( gl.p_icurval(kvb,sumb,bankdate_g)-
                gl.p_icurval(kvb,sumb,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
'������i��� �����.����-����� Ref '||to_char(f.deal_tag)||'�'||ntik||'������ ���-'||kvb||' �� ���� ' ||ltrim(rtrim(to_char(sumb/100,'99999999999.99')))
                                NAZN1
                                ,count_wday(dat,dat_b)-1
        from fx_deal f
        where   dat<dat_b           and    dat<bankdate_g     and
                dat_b>=bankdate_g   and    f.kvb<>980
                and count_wday(dat,dat_b)-1 >=1
                and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FXF')
         order by 1


         )
     loop
       SAVEPOINT do_fxk2;
       begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
         if  k.NKR=0 then goto kin2;
         elsif ((k.nbs='9202' and k.NKR<0)  or (k.nbs='9212' and k.NKR<0))  then
              l_nlsd:=l_nls3041; l_nmsa:=l_nms3041;
              l_nlsk:=l_nls6209; l_nmsb:=l_nms6209;

         elsif  ((k.nbs='9202' and k.NKR>0)   or (k.nbs='9212' and k.NKR>0)) then
              l_nlsd:=l_nls6209; l_nmsa:=l_nms6209;
              l_nlsk:=l_nls3351; l_nmsb:=l_nms3351;
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
            insert into fx_deal_ref (ref,deal_tag)
                 values (l_ref1,k.deal_tag);

          --  bars_audit.info('p_fxk0 ='||'k.nbs,l_nlsd,l_nlsk,k.nkr=='||k.nbs ||'='||l_nlsd||'='||l_nlsk||'='||k.nkr);

            if k.nbs='9202' and k.NKR<>0   and l_nlsk like '6209%' then
                --bars_audit.info('p_fxka 1 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpa=nvl(sumpa,0)+abs(k.nkr)
                where deal_tag=k.deal_tag;
            elsif  k.nbs='9202' and k.NKR<>0 and l_nlsd like '6209%' then
                --bars_audit.info('p_fxka 2 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpa=nvl(sumpa,0)-abs(k.nkr)
                where deal_tag=k.deal_tag;
            end if;

            if  k.nbs='9212' and k.NKR<>0 and l_nlsk like '6209%' then
                --bars_audit.info('p_fxkb 1 ='||'9212='||k.nkr||' '||k.deal_tag);

                update fx_deal
                  set sumpb=nvl(sumpb,0)+abs(k.nkr)
                where deal_tag=k.deal_tag;
            elsif
                k.nbs='9212' and k.NKR<>0 and l_nlsd like '6209%' then
                --bars_audit.info('p_fxkb 2 ='||'9212='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpb=nvl(sumpb,0)-abs(k.nkr)
                where deal_tag=k.deal_tag;
            end if;


            --bars_audit.info('p_fxkp ='||k.nkr||'= '||k.deal_tag);
            update fx_deal
               set sump=nvl(sumpa,0)+nvl(sumpb,0)
               where deal_tag=k.deal_tag ;
         elsif  l_ref1 is null then
           --bars_audit.info('p_fxkp====>0'||k.nkr||'= '||k.deal_tag);
            update fx_deal
              set  sumpa=0, sumpb=0,  sump=0
             where deal_tag=k.deal_tag;

         end if;

       end;
       <<kin2>> NULL;
     end loop;

  elsif p_par=3 then       /*
                           ��������  3041, 3351 � ������� � 1819-980 �������� (�������� ���������)
                           */

   -- ��������� ���� 1819 (��������)  �� ��������� ������ ������ ���������
   --

     begin

       select  substr(nms,1,38),p_nls1819
         into  l_nms1819,l_nls1819
         from  accounts
        where  kv=980
          and  nls=p_nls1819;

        exception when no_data_found then
         bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
     end;
--  � ������ �������� ������ ��, �� ������� ��������� ���� �������� ������
--  �
     for k in (

           select  distinct o.ref,o.nlsa, o.nlsb, o.nazn,
                 sum(o.s) over (partition by o.nlsa,o.nlsb) s,
                 f.deal_tag,
          '�������� �������� �� ������.�����.����-����� Ref '||to_char(f.deal_tag)||'�'||d.ntik||'������ ���-'||d.kvb||' �� ���� ' ||ltrim(rtrim(to_char(d.sumb/100,'99999999999.99')))
                                NAZN3
         from  (select ref,nlsa,nlsb,s,nazn
                  from oper
                 where tt='FXK'
                   and sos=5
                   and nazn like '������%'
                  ) o,
                 fx_deal_ref f,
                 fx_deal d
          where f.ref=o.ref
            and d.deal_tag=f.deal_tag
            and d.dat_a<=bankdate_g
            and d.dat_b<=bankdate_g
            and d.dat_a=d.dat_b
            and  not exists (   -- ���� ��� �� ���� ������������ ���������� �� ������ ������
                     select 1
                       from fx_deal_ref
                      where deal_tag=f.deal_tag
                       and  ref in (
                             select ref
                               from oper
                              where tt='FXK'
                               and sos=5
                               and nazn like '������%'))

         )
     loop
       SAVEPOINT do_fxk3;
       begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
         if  k.s=0 then goto kin3;
         elsif substr(k.nlsa,1,4)='6209'   then
              l_nlsd:=l_nls3351; l_nmsa:=l_nms3351;
              l_nlsk:=l_nls1819; l_nmsb:=l_nms1819;
         elsif substr(k.nlsb,1,4)='6209'   then
              l_nlsd:=l_nls1819; l_nmsa:=l_nms1819;
              l_nlsk:=l_nls3041; l_nmsb:=l_nms3041;
         else  goto kin3;
         end if;

         BEGIN
           gl.ref (l_ref3);
       --bars_audit.info('3FXK S='||k.s||'ref='||l_ref3||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk||'l_nls3041='||l_nls3041||'l_nls3351='||l_nls3351);
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
            EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk3;
            bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
         END;

         if l_ref3 is not null then
            insert into fx_deal_ref (ref,deal_tag)
                 values (l_ref3,k.deal_tag);

          --bars_audit.info('p_fxk0 ='||'l_nlsd,l_nlsk,k.s==='||l_nlsd||'='||l_nlsk||'='||k.s);
         end if;

       end;
       <<kin3>> NULL;
     end loop;

  end if;
 end if;
 --bars_audit.info('p_fxkp-- commit');
 commit;
end p_FXK;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FXK.sql =========*** End *** ===
PROMPT ===================================================================================== 
