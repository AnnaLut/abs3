
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/op_bmask.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.OP_BMASK 
  ( P_BRANCH IN branch.branch%type,
    p_NBS    IN sb_ob22.R020%type ,
    P_OB22   IN sb_ob22.OB22%type ,
    P_GRP    IN ACCOUNTS.GRP%type ,
    P_ISP    IN ACCOUNTS.isp%type ,
    P_nms    IN accounts.nls%type ,
    P_nls   OUT accounts.nls%type ,
    P_acc   OUT accounts.nls%type
    ) is

/*
   01-06-2017 Nvv ������������� ��22 � 36 ����. ����� ������� f_ob22_num.

   27.06.2013 Sta ������������� ��� ��� (��� 980, 959) - �� ��� ���������� OP_BSOB_KV

   17-12-2012 Sta ��� ����������� ����� (���� ��� ��)
   01.08.2012 ��� �� SD ��� �� 60**
   05-11-2011 Sta+Yurchenko � �������� : ����� �� - �� ���������
   03-11-2011 Sta ����������� ����.������ � CCK_AN_TMP
   08-09-2011 �������� ��22 �� Z
              ��������� ������� NNNNNN � �������� ������ �� 14 ������
              ��������� ����������� ���������� ������ �����
   16-04-2011 ��� �� 11*  ������ = 959, ��� ������ 980.
              �������� ��22 J(19) ,  K(20)  ,  L (21)
   22-03-2011 ����� ������
   �� �������� ������� ����������� ����� ����� �� ������.

BBBBK9����FFFA
BBBB  - ���� _V �������
� - ����������� ������
9 - ������� ����������������� �����
O��� - ������ �B22
FFF - �������� ��� ����
A - (������ - 1, �� ���� ��������� ����� - �� 2, 3,)


   01-03-2011
   � ��������� ��������  ������ �� ����������� ����� � �� 22 :
   1.���� ���� �� ��� ������ - ��������� ���
   2.���� ���� ������ - ������ �������� ��� ��������� (�����, ��22,...)
   3.���� ���� ������ - �����������
   4.����� - ��������� �� ������

   28-02-2011   ���� ����� ����� = ��� 14 ������ - ������ �� ���������.
   ��������� ������ ���.����� � ��� ������������
   �� ���������������� ������
   �� �������������� ����� ������� ��
*/
--------------------
   l_mask NLSMASK.mask%type;

   l_OB3  char(4) ;
   l_ZZ   char(2) ;
   L_P4   INT     ;
   L_RNK  ACCOUNTS.RNK%TYPE ;
   L_ISP  ACCOUNTS.ISP%TYPE ;
   L_GRP  ACCOUNTS.GRP%TYPE ;
   L_nms  ACCOUNTS.nms%TYPE ;
   l_KV   ACCOUNTS.kv%TYPE  ;
   l_tip  ACCOUNTS.tip%TYPE := 'ODB';
   nTmp_  int;
   l_kodb char(6);
   l_ru varchar2(2);
