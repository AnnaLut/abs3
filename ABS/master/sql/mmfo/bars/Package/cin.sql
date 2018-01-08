CREATE OR REPLACE PACKAGE BARS.CIN IS

/*
26-09-2016 ��������� ����� 
17.12.2014 ��������� ��������������� ���������� ������ ��� ������� �� ������� ���.�����
 11.03.2013
 ������ � 719. ����������� �������� �������� (�������+�����) �� ������ ��� ����  ��������
 ������ � 721. ������ ���������
 ������ � 722. ���������  ����� �1.
*/

 cRnk    number;
 DAT_BEG date  ;
 DAT_END date  ;

 FUNCTION B return date   ;
 FUNCTION E return date   ;
 FUNCTION R return number ;

 --- ������������� ���� ������� �� ��������� 
 procedure UPD1 ( p_RI varchar2, p_kc0 number,  p_ka1 number,  p_ka2 number,  p_kb1 number, p_kb2 number, p_kb3 number); 
--------------------------------------------------------------------
-- SK_A1 : P����� ����� (��� ��������)  �� ������ ��� ���������
--------------------------------------------------------------------
 FUNCTION SK_A1
 ( p_REF   IN operw.ref%type,
   p_TAG   IN operw.TAG%type,
   p_mode  in int
 ) return  number;


--------------------------------------------------------------------
-- K_A2 : P����� �������� �� ��������
--------------------------------------------------------------------
 FUNCTION K_A2  (p_REF IN oper.ref%type ) return number;

-------------------------------------
 PROCEDURE PREV_DOK ( p_dat1 date, p_dat2 date ) ; -- ��������� ���������������� ����� ���������� �� ������ OPER +ARC_RRP �� ������� ����������� ���
-------------------------------------

 PROCEDURE KOM_ALL
( p_mode int,
  s_Dat1 varchar2,
  s_Dat2 varchar2,
  p_RNK cin_cust.rnk%type
) ;
--------------
 PROCEDURE  KOM_GOU( p_mode int);

END CIN;

/


CREATE OR REPLACE PACKAGE BODY BARS.CIN IS
  k_branch  varchar2(30);

--A1 : P����� �������� �� �������� - ���������� ����, ������ ����������� �� ���������� ������
--A2 : P����� �������� �� �������� - �� �����, ������ ����������� �� ���-�� ������, ���������
--�1 : P����� �������� �� �����    - �� �������, %  �� ����� ���������, �� arc_rrp
--�2 : P����� �������� �� �����    - �� �����, ������ ����������� �� ���-�� ���������� �� arc_rrp, ���������
--�0 : ���������

