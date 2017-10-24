

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_SET_STATUS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_SET_STATUS ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_SET_STATUS (
  p_ref       number,
  p_rec       number,
  p_status    varchar2,
  p_comments  varchar2,
  p_blk       number )
is
  l_status varchar2(100);
  l_id number;
begin

  begin
     select status into l_status
       from finmon_que
      where decode(p_ref,null,rec,ref) = decode(p_ref,null,p_rec,p_ref);
  exception when no_data_found then
     l_status := null;
  end;

  -- �� ���������� ��������� ���� ��� ��������� � ��������
  --   ������, ��������� ��� ��� ������������� �������.
  if p_status = 'I' and l_status is not null and l_status not in ('S', 'B') then
     -- ���������� ����������: ��������� ��������� ������� � %s �� %s ��� ��������� %s
     bars_error.raise_nerror('DOC', 'FM_ERROR_STATUS', l_status, p_status, nvl(p_ref,p_rec));
  end if;

  if l_status is null then
     select s_finmon_que.nextval into l_id from dual;
     insert into finmon_que (id, ref, rec, status, agent_id, comments)
     values (l_id, p_ref, p_rec, p_status, user_id, p_comments);
  else
     update finmon_que
        set status = p_status,
            comments = p_comments
      where decode(p_ref,null,rec,ref) = decode(p_ref,null,p_rec,p_ref);
  end if;

  -- ���� ��������������� ������ N (� ��������) - ������ ��� ����������
  if p_rec is not null and p_blk = 131313 and p_status = 'N' then
     update arc_rrp set blk = 131312 where rec = p_rec;
  end if;

end p_fm_set_status;
/
show err;

PROMPT *** Create  grants  P_FM_SET_STATUS ***
grant EXECUTE                                                                on P_FM_SET_STATUS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_SET_STATUS to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_SET_STATUS.sql =========*** E
PROMPT ===================================================================================== 