--------------------
BEGIN

  If p_NBS like '11%' then 
    l_KV := nvl ( to_number( pul.get_mas_ini_val ('OP_BSOB_KV') ), 959);
  else                     
    l_kv := nvl ( to_number( pul.get_mas_ini_val ('OP_BSOB_KV') ), gl.baseval );
  end if;

  If p_NBS like '60__' then  
    l_tip := 'SD '; 
  end if;

  -- �������� �����
  begin
     select NVL( P_NMS, substr( P_ob22||' '|| replace (txt,'�','i'), 1, 50 ) ) 
       into l_nms
       from sb_ob22 
       where r020 = P_NBS 
         and ob22= P_OB22 
         and d_close is null;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN    
      raise_application_error(-20100,    '     : ����������� ���� ' || P_NBS || '/' || P_OB22  );
  end;


   -- ����� ��� ������
   begin
     select ru into l_ru 
       from kf_ru
       where kf=sys_context('bars_context','user_mfo');
   exception 
     when no_data_found then 
       l_ru:='01';
   end;

   l_rnk:='1'||l_ru;

   begin
      If GetGlobalOption('HAVETOBO') = '2' then     
        select to_number(val) 
          into L_RNK 
          from BRANCH_PARAMETERS 
          where tag='RNK' 
            and branch=P_BRANCH;
      end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN null ;
   end;

   if P_ISP  is null then
      -- ����� ����������� ��� ��
      L_ISP := gl.aUid;
      begin
         If GetGlobalOption('HAVETOBO') = '2' then  
           select to_number(val) 
             into L_ISP
             from BRANCH_PARAMETERS 
             where tag='AVTO_ISP' 
               and branch=P_BRANCH;
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN null ;
      end;
   else      l_isp := p_isp;
   end if;

   If P_GRP is null then
      -- ����� ������ ���� ��� ���.��
      begin
        select id 
          into L_GRP 
          from  groups_nbs 
          where nbs=P_NBS 
            and rownum=1;
      EXCEPTION 
        WHEN NO_DATA_FOUND  THEN 
          L_grp := null;
      end;
   else      
     l_GRP := p_GRP;
   end if;

  -- ����������� 2-� ���� ��22 (����) � 3-���� ��������
  /*
  If    substr(P_ob22,1,1) = 'A' then l_ob3 := '10' ;
  ElsIf substr(P_ob22,1,1) = 'B' then l_ob3 := '11' ;
  ElsIf substr(P_ob22,1,1) = 'C' then l_ob3 := '12' ;
  ElsIf substr(P_ob22,1,1) = 'D' then l_ob3 := '13' ;
  ElsIf substr(P_ob22,1,1) = 'E' then l_ob3 := '14' ;
  ElsIf substr(P_ob22,1,1) = 'F' then l_ob3 := '15' ;
  ElsIf substr(P_ob22,1,1) = 'G' then l_ob3 := '16' ;
  ElsIf substr(P_ob22,1,1) = 'H' then l_ob3 := '17' ;
  ElsIf substr(P_ob22,1,1) = 'I' then l_ob3 := '18' ;
  ElsIf substr(P_ob22,1,1) = 'J' then l_ob3 := '19' ;
  ElsIf substr(P_ob22,1,1) = 'K' then l_ob3 := '20' ;
  ElsIf substr(P_ob22,1,1) = 'L' then l_ob3 := '21' ;
  ElsIf substr(P_ob22,1,1) = 'M' then l_ob3 := '22' ;
  ElsIf substr(P_ob22,1,1) = 'N' then l_ob3 := '23' ;
  ElsIf substr(P_ob22,1,1) = 'O' then l_ob3 := '24' ;
  ElsIf substr(P_ob22,1,1) = 'P' then l_ob3 := '25' ;
  ElsIf substr(P_ob22,1,1) = 'Q' then l_ob3 := '26' ;
  ElsIf substr(P_ob22,1,1) = 'R' then l_ob3 := '27' ;
  ElsIf substr(P_ob22,1,1) = 'S' then l_ob3 := '28' ;
  ElsIf substr(P_ob22,1,1) = 'T' then l_ob3 := '29' ;
  ElsIf substr(P_ob22,1,1) = 'U' then l_ob3 := '30' ;
  ElsIf substr(P_ob22,1,1) = 'V' then l_ob3 := '31' ;
  ElsIf substr(P_ob22,1,1) = 'W' then l_ob3 := '32' ;
  ElsIf substr(P_ob22,1,1) = 'X' then l_ob3 := '33' ;
  ElsIf substr(P_ob22,1,1) = 'Y' then l_ob3 := '34' ;
  ElsIf substr(P_ob22,1,1) = 'Z' then l_ob3 := '35' ;
  else                                l_ob3 := '0' || substr(P_ob22,1,1);
  end if;

  l_ob3  := substr(l_ob3,1,2) || substr(P_ob22,2,1) ; */
  l_ob3  := f_ob22_num(P_ob22);
/*
    ������� ������������� ���� �� �����
    -----------------------------------
NEWNLSDESCR   A   = �����,        H   = ��22
NLSMASK       BR2 = ��� ����-�i��� �����.��� �����-2
              BR3 = ��� ����-�i��� �����.��� �����-3
*/

/*  PUL.Set_Mas_Ini( 'BRANCH', substr( substr(P_BRANCH,-4),1,3), 'Branch' );
  PUL.Set_Mas_Ini( 'OB22'  , l_ob3                           , 'ob22'   );
*/
/*  If length (p_BRANCH)>15 then l_ZZ:='00'; p_NLS:= f_newnls2(null,'BR3',p_NBS,L_RNK,null,null);
  else                         l_ZZ:='01'; p_NLS:= f_newnls2(null,'BR2',p_NBS,L_RNK,null,null);
  end if;*/

