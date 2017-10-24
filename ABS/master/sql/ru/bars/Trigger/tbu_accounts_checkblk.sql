

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_CHECKBLK ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK 
before update of blkd on accounts
for each row
declare
  l_acc_blkid number;
  l_dpa_blk   number;
  l_nbs       varchar2(4);
  l_fnr       lines_f.fn_r%type;
  l_idpr      lines_f.id_pr%type;
  l_err       lines_f.err%type;
  l_dat       lines_f.dat%type;
  i           number;
begin

  -- "������� �� ������� � ��"
  l_acc_blkid := nvl(to_number(getglobaloption('ACC_BLKID')),0);
  -- "����������� �� ��������� ����������� ��� ��������� ������� � ���"
  l_dpa_blk   := nvl(to_number(getglobaloption('DPA_BLK')),0);

  -- �������� �� ���������� "������� �� ������� � ��"
  --    (��������������� ������������� ��� �������� ����� ��� �������� ����������).
  --    ���� ���� ������������, � ��� ���������� �� ����������.
  --    �������� ��� ���������� ����� ������������, �������� ��� ����� ������.
  if l_acc_blkid > 0 then

     -- ��������� ����������
     if (:new.blkd <> :old.blkd) and
        (:new.blkd = l_acc_blkid or :old.blkd = l_acc_blkid) then

        -- �������� �� ������������
        -- ���� ������������ ������ �������, ������ ��� ����� ������
        begin
           select 1 into i from v_mainmenu_list where id = user_id and upper(funcname) like 'FUNNSIEDITF%V_ACC_BLK_ACT%P_ACC_UNBLOCKACT%';
        exception when no_data_found then
           -- ��������� �����������/�������������� ���� ����� '�� ������ � ��������'
           bars_error.raise_nerror('CAC', 'ACCOUNT_BLK_ACT_ERROR');
        end;

        -- ���� ���� ������������ � ���, ������ ��� ���������� "����������� �� ��������� ����������� ��� ��������� ������� � ���"
        if l_dpa_blk > 0 then
           if :old.blkd = l_acc_blkid and :new.blkd <> l_acc_blkid and nvl(:new.vid,0) > 0 then
              -- ���������� ����� ������ �� ����. dpa_nbs
              begin
                 select unique nbs into l_nbs from dpa_nbs where type in ('DPA','DPK','DPP') and nbs=:new.nbs;
                 :new.blkd := l_dpa_blk;
              exception when no_data_found then
                 null;
              end;
           end if;
        end if;

     end if;

  end if;

  -- �������� �� ���������� "����������� �� ��������� ����������� ��� ��������� ������� � ���"
  --    (��������������� ������������� ��� �������� �����).
  --    ���������� ��������� ������������� ��� ��������� ��������� �� ���.
  --    ��� ������ ��������������� ����� ��������.
  -- ��� ���������� ������
  if l_dpa_blk > 0 then
     if :old.blkd >= l_dpa_blk and :new.blkd < l_dpa_blk and :new.vid <> 0 then
        -- ���� ���?
        begin
           select 1 into i
             from dpa_nbs
            where type in ('DPA','DPK','DPP')
              and nbs = :new.nbs
              and taxotype in (1, 6)
              and rownum = 1;
           -- ���� �������� � ���?
           begin
              select fn_r, id_pr, err, dat
                into l_fnr, l_idpr, l_err, l_dat
                from lines_f f
               where nls = :new.nls
                 and kv  = :new.kv
                 and otype in (1, 6)
                 and dat = (select max(dat) from lines_f where nls=f.nls and kv=f.kv and otype=f.otype);
              if ( -- �������� ��������� @R
                   (l_fnr like '@R%' or l_fnr like '@I%') and
                   -- 0-��� �������
                   -- 5-������� ��� �������� �� �����
                   nvl(l_idpr,0) in (0, 5) and
                   --  0000-��� �������
                   nvl(l_err,'0000') = '0000' )
              or ( -- �������� ��������� @F2
                   l_fnr like '@F2%' and
                   -- �� ����� ���������� �������� ��� ��� �������� ��������� @F1 �� @F2 ����������� ������������� �������
                   trunc(l_dat) < bankdate )
              then
                 -- ��� ���������
                 null;
              else
                 -- ��������� �������������� ���� �� ��������� ��������� � ���������� ����� �� ���
                 bars_error.raise_nerror('CAC', 'ACCOUNT_BLK_DPA_ERROR');
              end if;
           -- ���� � ��� �� ����������� (�.�. ������ ����)
           exception when no_data_found then null;
           end;
        exception when no_data_found then null;
        end;
     end if;
  end if;

end;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 
