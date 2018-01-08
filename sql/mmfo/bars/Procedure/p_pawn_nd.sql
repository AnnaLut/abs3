PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PAWN_ND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PAWN_ND ***

  CREATE OR REPLACE PROCEDURE BARS.P_PAWN_ND 
 (p_nd     number  , -- ref ��� ��� 0 ��� null
  p_accZ   number  , -- ���� ������
  p_ob22   varchar2,
  p_accS   number  , -- ���� ������
  p_grp    number  ,
  p_ree    varchar2,
  p_CC_IDZ varchar2,
  p_sdatz  date    ,
  p_mdatz  date    ,
  p_idz    number  ,
  p_SV     number  ,
  p_dpt    varchar2,
  p_12     number  ,
  p_pawn   number default null
 ) is

/*
 26-05-2016 LUDA ���������  ���������� ��������
 25-08-2015 LUDA �������� "����� 䳿 ������" ������� ���� � ACCOUNTS(MDAT)
 18.02.2015 Sta  ������ � C:\bars98\SQL\PATCHES.2\patch505_cp.sql - ��� ��� ���. ��� ���� ��

 02.12.2014 Sta  E��� ��� � SPECPARAM ....
 19-05-2014 LUDA ��� ������ � CC_ACCP �� ������������ ���.�������� (ND)
                 � ������ ����� ������ ��� �������� �������� 'SNO'- ���������� %
 24.07.2013 Sta  �������� �������� ������ � ������ �� ������� �������� ������ (�����).
 21.06.2013 Luda Update pawn_acc sv=p_sv*100 - ������� SV.
 ������.������
...\SQL\ETALON\PROCEDURE\p_pawn_nd.sql
 � Bars017.apd (�� 16.04.2013, � ��� �. ��� �� K:\sta\libbrary\BARS017.APL )

����������� �����������, ������������ � W4
*/

  l_dpt number;
  ---------------------
  procedure acc1
   (p_nd     number, -- ref ��� ��� 0 ��� null
    p_accZ   number, -- ���� ������
    p_accS   number, -- ���� ������
    p_12     number
   ) is
     sp specparam%rowtype;    l_branch varchar2(30) := null;
  begin
     update cc_accp set pr_12= nvl(p_12,1), nd = p_nd where ACCS=p_ACCS and ACC=p_AccZ;
     IF SQL%rowcount=0 then INSERT INTO cc_accp (ACC,ACCS,pr_12,nd) VALUES (p_accZ,p_accS,nvl(p_12,1),p_nd); END if;

     begin select * into sp from specparam where acc = p_accS;
           UPDATE specparam SET s080 = nvl(s080,sp.s080), s090 = nvl(s090,sp.s090), s180 = nvl(s180,sp.s180)  WHERE  acc =p_accz;
           IF SQL%rowcount=0 then  INSERT INTO specparam (ACC,S080,S090,S180) VALUES (p_accZ,sp.s080,sp.s090,sp.s180);   END if ;
     EXCEPTION WHEN NO_DATA_FOUND THEN null ;
     end;

     If nvl(p_nd,0) >0 then
        begin select branch into l_branch from cc_deal  where nd = p_nd  ; EXCEPTION WHEN NO_DATA_FOUND THEN null ; end;
     end if;

     If l_branch is null then
        begin select tobo   into l_branch from accounts where acc= p_accs; EXCEPTION WHEN NO_DATA_FOUND THEN null ; end;
     end if;

     If l_branch is NOT null then  update accounts set tobo = l_branch where acc=p_ACCZ and tobo <> l_branch;  end if;

  end acc1;
  ----------------------
begin
  If nvl(p_accz,0) <=0 then RETURN; end if;

  -- ��������� ����� �����������
  UPDATE accounts SET grp = p_grp, mdate = p_mdatz  where  acc = p_accZ;
  If p_dpt is not null then   begin l_dpt := to_number(trim(p_dpt));   exception when others then l_dpt := null;  end;  end if;
  UPDATE pawn_acc SET nree=p_ree, cc_idz = p_cc_idz, sdatz = p_sdatz, idz=p_IDZ, SV = p_SV*100, deposit_id=l_dpt, pawn = nvl(p_pawn, pawn) WHERE acc= p_accZ;
  if getglobaloption('HAVETOBO') = 2 or gl.amfo ='300465' then
     begin                                 execute immediate 'INSERT INTO specparam_int (ACC,OB22) VALUES ('||p_accZ||','''||p_ob22||''' )';
     EXCEPTION WHEN DUP_VAL_ON_INDEX THEN  execute immediate 'UPDATE specparam_int SET OB22='''||p_ob22 ||''' WHERE  acc = '||p_accZ ;
     end;
  end if;

 ---
  If    nvl(p_nd,0) = 0 and p_accs > 0 then acc1( 0,p_accZ,p_accS,p_12); ------- ���  ���, �� ���� 1 ���� ���� ������
  elsIf     p_nd    > 0 and p_accs > 0 then ------------------------------------ ���� ���, � ���� ���� �� 1 ���� ������
     FOR k in  (SELECT n.acc ACCS   FROM nd_acc n, accounts a, cc_deal d
                WHERE n.nd=d.nd and n.acc = a.acc AND n.ND= p_nd  AND
                     (d.vidd <> ovrn.vidd AND a.tip     in ('SS ','SL ','SP ','CR9','SN ','SNO','SPN') or
                      d.vidd =  ovrn.vidd AND a.tip not in ('OVN') )         -- ���������� ��������
                Union ALL SELECT Acc          FROM acc_over WHERE nd = p_nd  -- ������� ����������
                Union ALL SELECT Acc_9129     FROM acc_over WHERE Acc_9129 is not null and nd =p_ND )
     LOOP  acc1( p_nd, p_accZ,  k.ACCS,  p_12);
     end loop;

  elsIf     p_nd    > 0 and p_accs is null then ----------- 18.02.2015 Sta----- ���� ���= ID ��, ��� ����� ������
     begin execute immediate 'insert into cp_accp (id, acc) values ( '|| p_nd || ',' || p_accz ||' ) ' ;
     EXCEPTION WHEN DUP_VAL_ON_INDEX THEN  null;
     end ;
  end if ;

end p_pawn_nd;
/
show err;

PROMPT *** Create  grants  P_PAWN_ND ***
grant EXECUTE                                                                on P_PAWN_ND       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_PAWN_ND       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PAWN_ND.sql =========*** End ***
PROMPT ===================================================================================== 
