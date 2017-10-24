

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MFK_ACCP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MFK_ACCP ***

  CREATE OR REPLACE PROCEDURE BARS.P_MFK_ACCP (p_dat date, p_basey number)
is
/*  �������� ������ ����������� ��������� ��� �������������
    ��������-���������, ������������� ����. ��������.
    ����������:
       ����� ��� ��������� � ������� ������� ��������
       ��������� ����� %% �� ����� � ������� ��� ��������,
       ������ � ���������� �������� ������ ���� ����������� %%
       (���� ������� ���������)
       ���� ��������� �� ����, ������� �� �����  ��������, �� ������ -
       �� �������������, �� ����������� � ���������� ��������.
       ���� ��������� ������� ������ ��� � ��������� �����.
       ���� �������� ����� ����� ����� ������� ����������.
       ���� ������ "��� ����"-"���� ������ %%" ����� � ������� test_mfkaccp.
       ������� int_accn ����������� �  test_int_accn_mfkd .

       ����� ���������� ��������� - ��. 1mfkd_table.sql

*/
l_nmsb  accounts.nms%type;  -- �������� ����� (��� %%)
l_nlsb  oper.nlsb%type;     -- ���� ��� %%
l_accb  accounts.acc%type;  /* acc �����  ��� %%           */
l_nbs   accounts.nbs%type;  /* nbs �����  ��� %%           */
l_tip   accounts.tip%type;  /* tip �����  ��� %%           */
l_tmp   varchar2(30);         /* ����� ��� ��������          */
l_id    number;             /* ID ���� �������� */
l_basey integer;
BEGIN

/*  �����  3902,3903 ����������, � ���������� ���������, ���� � cc_deal, cc_add - ������� �� */

for k in (
   select  a.acc,a.nls, a.nbs,a.kv,a.isp,a.sec,a.grp, a.nms, c.rnk, p.mfoperc
   from  accounts a,customer c, cc_deal d,  cc_add p    --, int_accn i,accounts b  -- ��� ���� �������� ������
   where a.nbs in ('3902','3903')
     and a.dazs is null
     and a.rnk=c.rnk
     and a.acc=p.accs
     and p.nd=d.nd
     and d.vidd in ('3902','3903')
     --and i.acc=a.acc    -- ��� %% �������� ������
     --and i.acra=b.acc
     --and ltrim(rtrim(substr(a.nls,6,9)))<>ltrim(rtrim(substr(b.nls,6,9)))
     order by a.rnk,a.nls
     )
/*
  ���� � ������� �������� ��������� ����������� ����� (������ ������)
  3902, 3903 - ���������� ������ �� ���
  �������� :
  and nls like'390__003')
*/
loop
   /* ��� ������� ����� 3902 , 3903 ������ �������� 3904,3905
     ���� ���� �� ������ - ������� c �������� ��� � ��������� 3902*/
   if   k.nbs='3902'
   then l_nbs:='3904';   l_id:=0;
   else l_nbs:='3905';   l_id:=1;
   end if;

   begin
        l_nlsb := sb_acc(l_nbs||'??????????',k.nls);
       -- bars_audit.info('mfk1 = l_nlsb'||l_nlsb);

      exception when others then
         raise_application_error(-20000, 'my error: nls='||k.nls||', nbs+='||l_nbs||'?????????'||', msg='
          ||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
   end;

  l_nmsb := TRIM(SUBSTR(k.nms,1,70));

  begin
      SELECT acc, nms INTO l_accb, l_nmsb
      FROM accounts
      WHERE nls=l_nlsb AND kv=k.kv AND dazs IS NULL;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
       if k.nbs='3902'
         then l_tip:='SN';
         else l_tip:='DEN';
       end if;
       OP_REG(6,k.acc,0,0,l_tmp,k.rnk,l_nlsb,k.kv, l_nmsb,l_tip,k.isp,l_accb);
  end;

--   ������������� %% ��������
--bars_audit.info('mfk2 = l_accb'||l_accb);

--select nvl(basey,0) into l_basey from tabval where kv=k.kv;
-- ��� �� ����� ��� ���� basey=0

  l_basey:=p_basey;

  begin
   Insert into BARS.INT_ACCN
     (ACC, ID, METR, BASEM, BASEY,
     FREQ, ACR_DAT,  TT,
     ACRA, S, IO, KF)
    Values
     (k.acc, l_id, 0, 0, l_basey,
      1, p_dat, '%MB',
      l_accb, 0, 0, sys_context('bars_context','user_mfo'));
      exception when dup_val_on_index then
      update int_accn set tt='%MB',acra=l_accb where acc=k.acc;
  end;  -- �������������� ����������

   update accounts set daos=p_dat where acc=l_accb;

--  �������� � ������� �������
   insert into test_mfkaccp (acc,accp) values (k.acc,l_accb);
   commit;
end loop;
end p_mfk_accp;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MFK_ACCP.sql =========*** End **
PROMPT ===================================================================================== 