/*
 15.11.2017 ������ �� ���.���� ������
r020 = '6119'; ob22 = '16'  ;  TRANSFER_2017 : 6119 =>6519 , ��22 �� ��� � �����



 20.09.2016 ���������� ������� - � ��� ��.����������. �.�. � ��� ���������� ������.
 20.01.2015 ������ ����� �3 �� �������� ����� - c ������� � �������� ������� CIN_TKR
 12.01.2015 ���������� 3739 �� 3578
 25.12.2014 ������. ������� ����� ��� ����� �������
 ------------------------------------
 19.12.2014 Sta PREV_DOK  ��������� ���������������� ����� ���������� �� ������ OPER +ARC_RRP �� ������� ����������� ���
                ��.��� ����������� ������ = ���� ����
                ���� ���� � ���� ���. �� ����
 12.09.2014 Sta �������� ��������� � ��� 3739 ��  ���.�������� 3578 � ������� ������� �� �� PROCEDURE  KOM_GOU
                ��� ����� ���������� ����������. � ������ ��������
 11.03.2013
 ������ � 719. ����������� �������� �������� (�������+�����) �� ������ ��� ����  ��������
 ������ � 721. ������ ���������
 ������ � 722. ���������  ����� �1.

  14-01-2013 �������� �.�. <SchevchenkoSI@oschadnybank.com>
             ������� 6119/16 ������� ������ �� �������� �������.
             ������� �������� ������ �� ���� ���. ���������� ��� �������  �� �������� ���������.
             ��������� ������� �� ���� ����:        ���� � 0��� NN FFF      6119_001600RRR      ��,
                  ���� � ���������� �������
                  0��� � �������� �0� + �������� ��22 (������ �������� ������������ ������ ����)
                    NN - 00 ��� ����, � �.�. �����
                   FFF - ��� ���.
              /mmmmmm/rrrRRR/bbbbbb/
 22-08-2012 �.�������  �������� PS1 � PS2 �������� �� CI1 � CI2 ��������������.

*/

 FUNCTION B return date   is begin   return to_date   (pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy'); end B;
 FUNCTION E return date   is begin   return to_date   (pul.Get_Mas_Ini_Val('sFdat2'), 'dd.mm.yyyy'); end E;
 FUNCTION R return number is begin   return to_number (pul.Get_Mas_Ini_Val('RNK'   )              ); end R;

 --- ������������� ���� ������� �� ��������� 
 procedure UPD1 ( p_RI varchar2, p_kc0 number,  p_ka1 number,  p_ka2 number,  p_kb1 number, p_kb2 number, p_kb3 number) is
begin   update CIN_TKR set  kc0 = p_kc0 , ka1 = p_ka1 , ka2 = p_ka2 , kb1=p_kb1 , kb2 = p_kb2 , kb3 = p_kb3 where rowid = p_RI;
end UPD1;

--------------------------------------------------------------------
-- SK_A1 : P����� ����� (��� ��������)  �� ������ ��� ���������
--------------------------------------------------------------------
 FUNCTION SK_A1
 ( p_REF   IN operw.ref%type,
   p_TAG   IN operw.TAG%type,
   p_mode  in int
 ) return  number  IS
  l_s    oper.s%type     :=0 ;
begin

  begin
    If p_mode = 1 then  select a1*100 into l_s from cin_operw where ref= p_REF and tag = p_TAG;
    else                select  to_number(substr(value, instr( value,':',1)+1,5 )) * c.nom * c.kol*100     into l_s
       from cin_tag c, operw w  where c.tag = p_tag and w.tag = c.tag and w.ref=p_ref;
    end if;
  exception when others  then null;
  end;
  RETURN l_s;
end SK_A1;

--------------------------------------------------------------------
-- K_A2 : P����� �������� �� ��������
--------------------------------------------------------------------
FUNCTION K_A2  (p_REF IN oper.ref%type ) return number IS
   l_oper oper%rowtype   ;
   l_tk   cin_TK%rowtype ;
   l_s    oper.s%type    :=0 ;
begin
  begin
    select * into l_oper from oper where sos= 5 and ref = p_ref ;
    select * into l_tk from cin_TK where mfo= l_oper.MFOB and nls = l_oper.nlsb;
    If l_tk.S_A2 is null  then   select Nvl(s_a2,0) into l_tk.S_A2 from cin_cust where rnk = l_tk.RNK;  end if;
    l_s :=  l_tk.S_A2 * 100;
  exception when no_data_found then null;
  end;
  RETURN l_s;
end K_A2 ;
-----------------------------------------------------

PROCEDURE PREV_DOK ( p_dat1 date, p_dat2 date ) is -- ��������� ���������������� ����� ���������� �� ������ OPER +ARC_RRP �� ������� ����������� ���
 l_dat1 date; l_dat2 date ; l_dat11 date;

begin

 If p_dat1 is null or p_dat2 is null then  l_dat1 := add_months( trunc(sysdate,'MM'), - 1 ) ;    l_dat2 := last_day (l_dat1);  -- 01.12.2013
 else                                      l_dat1 := p_dat1;                                     l_dat2 := p_dat2 ;            -- 31.12.3012
 end if;

 l_dat11 := l_dat2 + 1;

 bc.GO ('300465');

 logger.info ('CIN.PREV_DOK/1-������: dat1='|| to_char(l_dat1, 'dd.mm.yyyy') || ' , dat2= ' || to_char(l_dat2, 'dd.mm.yyyy') );

 execute immediate 'truncate TABLE cin_ref' ;
 insert into cin_ref (ref, nlsa, mfob, nlsb, s , vdat )
               select ref, nlsa, mfob, nlsb, s , vdat
               from oper o where o.sos = 5 and o.tt  in ('IB1','IB2') and o.vdat >= l_dat1  and o.vdat < l_dat11  and mfoa = '300465'
                 and exists (select 1 from cin_cust u where u.NLS_2909 = o.nlsa );
 commit;
 logger.info ('CIN.PREV_DOK/2-OK. Oper' )   ;
 -------------------------------------------
 execute immediate 'truncate TABLE cin_rec' ;  ------- for �1 + �2 + �3 --- arc_rrp.REC
 insert into cin_rec (rec, dk, mfoa, nlsa, mfob, nlsb, s , dat_a  )
               select rec, dk, mfoa, nlsa, mfob, nlsb, s , dat_a
               from   arc_rrp  a
               where a.dk in (1,3)     and a.sos >= 5 and a.s >= 0
                 and a.dat_a >= l_dat1 and a.dat_a  < l_dat11   -- (l_dat2 + 1) ---- 01.12.2013 09:00:00  - 31.12.3012 23:00:00
                 and exists (select 1 from cin_cust u, cin_tk t
                             where u.rnk = t.rnk  and t.mfo = a.mfoa and t.nlsr = a.nlsa and u.mfo_2600 = a.mfob and u.nls_2600= a.nlsb
                             );
 commit;
 logger.info ('CIN.PREV_DOK/3-OK. Arc_Rrp' );

 logger.info ('CIN.PREV_DO4/4-���������� ������������ ������');

 -- ���� ����������
 dbms_stats.gather_table_stats('BARS', 'cin_ref');
 dbms_stats.gather_table_stats('BARS', 'cin_rec');
 logger.info ('CIN.PREV_DOK/3-���������� ���� ����������');

end PREV_DOK;

--------------
 PROCEDURE KOM_ALL
( p_mode int,
  s_Dat1 varchar2,
  s_Dat2 varchar2,
  p_RNK cin_cust.rnk%type
) is

--p_mode = 1    - F1. Գ������� ���������� + ��������/����� ���������
--p_mode = 3    - F2.������/����� Գ���-���������
--p_mode = 0....- 1.�������-���������� + �������� ���.(�� ��)


  p_Dat1 date   :=  to_date(s_Dat1,'dd.mm.yyyy');
  p_Dat2 date   :=  to_date(s_Dat2,'dd.mm.yyyy');
  l_DNIM int    ;
  l_DNI1 int    ;
  l_DNIK number ;

  l_rnk cin_cust.rnk%type := nvl(p_rnk,0);

  l_kolm number ; -- ��� ������� � ��������� �������.
                  -- ���� ������  �������� ������ �� 1 �����,
                  -- �� �������� �0 = ������ ���������, ���������� �� ��������� ����
begin
  cin.cRNK    := l_rnk   ;
  cin.DAT_BEG := p_Dat1  ;
  cin.DAT_END := p_Dat2  ;

  PUL.Set_Mas_Ini( 'RNK'   , to_char(l_RNK), 'RNK' );
  PUL.Set_Mas_Ini( 'sFdat1', s_Dat1,  'sFdat1' );
  PUL.Set_Mas_Ini( 'sFdat2', s_Dat2,  'sFdat1' );

  ---------------------------------------------------------------
  If p_mode = 3 then RETURN; end if;  --�������� ���� � ���������. ������������ ��� ���������� ������������� ���������
  ----------------------------------------------------------------
  l_DNIM := trunc( add_months(p_dat2,1),'MM') - trunc( p_dat2,'MM');
  l_DNI1 := p_dat2 - p_dat1 + 1;
  l_DNIK := l_DNI1/ l_DNIM;
  l_kolM := months_between(  p_Dat2 + 1 , p_Dat1  ) ;
-------------
--If p_mode = 0 then

   -- 0. ������  :  ������ - ���������
   If l_rnk = 0 then      execute immediate 'truncate TABLE cin_kom0 ';  else   delete from cin_kom0 where rnk = l_rnk ;   end if;

   insert into CIN_KOM0 (
          rnk,  id,   mfo,  branch,  --  ���~��
          ref,  -- REF ���~����� �~c����.~������
          s  ,  -- ����~����� �~c����.~������
          a2 ,  -- �2:�����
          KA2,  -- �2~���� ���i� ��~���� �� �������i~���i���
          KA1,  -- �1~���� ���i� ��~����������~���i���
          b2 ,  -- �2~����� ��~���� �� ������~���i���
          KB2,  -- �2~���� ���i� ��~���� �� ������~���i���
          b1 ,  -- �1~�����(%)~�� ���i�~���i���
          KB1,  -- �1~���� ���i�~�� ���i�~���i���
          SB1_MIN, --�1~�����-Min~�� �i����~�� ���i�
          B3 ,  -- �3~�����-�����~�  ���~�� ���/���i�
          KB3 , -- �3~���� ������~�� ���/���i�
          rec,  -- REC ���~����� �~�������~��i����
          sr ,  -- ����~���-����� �~�������~��i����
          s3 ,  -- ��� ������.�������
         dat1, dat2, vdat )
   select u.rnk,  t.id,  t.mfo,   t.branch ,   ---- ���~��  --------------------------------------------- A1+A2
          s.REF    , -- REF ���~����� �~c����.~������
          s.s/100 S, -- ����~����� �~c����.~������
          nvl(nvl(t.S_A2,u.S_A2),0) A2,  -- �2:�����
          nvl(nvl(t.S_A2,u.S_A2),0) KA2, -- �2~���� ���i� ��~���� �� �������i~���i���
          s.KA1,                         -- �1~���� ���i� ��~����������~���i���
          0 B2 , -- �2~����� ��~���� �� ������~���i���
          0 KB2, -- �2~���� ���i� ��~���� �� ������~���i���
          0 B1 , -- �1~�����(%)~�� ���i�~���i���
          0 KB1, -- �1~���� ���i�~�� ���i�~���i���
          0 B1_MIN, -- �1~�����-Min~�� �i����~�� ���i�
          0 B3    , -- �3~�����-�����~�  ���~�� ���/���i�
          0 KB3   , -- �3~���� ������~�� ���/���i�
          to_number(null) Rec, -- REC ���~����� �~�������~��i����
          to_number(null) sr , -- ����~���-����� �~�������~��i����
          to_number(null) s3 , -- ��� ������.�������
          p_dat1, p_dat2, s.vdat
   from cin_cust u, cin_tk t,
        (select o.ref, o.vdat, o.nlsa, o.mfob, o.nlsb, o.s, sum(cin.SK_A1(w.ref,w.tag, 1 ) )/100 KA1,  0 KB2, 0 KB1
         from cin_ref o, operw w where o.ref = w.ref group by o.ref, o.vdat, o.nlsa, o.mfob, o.nlsb, o.s    ) s
   where u.rnk = t.rnk and s.nlsa = u.nls_2909 and s.mfob = t.mfo and s.nlsb = t.nls  and l_RNK in (0, u.rnk)
   union all                                    ---------------------------------------------------------- �1 + �2 + �3
   select u.rnk,  t.id ,   t.mfo,   t.branch, ---- ���~��
          to_number(null) REF, -- REF ���~����� �~c����.~������
          to_number(null) S  , -- ����~����� �~c����.~������
          0 A2 , -- �2:�����
          0 KA2, -- �2~���� ���i� ��~���� �� �������i~���i���
          0 KA1, -- �1~���� ���i� ��~����������~���i���
          nvl( nvl( t.S_b2 ,u.S_b2  ), 0) b2 , -- �2~����� ��~���� �� ������~���i���
                 decode(a.dk,1,1      ,0) * nvl( nvl( t.S_b2 ,u.S_b2  ), 0 ) Kb2, -- �2~���� ���i� ��~������� ���� �� ������~���i���
          nvl( nvl( t.PR_B1,u.PR_B1 ), 0) B1 , -- �1~�����(%)~�� ���i�~���i���
          round( decode(a.dk,1,a.s/100,0) * nvl(nvl(t.PR_B1,u.PR_B1),0) /100, 2)  KB1, -- �1~���� ���i�~�� ���i�~���i���
          t.SB1_MIN,                            -- �1~�����-Min~�� �i����~�� ���i�
          nvl( nvl( t.S_b3 ,u.S_b3  ), 0 ) b3 , -- �3~�����-�����~�  ���~�� ���/���i�
                 decode(a.dk,3,a.s/100,0) *  nvl(nvl(t.S_b3 ,u.S_b3 ),0)  Kb3, -- �3~���� ������~�� ���/���i�
          a.rec    ,  -- REC ���~����� �~�������~��i����
          decode(a.dk,1,a.s/100,0) SR, -- ����~���-����� �~�������~��i����
          decode(a.dk,3,a.s/100,0) S3, -- ����~���-���.����� = ��� ��� �������
         p_dat1,p_dat2, trunc(a.dat_a)
   from cin_cust u, cin_tk t, cin_rec a
   where u.rnk = t.rnk and a.mfoa = t.mfo and a.nlsa = t.nlsr and a.mfob = u.mfo_2600  and a.nlsb = u.nls_2600  and l_RNK in (0, u.rnk) ;
---------------------------------------------------------------------------------------------------------------------------------------------
   If l_rnk = 0 then      execute immediate 'truncate TABLE cin_kom1 ';
   else                   delete from cin_kom1 where rnk = l_rnk;
   end if;

   -- 1. ������  :  ��������� �� �� ( ��������� + ������)
   insert into CIN_KOM1 ( rnk, id , mfo, branch,  KC0,      ref,  s ,      KA1, KA2,
                          rec,  sr, s3, KB1, KB2, KB3,      c0 ,   a2,      b1,  b2,  b3, SB1_MIN,  dat1, dat2 )
   select RNK, ID, MFO, branch,          Sum(KC0) KC0,  Sum(ref) REF, sum(S)  S ,      SUM(KA1) KA1, sum(KA2) KA2,
          Sum(rec) REc, sum(Sr) Sr, sum(S3) S3,   SUM(KB1) KB1, sum(KB2) KB2,  SUM(KB3) KB3 ,
          Sum(C0)  C0 , sum(A2) A2, sum(b1) b1,   sum(b2)  b2 , sum(b3 )  b3,  sum(SB1_MIN) ,  p_dat1, p_dat2
   from ( --�������� ���
         select RNK, ID, MFO, branch ,    0 KC0, -- ����� ���������
         count(REF) REF, sum(nvl(S ,0) ) S , SUM(KA1) KA1, sum(KA2) KA2, -- �����
         count(REC) REC, sum(nvl(sr,0) ) SR, sum(nvl(s3,0) ) S3, greatest( SUM(KB1) , max(SB1_MIN) ) KB1, sum(KB2) KB2, max(b3)*sum(s3) KB3, -- ����� + ������ �����
         0 C0, 0 a2, 0 B1, 0 B2, 0 B3, 0 SB1_MIN  -- ������
         from cin_kom0
         where l_RNK in (0, rnk)
         group by  RNK, ID, MFO, branch
         -- ��� ����� �� �2+�2+�1
         union all
         select t.RNK, t.ID, t.MFO, t.branch,   decode ( l_kolM,  1,  nvl(nvl(t.s_c0,u.s_c0),0) , round(nvl(nvl(t.s_c0,u.s_c0),0)*l_DNIK,2) )  KC0, --  ����� ���������
                0 ref, 0 s , 0 ka1, 0 ka2,                         -- �����
                0 REC, 0 SR, 0 s3 , 0 KB1, 0 KB2,       0 KB3,     -- �����
                nvl(nvl(t.s_c0    , u.s_c0  ),0) c0 ,   nvl(nvl(t.s_a2   , u.s_a2  ),0) a2,
                nvl(nvl(t.PR_B1   , u.PR_B1 ),0) B1 ,   nvl(nvl(t.S_b2   , u.S_b2  ),0) b2,  nvl(nvl(t.S_b3   , u.S_b3  ),0) b3,
                nvl(nvl(t.SB1_MIN,u.SB1_MIN),0) SB1_MIN
         from cin_cust u, cin_tk t
         where u.rnk = t.rnk and l_RNK in (0, u.rnk)
        )
   group by RNK, ID, MFO, branch   ;

   -- 2. ������  :  ��������� �� �� ( ����� ��)
   If l_rnk = 0 then      execute immediate 'truncate TABLE cin_kom2 ';
   else                   delete from cin_kom2 where rnk = l_rnk;
   end if;

   insert into  CIN_KOM2 ( dat1,  dat2, rnk,     KC0 ,       id ,     ref,      s ,     KA2 ,     KA1 ,     rec ,     sr,     s3 ,      kb2 ,     kb1 ,     kb3  )
                select   p_dat1,p_dat2, RNK, sum(KC0), count(id), Sum(Ref), sum(S), sum(KA2), SUM(KA1), sum(rec), sum(sr),sum(s3),  sum(Kb2), SUM(Kb1), sum(kb3)
                from cin_kom1
                where l_RNK in (0, rnk)
                group by RNK;

If p_mode = 1 then
   execute immediate 'truncate TABLE cin_tkr ' ;
   --����� ��������
   insert into cin_tkr
         (RNK,NMK,NLS_2909,ID,NAME,MFO,NLS,REF,S,KA2,KA1,KB2,KB1,DAT1,DAT2,VDAT,KC0,A2,B1, SB1_MIN, B2,C0,NLSR,REC,SR,BRANCH,  b3,kb3,s3 )
   select RNK,NMK,NLS_2909,ID,NAME,MFO,NLS,REF,S,KA2,KA1,KB2,KB1,DAT1,DAT2,VDAT,KC0,A2,B1, SB1_MIN, B2,C0,NLSR,REC,SR,BRANCH,  b3,kb3,s3 
   from cin_kom1 u   where l_RNK in (0, u.rnk);

end if;

end KOM_ALL;
----------------------------------

PROCEDURE  KOM_GOU( p_mode int) is
  S_all  number   ;
  s_GOU  number   ;
  s_RU   number   ;
  ---------------------------
  p_Dat2 cin_tkr.dat2%type  ;
  r_cust cin_cust%rowtype   ;
  r_BR   cin_branch_ru%rowtype     ;
  r_oper oper%rowtype       ;
  l_tt1  oper.tt%type       := 'CS1';
  l_tt2  oper.tt%type       := 'CS2';
  aa61   accounts%rowtype   ;
  ----------------------------
  SBO sb_ob22%Rowtype       ; --   r020 = '6119'; ob22 = '16'  ;  TRANSFER_2017 : 6119 =>6519 , ��22 �� ��� � �����
  ---------------------------
  l_rec  arc_rrp.REC%type   ;
  l_sos  oper.sos%type      ;
  n_Tmp  int                ;
  l_id_o oper.id_o%type     := '******';
  ---------------------------
begin

  If p_mode = 37 then -- ���������� 3739 � 3578
     for k in (select a.nls nlsA, substr(a.nms,1,38) nam_A, least ( a.ostc, - b.ostc) S,
                      b.nls nlsB, substr(b.nms,1,38) nam_B, c.okpo, u.txt6
               from accounts a, accounts b, cin_cust u, customer c
               where a.kv = 980 and a.ostc = a.ostb and a.ostc > 0 and a.nls = u.nls_3739 and u.rnk = c.rnk
                 and b.kv = 980 and b.ostc = b.ostb and b.ostc < 0 and b.nls = u.nls_3578 and  least ( a.ostc, - b.ostc) > 0
               )
     loop
       gl.ref(r_oper.REF);
       r_oper.nd    := Substr ('0000000000'|| r_oper.REF, -10);
       r_oper.nazn  := Substr ('������ ���� �� ������� ���������. ����� ��� ' || k.TXT6 , 1, 160 ) ;
       gl.in_doc3( ref_ => r_oper.REF, tt_   => l_tt1   , vob_ => 6       , nd_   => r_oper.nd, pdat_ => SYSDATE,
                   vdat_=> gl.bdate  , dk_   => 1       , kv_  => 980     , s_    => k.s      , kv2_  => 980    , s2_=> k.s,
                   sk_  => null      , data_ => gl.BDATE, datp_=> gl.bdate, nam_a_=> k.nam_A  , nlsa_ => k.nlsA ,
                  mfoa_ => gl.aMfo   , nam_b_=> k.nam_B , nlsb_=> k.nlsB  , mfob_ => gl.aMfo  , nazn_ => r_oper.nazn,
                  d_rec_=> null      ,                    id_a_=> k.OKPO  , id_b_ => gl.aOKPO , id_o_ => null   ,
                  sign_ => null      , sos_  => 1       , prty_=> null    , uid_  => null     )  ;
       gl.payv(0, r_oper.REF, gl.bDATE , l_TT1, 1 , 980 , k.nlsA, k.s, 980, k.nlsB , k.S   )  ;
    ---gl.pay (2, r_oper.REF, gl.bDATE ) ;
     end loop;
     RETURN;
  end if ;
  ------------------------------------------------------

  select max(dat2) into p_Dat2 from cin_tkr where ref_kom is null;
  If p_dat2 is null then      raise_application_error(-20100, '�� �������� ��������� ������' ) ;  end if;

  If to_number ( to_char( gl.bdate, 'DD') ) < 10 and to_char (p_dat2, 'yyyymm') < to_char ( gl.bdate, 'yyyymm') then
     select max(fdat) into  r_oper.vdat from fdat where fdat <= p_dat2;  r_oper.vob := 96 ;
  else                      r_oper.vdat := gl.bdate ;                    r_oper.vob :=  6 ;
  end if;


  ------------------------------- TRANSFER_2017 : 6119 =>6519 , ��22 �� ��� � �����
  begin select * into SBO from sb_ob22 where r020 = '6519' and ob22 ='16' and d_close is null;  
  EXCEPTION WHEN NO_DATA_FOUND THEN 
        begin select * into SBO from sb_ob22 where r020 = '6119' and ob22 ='16' and d_close is null;
        EXCEPTION WHEN NO_DATA_FOUND then raise_application_error(-20100, '�� �������� �������� � SB_Ob22 ��� R020=6519(6119), Ob22=16 ' ) ;
        end;
  end ;

  begin select * into aa61 from accounts where kv=980 and nbs = SBO.r020 and dazs is null and ob22 = SBO.ob22 and rownum = 1;
      aa61.nms := substr(aa61.nms,1,38);
  EXCEPTION WHEN NO_DATA_FOUND       THEN raise_application_error(-20100, '�� �������� ��������� ���. "�� ������� ������ ���������" '|| SBO.R020 || '.'|| SBO.OB22 || '  � ��� ' ) ;
  end;

  r_cust.rnk  := -1  ;
  r_BR.branch := '*' ;
  for k in (select rowid RI, c.* from cin_tkr c where c.dat2=p_dat2 and c.ref_kom is null order by c.rnk, c.branch, c.id )
  loop
    S_all := (k.KC0 + k.KA1 + k.KA2 + k.KB1 + k.KB2 + k.KB3 ) * 100;
    If S_all <= 0 then GOTO HET_; end if;
    -------------------------------------
    k_branch := k.branch;

    -- ���� - A
    If r_cust.rnk <> k.rnk then

       begin select *                into r_cust        from cin_cust where rnk = k.rnk;
             select substr(nmk,1,38) into r_oper.nam_a  from customer where rnk = k.rnk;
       EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100, '�� ������ ������ RNK='||k.rnk  ) ;
       end;

       -- ���������� �� ������ 3578:
       If p_mode = 3 then
          If r_cust.nls_3578 is not null then
             r_cust.nls_3739 := r_cust.nls_3578 ;
          else
             begin ----------------------------------------------------------------------------------- ����� 3578
                select nls into r_cust.nls_3739 from accounts where rnk = k.rnk and nbs= '3578' and ob22='09' and dazs is null and kv= 980 and rownum =1;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                declare aa37  accounts%rowtype ;  ---------------------------------------------------- ������� 3578
                begin select * into aa37 from accounts where nls = r_cust.nls_3739 and kv =980;
                      r_cust.nls_3739 := '357800109'|| substr('00000'||k.RNK, - 5) ;
                      r_cust.nls_3739 := VKRZN ( substr( gl.aMfo,1,5), r_cust.nls_3739 ) ;
                      op_reg ( 99, 0, 0, aa37.grp, n_Tmp, k.rnk, r_cust.nls_3739 , 980, '�����.���. �� �����.IH�����i�', 'ODB', aa37.isp, aa37.acc );
                      insert into specparam_int (acc, ob22) values (aa37.ACC,'09');
                EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100, '�� ������ ���� 3739 ��� ��='||k.rnk  ) ;
                end;
             end ;
             update cin_cust set nls_3578 = r_cust.nls_3739  where rnk = r_cust.rnk; ----------------- ��������� 3578
          end if;
       end if ; -- p_mode = 3
    end if;

    -- ���� �
    If r_BR.branch <> k.branch then
       begin   select * into r_BR from cin_branch_ru where branch = k.branch;
       EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20100, '�� ������ � ����������� branch ='||k.branch  ) ;
       end;

       r_oper.nam_b := substr(r_br.name,1,38);

