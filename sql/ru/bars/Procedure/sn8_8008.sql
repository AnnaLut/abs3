

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SN8_8008.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SN8_8008 ***

  CREATE OR REPLACE PROCEDURE BARS.SN8_8008 ( p_KF varchar2, p_tip number:=0, p_dat_ir date)  IS
--            ����-�������� ������ ����
-- ����� �������� ������� ��� ������� ���������� ������ (����� ��������������)
-- ����� ������� ��������� ������� ���������� ������� ������� � ���� � ������� ���� ��������� ����

--  p_KF - ��� ���
--  p_tip - 0 - ��� 2- �� 3- ��
--  p_dat_ir - �� ����� ���� ���������� ����. (null - �� ������������� ����)
-- ��������� ���������� ������� CC_KVSD8
-- 1 -- ��������� � ������ ������� ����� ����� 6 ����� � ������

  NLS_     accounts.NLS%type ;
  OSTC_    accounts.OSTC%type;
  ND_      cc_deal.ND%type       := -1 ;
  SPN_BRI  int                   := 100;
  NAM_BRI  BRATES.name%type      := '100.���.��. ��� (��� ���i ����*2)' ;
  COM_BRI  PARAMS$BASE.comm%type := '��: I�.���.������ ��� ���i';
  SPN_SD8  accounts.NLS%type     := '80060';
  COM_SD8  PARAMS$BASE.comm%type := '��:���. ��� ���i�� ���i';

   l_NLS    accounts%rowtype;
   l_s080   specparam.s080%type;
   l_count int:=0;


  RET_  int;
  ACC_  int;
  ACRB_ int;
begin

  bc.set_context;
  update brates set name= NAM_BRI where br_id=SPN_BRI;
  if SQL%rowcount=0  then
     Insert into BRATES (BR_ID, BR_TYPE, NAME) Values (SPN_BRI, 1, NAM_BRI);
  end if;

  bars_context.subst_mfo(p_KF);
  update PARAMS$BASE set val=SPN_BRI, comm=COM_BRI where par='SPN_BRI';
  if SQL%rowcount=0  then
     Insert into PARAMS$BASE (PAR,VAL,COMM) Values ('SPN_BRI',SPN_BRI,COM_BRI);
  end if;

  --SPN_BRI := to_number(GetGlobalOption('SPN_BRI')) ; -- ������� ������ ����;

  SPN_SD8 := VKRZN(substr(gl.aMFO,1,5), SPN_SD8);

  update PARAMS$BASE set val=SPN_SD8,comm=COM_SD8 where par='SPN_SD8';
  if SQL%rowcount=0  then
     Insert into PARAMS$BASE (PAR,VAL,COMM) Values ('SPN_SD8',SPN_SD8,COM_SD8);
  end if;
--  SPN_SD8 := GetGlobalOption('SPN_SD8') ;

  begin
    op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,980,COM_SD8,'SD8',null,ACRB_);
  exception when others then null;
   dbms_output.put_line('���� '||SPN_SD8||' � ������ 980 �� ������ '||SQLERRM);
  end;

  begin
    op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,840,COM_SD8,'SD8',null,ACRB_);
  exception when others then null;
   dbms_output.put_line('���� '||SPN_SD8||' � ������ 840 �� ������ '||SQLERRM);
  end;

  begin
    op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,978,COM_SD8,'SD8',null,ACRB_);
  exception when others then null;
   dbms_output.put_line('���� '||SPN_SD8||' � ������ 978 �� ������ '||SQLERRM);
  end;

  begin
    op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,643,COM_SD8,'SD8',null,ACRB_);
  exception when others then null;
   dbms_output.put_line('���� '||SPN_SD8||' � ������ 643 �� ������ '||SQLERRM);
  end;





  for k in ( select d.branch, d.nd, d.wdate
          from cc_deal d
          where d.sos<15 and d.vidd in (1,2,3,11,12,13)
            and ( (d.vidd in (1,2,3) and p_tip in (0,2))
                  or (d.vidd in (11,12,13) and p_tip in (0,3))
                )
            and not exists (select 1
                              from nd_acc n2,accounts a2
                             where n2.acc=a2.acc and n2.nd=d.nd and a2.dazs is null
                                  and  (a2.tip='SN8' or a2.nbs='8008')
                           )
            and exists (select 1
                          from nd_acc n3,accounts a3
                         where n3.acc=a3.acc and n3.nd=d.nd and a3.dazs is null
                           and a3.tip in ('SP ','SL ','SPN')
                       )
            and 0!=(select sum(ostc)
                      from nd_acc n3,accounts a3
                     where n3.acc=a3.acc and n3.nd=d.nd and a3.dazs is null
                           and a3.tip in ('SS ','SP ','SL ','SPN','SN ')
                   )

           )
  loop
   bc.subst_BRANCH(k.branch);

   select a.kv, a.nls, a.isp, a.grp, s.s080
     into l_nls.kv ,l_nls.nls,l_nls.isp, l_nls.grp,l_s080
     from accounts a,nd_acc n,specparam s
    where n.nd=k.nd and n.acc=a.acc and a.tip in ('SS ', 'SP ','SL ','SPN')
          and a.dazs is null and rownum=1;

   cck.cc_op_nls( k.ND, l_nls.kv ,VKRZN(substr(gl.aMFO,1,5),'80080'||substr(l_nls.nls,6,9) ), 'SN8', l_nls.isp, l_nls.grp,l_s080,k.wdate, ACC_);

   if p_dat_ir is not null and ACC_ is not null then
      update int_accn set acr_dat=p_dat_ir where acra=ACC_ and id=2 and (acr_dat < p_dat_ir or acr_dat is null);
   end if;
   l_count:=l_count+1;


  end loop;
  logger.info('CCK2  migr ������� ������ ����= '||l_count);
  dbms_output.put_line('CCK2  migr ������� ������ ����= '||l_count);
  commit;
  bc.set_context;

end SN8_8008;
/
show err;

PROMPT *** Create  grants  SN8_8008 ***
grant EXECUTE                                                                on SN8_8008        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SN8_8008.sql =========*** End *** 
PROMPT ===================================================================================== 
