

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NOSW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NOSW ***

  CREATE OR REPLACE PROCEDURE BARS.P_NOSW (
  RefCvv_ NUMBER,
  RefNos_ NUMBER,
  NosBic_ VARCHAR2,
  NosAcc_ NUMBER ) IS

--***************************************************************--
-- (C) BARS. P_NOSW - ���������� ���.���������� �� ������� ��.
--
-- Version 1.4 12/09/2012
-- **********************
-- QWA 29/08/2012 (��� - �������� ����)
--     �������� ������ ����� VOSTRO, ���� ���� �����������
--     � ���� ����  VOSTRO ������� � ���������� "����������"
-- QWA 11/09/2012 (��� ���� - �������� ����)
--     �� ��������� RESPIDNO=1 �����
--     � ��. NOS oper.respid
--     ��� ���.����������� ��. CVV

--***************************************************************--

l_vostro       bic_acc.their_acc%type := '1600__';
l_val_resp     params.val%type := '0';
l_val_ref1     params.val%type := '0';
l_tt_cvv       oper.tt%type;
l_userid_cvv   oper.userid%type;

ern     CONSTANT POSITIVE := 101;
err     EXCEPTION;
erm     VARCHAR2(80);

BEGIN

 begin
  -- ��� ���������� ��������� ��������� ���� NOSTRO 'NOS_B'
  INSERT INTO OPERW(REF, tag, value) VALUES(RefCvv_, 'NOS_B', NosBic_);
  exception when dup_val_on_index then 
    null;
  end;

  -- ��� ���������� ��������� ��������� ���� NOSTRO 'NOS_A'
  UPDATE OPERW SET value=NosAcc_ WHERE REF=RefCvv_ AND tag='NOS_A';

  begin
     select their_acc into l_vostro from  bic_acc where acc = NosAcc_;
     if l_vostro <> '1600__' then
        update operw set value = '/'||l_vostro  where ref = RefCvv_ and tag = '53B';
        update operw set value = '/'||l_vostro  where ref = RefNos_ and tag = '53B';
    end if;
  end;

  begin
  -- �������� ���. ��������� ��������� � NOS
  INSERT INTO OPERW(REF, tag, value)
  SELECT RefNos_, tag, value FROM OPERW WHERE REF=RefCvv_;
  exception when dup_val_on_index then 
    null;
  end;

  -- ��������� ���������� ���������, ����������� ��� NOS
  begin
     select tt, userid into l_tt_cvv, l_userid_cvv from oper where ref = RefCvv_;
  exception when no_data_found then
     l_tt_cvv := null;
     l_userid_cvv := null;
  end;

 begin
  -- ��� ��������� NOS ��������� �������� ���������� ���������
  INSERT INTO OPERW (ref, tag, value) VALUES(RefNos_, 'NOS_R', RefCvv_);
  if l_tt_cvv is not null then
     INSERT INTO OPERW (ref, tag, value) VALUES(RefNos_, 'NOS_T', l_tt_cvv);
  end if;
   exception when dup_val_on_index then 
    null;
  end;

  -- �� ��������� RESPIDNO=1 � {NOSTOREF=0 (��� ������������)}
  -- �����  � ��. NOS oper.respid
  -- ��� ���.����������� ��. CVV
  begin
     select val into l_val_resp from params where par = 'RESPIDNO';
  exception when no_data_found then l_val_resp := '0';
  end;

  --  �������� NOS ����� ��� � CVV ��� �������
  begin
     select val into l_val_ref1 from params where par = 'NOSTOREF';   -- =1 ���� ����� ���.
  exception when no_data_found then l_val_ref1 := '0';
  end;

  if l_val_resp = '1' and l_val_ref1 <> '1' and l_userid_cvv is not null then
     update oper set respid = l_userid_cvv where ref = RefNos_;
  end if;

  -- ��������� ��������� ��� 1PB
  P_rekw_1pb(RefNos_, NosAcc_);

  -- ������� �� �������
  delete from sw_nostro_que where ref = refcvv_;

EXCEPTION WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-(20000+ern),SQLERRM,TRUE);
END;
/
show err;

PROMPT *** Create  grants  P_NOSW ***
grant EXECUTE                                                                on P_NOSW          to BARS013;
grant EXECUTE                                                                on P_NOSW          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NOSW          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NOSW.sql =========*** End *** ==
PROMPT ===================================================================================== 