--- OLD:  ��������� ������� �� ���� ����:        �����00��00FFF-    r_oper.nlsb  := vkrzn( substr(k.MFO,1,5), '6119000'|| l_ob22 ||'00'||substr (k.branch,12,3)  );
--- 10.11.2017  ������ ��� ������ ������ ��������� �� ���� ����:  6519�001600000 ( 6119*001600000 )
       r_oper.nlsb  := vkrzn( substr(k.MFO,1,5), SBO.R020 ||'000'|| SBO.ob22 ||'00000' );

    end if;
    s_GOU := round( k.KC0 * r_cust.PC0
                  + k.KA1 * r_cust.PA1
                  + k.KA2 * r_cust.PA2
                  + k.KB1 * r_cust.PB1
                  + (k.KB2+k.KB3) * r_cust.PB2 ,
                   0 ) ;
    s_RU  := S_All - S_GOU ;
    gl.ref(r_oper.REF);
    update cin_tkr set ref_kom = r_oper.REF where rowid = k.RI;
    r_oper.nd := substr(to_char(r_oper.REF), 1, 10);
    begin select substr(
             '���i�i� �� ������� �����.I������i�. '||k.branch||' '   || name ||
             '. ���i�� � ' || to_char(k.dat1,'dd.mm.yyyy')   ||' �� '|| to_char(k.dat2,'dd.mm.yyyy'),   1, 160 )
      into r_oper.nazn   from cin_tk where id = k.id;
    EXCEPTION WHEN NO_DATA_FOUND THEN      raise_application_error(-20100, '�� ������� ��='||k.id  ) ;
    end;

    begin  select okpo into r_oper.id_b from BANKS_RU where mfo = k.mfo;
    EXCEPTION WHEN NO_DATA_FOUND THEN   r_oper.id_b := gl.aOkpo;
    end;

    If s_RU >0 and k.mfo <> gl.aMfo then
                               r_oper.d_rec := '#CBRANCH:'  ||k_branch|| '#';
       If r_oper.vob = 96 then r_oper.d_rec := r_oper.d_rec || 'D'    || to_char (r_oper.vdat, 'YYMMDD') ||'#' ;  end if;

       gl.in_doc3( ref_ => r_oper.REF  , tt_   => l_tt2       , vob_  => r_oper.vob , nd_   => r_oper.nd   , pdat_ => SYSDATE,
                   vdat_=> r_oper.vdat , dk_   =>  1          , kv_   => 980        , s_    => s_RU        , kv2_  =>  980   , s2_=> s_RU,
                    sk_ => null        , data_ => gl.BDATE    , datp_ => gl.bdate   , nam_a_=> r_oper.nam_a, nlsa_ => r_cust.nls_3739,
                   mfoa_=> gl.aMfo     , nam_b_=> r_oper.nam_b, nlsb_ => r_oper.nlsb, mfob_ => k.mfo       , nazn_ => r_oper.nazn    ,
                  d_rec_=> r_oper.d_rec, id_a_=> gl.aOKPO     , id_b_ => r_oper.id_b, id_o_ => l_id_o      ,
                  sign_ => null        , sos_  =>  1          , prty_ => null       , uid_  => NULL        )      ;

        paytt(0, r_oper.REF, gl.bDATE, l_TT2, 1, 980, r_cust.nls_3739, s_RU , 980, r_oper.nlsb   , S_ru) ;

    Else
       gl.in_doc3( ref_ => r_oper.REF , tt_   => l_tt1       ,  vob_ => r_oper.vob, nd_   => r_oper.nd   , pdat_ => SYSDATE,
                   vdat_=> r_oper.vdat, dk_   => 1           ,  kv_  => 980       , s_    => s_ALL       , kv2_  => 980    , s2_=> s_ALL,
                   sk_  => null       , data_ => gl.BDATE    ,  datp_=> gl.bdate  , nam_a_=> r_oper.nam_a, nlsa_ => r_cust.nls_3739 ,
                  mfoa_ => gl.aMfo    , nam_b_=> aa61.nms    ,  nlsb_=> aa61.nls  , mfob_ => gl.aMfo     , nazn_ => r_oper.nazn,
                  d_rec_=> null       ,                         id_a_=> gl.aOKPO  , id_b_ => gl.aOKPO    , id_o_ => null   ,
                  sign_ => null       , sos_  => 1           ,  prty_=> null      , uid_  => null        )     ;

       If s_RU >0 then  gl.payv(0, r_oper.REF, gl.bDATE, l_TT1, 1, 980, r_cust.nls_3739, s_RU, 980, aa61.nls  , S_RU );
          update opldok set txt ='���ici� ������ i������i� �������� ��' where ref = gl.aRef and stmt= gl.astmt;
       end if;

    end if;

    If s_GOU >0 then
       gl.payv(0, r_oper.REF, gl.bDATE, l_TT1, 1, 980, r_cust.nls_3739, s_GOU , 980, aa61.nls , S_GOU );
       update opldok set txt ='������� ���ici� �� ��������� �� ������� i������i�' where ref = gl.aRef and stmt= gl.astmt;
    end if;
    ---------------------
    <<HET_>>  null;

  end loop;

end KOM_GOU;

END CIN;
/

GRANT execute ON BARS.CIN TO BARS_ACCESS_DEFROLE;