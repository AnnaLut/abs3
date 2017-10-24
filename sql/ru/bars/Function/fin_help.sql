
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fin_help.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FIN_HELP 
( IDF_  int,   KOD_  varchar2,   FDAT_ date,   OKPO_ varchar2 )
return char is
 -- 21-10-2005 STA - �� ���������� OKPO_

 sTmp_  varchar(250);
 sTmp1_ varchar(250);

 RNK_ int;

 NBS_ char(4);
 DAT_ date;
 S1_ number;
 S2_ number;
 nOkpo_ number;

BEGIN

 begin
    select MAX(rnk) into RNK_
    from customer where okpo=OKPO_ and okpo is not null;

    nOkpo_ := To_number(ltrim(rtrim(OKPO_)));

 EXCEPTION WHEN OTHERS THEN return to_char(null);
 end;

--����� F5:  (0) - ����
if idf_=0  then
   --����� F5:  (0) - ����
   If KOD_= '210' then
      --���������� 210. �� �������� ������ ��� ������������� ��������� ��������
      --                ����, ����� � ���� �������������
      begin
         --������� ��������� �� �������
         select round( Nvl(sum(gl.p_icurval(a.kv, s.kos ,FDAT_))/100000 ,0),1)
         into S1_
         from saldoa s, accounts a
         where a.rnk=RNK_ and a.tip in ('SP ','SPN') and a.acc=s.acc
           and s.dos>0 and s.fdat>= add_months(FDAT_,-3)  and s.fdat< FDAT_;
         sTmp_:='������.�����.�����='|| S1_;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;

      begin
         --�������
         select Round(
         Nvl(sum(gl.p_icurval(a.kv,-(s.ostf-s.dos+s.kos),FDAT_))/100000,0)
                ,1)
         into  S1_
         from saldoa s, accounts a
         where a.rnk=RNK_ and a.tip in ('SP ','SPN','SL ','SLN')
           and a.acc=s.acc
           and (s.acc,s.fdat)=
           (select acc, max(fdat) from saldoa
            where acc=s.acc and fdat <=FDAT_ group by acc);
         sTmp_ := sTmp_||' *' ||'������� �����.�����='|| S1_;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      Return sTmp_;

   elsIf KOD_= '200' then
      --���������� 200. �� ���������� �������� ������ (�������) ����������
      --                ���� �� ��������� �� �������� -
      --                ����, ���� ������������� ��������� � �����
      sTmp_ := '';
      sTmp1_:= fin_help(IDF_,'210', add_months(FDAT_,-3), OKPO_ ) ;
      Return sTmp1_;

   elsIf KOD_= '250' then
      --���������� 250  ���� ������������ ����������� -
      --                ��� ���� ����������� � ���.�������������
      select datea into DAT_ from customer where rnk=RNK_;

      sTmp_:='���� ��� � ���.��� '|| to_char(DAT_,'dd/mm/yyyy');

      If FDAT_ > DAT_ then
         sTmp_ := sTmp_ ||' * '|| round( (FDAT_- DAT_)/ 365,1) ||' ���';
      end if;
      Return sTmp_;
   end if;

elsIf IDF_=4 then

   --�����  F4:
   If KOD_='010' then
      --���������� 010 ����� ������� -
      --� ��������� �����������.�� �������� ����.
      begin
         select Round(
         Nvl(sum(gl.p_icurval(a.kv,-(s.ostf-s.dos+s.kos),FDAT_))/100000,0)
              ,1)
         into  S1_
         from saldoa s, accounts a
         where a.rnk=RNK_ and a.tip in ('SS ','SP ','SL ' )
           and a.acc=s.acc
           and a.MDATE>FDAT_
           and (s.acc,s.fdat)=
           (select acc, max(fdat) from saldoa
            where acc=s.acc and fdat <=FDAT_ group by acc);
         sTmp_ := '������� ��������� �����='|| S1_;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      Return sTmp_;

   elsIf KOD_='011' then
      --���������� 011 �������� �� ������
      --��� ��������� ������� ���� �� ���� ����
      begin
         select Round( Nvl(
                    sum(gl.p_icurval(a.kv,-(s.ostf-s.dos+s.kos),FDAT_)
                        * acrn.FPROCN(a.acc,0, s.FDAT)
                        *  (a.MDATE - FDAT_)/36500 ), 0)
                        /100000,1)
         into  S1_
         from saldoa s, accounts a
         where a.rnk=RNK_ and a.tip in ('SS ')
           and a.acc=s.acc
           and a.MDATE>FDAT_
           and (s.acc,s.fdat)=
           (select acc, max(fdat) from saldoa
            where acc=s.acc and fdat <=FDAT_ group by acc) ;
         sTmp_ := '������� ����������� ����.�����='|| S1_;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      Return sTmp_;

   elsIf KOD_='012' then
      --���������� 012
      --���������� ������� �������� ���������� �������� (������� ��������� ������������ �� �����)
      begin
        select max(mdate-FDAT_) into S1_
        from accounts where  rnk=RNK_ and tip='SS ' and MDATE>FDAT_;
        sTmp_ := '���������� ����='|| S1_|| ' ���� , ���='||Round(S1_/30,1) ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      Return sTmp_;
   end if;

elsIf IDF_=3 then
   --�����  F3:
   if KOD_='061' then
      --���������� 061 - ��� ����������� �� ���� 2600 �������
      -- �� ������� �������, ������� ��������� �� ���� �������
      begin
         select round( Nvl(sum(gl.p_icurval(a.kv, o.S, FDAT)),0)/100000,1)
         into S1_
         from accounts a, opldok o, oper p
         where a.rnk=RNK_ and a.nbs='2600' and a.acc=o.acc and o.dk=1 and
               o.sos=5 and o.FDAT>=add_months(FDAT_,-3) and o.FDAT<FDAT_
           and o.ref=p.ref and p.ID_A <>p.ID_B;
        sTmp_ := '����������� �� ���� 2600 �� ��.='|| S1_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      Return sTmp_;

   elsIf KOD_='070' then
      --���������� 070 ����� ������������ ��� ���������� 180 �������� �� 3(���).
      begin
        select S/3 into S1_
        from fin_rnk
        where idf=3 and OKPO=nOkpo_ and FDAT=FDAT_ and s is not null
          and kod='180';
        sTmp_ := '���������� 180/3='|| S1_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      Return sTmp_;
   end if;

end if;

return to_char(null);

end fin_help;
/
 show err;
 
PROMPT *** Create  grants  FIN_HELP ***
grant EXECUTE                                                                on FIN_HELP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FIN_HELP        to R_FIN2;
grant EXECUTE                                                                on FIN_HELP        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fin_help.sql =========*** End *** =
 PROMPT ===================================================================================== 
 