/*  -- ���� �� ����������. �� ��-�������:
  If p_NLS is null then

     If gl.aMfo in ('313957') then
        -- 313957 ���������
        --     BBBBk9bbbOOO
        -- �����. ��� ��������� 2  � 3 ������� ?
        -- nls=981959349103 , branch =/313957/000339/000349/, ob22='A3'
        p_NLS  := p_NBS  || '09' || substr( Substr(p_BRANCH,-7),4,3) || l_ob3 ;

     elsIf gl.aMfo in ('351823') then
        -- 351823 �������
        --     �����9SSS01bbb - ��� �������-2
        --     �����9SSS00bbb - ��� �������-3
        -- nls=9819�910301339 , branch =/351823/000339/       , ob22='A3'
        -- nls=9819�910300339 , branch =/351823/000339/060339/, ob22='A3'
        p_NLS  := p_NBS||'0'||l_ob3||l_ZZ||substr(Substr(p_BRANCH,-7),4,3);

     elsIf gl.aMfo in ('328845') then
        --    ����� ������
        -- �����90SSSbbbA
        -- SSS - ������ �B22
        -- bbb - �������� ��� ����
        -- A - (������ - 1, �� ���� ��������� ����� - �� 2, 3,)
        p_NLS  := p_NBS  || '09' || l_ob3|| substr( Substr(p_BRANCH,-7),4,3) ;

     else
        --  �� ��������
        --     �����0SSS01bbb - ��� �������-2
        --     �����0SSS00bbb - ��� �������-3
        -- nls=9819�010301339 , branch =/351823/000339/       , ob22='A3'
        -- nls=9819�010300339 , branch =/351823/000339/060339/, ob22='A3'
        p_NLS  := p_NBS||'0'||l_ob3||l_ZZ||substr(Substr(p_BRANCH,-7),4,3);

     end if;

  end if;*/


/*  begin
     -- ��� �����
     select 1 into nTmp_ from USER_TAB_COLUMNS  where TABLE_NAME = 'SB_OB22' AND COLUMN_NAME = 'KOD_B';
     begin
        execute immediate  'select nvl(kod_b,''800000'') from sb_ob22  where r020 = ''' || p_NBS || ''' and ob22 = ''' || p_OB22 || ''''  into l_kodb;
        P_NLS := p_NBS|| '0' || l_kodb  ;
     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
     -- ��� �������� ��� ���-�� ������
  end;
*/
/*  P_NLS  := vkrzn ( substr(gl.aMFO,1,5), p_NLS );*/

  -- 28-02-2011   ���� ����� ����� = ��� 14 ������ - ������ �� ���������.
--  If length(P_NLS) =14    then
    /*
     declare
       l_dazs accounts.dazs%type;
     Begin
       select dazs, acc   into l_dazs,p_ACC from accounts where kv=gl.baseval and nls= P_NLS;

       If l_dazs is null then
          -- 2.���� ���� ����� ������ ��������� - ���������� ��������,
          -- ?? �� ����������� � ���� ����� ������ ��� ����(���� �����)
          null;
       else
          -- 3.���� ���� ������ �� ����� ��������� � ������ - ���������� �������������
          update accounts set dazs=null where acc=p_ACC;
       end if;

     EXCEPTION WHEN NO_DATA_FOUND THEN
       --  1.���� ���� �������� ������� �� ������� ����������- ������� ����
       null;
     end;
*/
     declare
       v_cnt integer;
     begin
       loop
         p_nls := vkrzn(substr(gl.aMFO,1,5),p_nbs||'0'||lpad(round(dbms_random.value(0,1000000000)),9,'0'));
         select count(1) into v_cnt
           from accounts where nls = p_nls and kv = l_kv;
         exit when v_cnt = 0;
       end loop;
     end;
     --4.���� ���� ������ �� ��������� - ������ ��������� �� ������
     op_reg (99,0,0,L_GRP,L_p4,L_RNK, p_NLS, l_kv, l_NMS, l_tip,L_isp,p_ACC);
     insert into CCK_AN_TMP(acc) values (p_acc);

     RETURN;

--  end if;
  -------------------------

  -- ����� ����  ��� ����, ���������� NNNNNNN
  declare
    l_nls accounts.nls%type := P_NLS ;
    l_min               int := 0     ;
    l_len  int              := 14 - length (P_NLS) ;
    l_max  int ;
  begin
    l_max  := to_number ( rpad ('9', l_len, '9') ) ;

    WHILE l_min <= l_max
    loop
       p_NLS := l_nls || substr( '000000000' || l_min, -l_len );
       P_NLS := vkrzn ( substr(gl.aMFO,1,5), p_NLS );
       begin
          select 1 into nTmp_ from accounts where nls= p_nls and kv=980  ;
          l_min  := l_min + 1 ;
       EXCEPTION WHEN NO_DATA_FOUND THEN

          --4.���� ���� ������ �� ��������� - ������ ��������� �� ������
          op_reg (99,0,0,L_GRP,L_p4,L_RNK, p_NLS, l_kv ,l_NMS,l_tip,L_isp,p_ACC);
          insert into CCK_AN_TMP(acc) values (p_acc);

          RETURN;
       end;
    end loop;
  end;

  raise_application_error(-20100,  '     : ��������� �������� ��� ��� ' ||P_BRANCH||' '|| p_NBS||' '||P_OB22 );

end OP_BMASK  ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/op_bmask.sql =========*** End *** 
 PROMPT ===================================================================================== 
 