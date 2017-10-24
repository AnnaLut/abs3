

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KL_SMSCODE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KL_SMSCODE ***

  CREATE OR REPLACE PROCEDURE BARS.KL_SMSCODE (p_rnk          IN     NUMBER DEFAULT NULL,
                                        p_phonenumber  IN     VARCHAR2,
                                        p_code         IN     NUMBER DEFAULT NULL,
                                        p_result          OUT INT,
                                        p_msg             OUT VARCHAR2)
IS
 title          constant varchar2(11) := 'KL_SMSCODE:';
 l_time         constant number := 0.1;         -- ����� �� �������� ��� (����� �������� ��������� ���� �� ������ ��� �����)
 l_encode       constant VARCHAR2(3) := 'lat';  -- ��������� ��� (cyr, lat)
 l_verified     int := 0;
 l_errmsg       varchar2(4000) := '';
 l_code         number(6);
 p_msgid        msg_submit_data.msg_id%type;

begin
 bars_audit.info(title || 'start with params: p_code=>' || to_char(p_code) || ',p_phonenumber=>'||p_phonenumber|| ',p_rnk=>' || to_char(p_rnk));
 if p_code is null -- ������ �����, ������������ ��� ��� �� ������
 then
     -- 1) ����������� ������ ��������
     l_verified := verify_cellphone(p_phonenumber);
     if l_verified = 0
     then l_errmsg := '���������� �����'|| p_phonenumber ||' �� ������� �����������';
          BARS_AUDIT.INFO(title || l_errmsg);
     else
      -- 2) ��������� ���������� 6-�������� ����
      l_code := dbms_random.value( low => 100000, high  => 999999);

      -- 3)������� ������ �������� + ���� (��������� 6 ����) �� ��������� �������
      insert into kl_cellphone_code(RNK, PHONENUMBER, CODE, SMS_STATUS)
      values(p_rnk, p_phonenumber, l_code, 0);

      -- 4) �������� ���
      begin
          bars_sms.create_msg(
            p_msgid             => p_msgid,
            p_creation_time     => sysdate,
            p_expiration_time   => sysdate + l_time,
            p_phone             => p_phonenumber,
            p_encode            => l_encode,
            p_msg_text          => to_char(l_code));

            UPDATE kl_cellphone_code
               SET EFFECTDATE = SYSDATE,
                   SMS_STATUS = '����������� �����������',
                   sms_id = p_msgid
             WHERE phonenumber = p_phonenumber
               AND code = l_code;
      exception when others
                then l_errmsg := '����������� �� ������� ����������'|| p_phonenumber;
                     BARS_AUDIT.INFO(title || l_errmsg);
      end;

      begin
           bars_sms.submit_msg(p_msgid => p_msgid);

            UPDATE kl_cellphone_code
               SET EFFECTDATE = SYSDATE,
                   SMS_STATUS = '����������� ����������'
             WHERE phonenumber = p_phonenumber
               AND code = l_code
               and sms_id = p_msgid;
       exception when others
                then l_errmsg := '����������� �� ������� ���������'|| p_phonenumber;
                     BARS_AUDIT.INFO(title || l_errmsg);
      end;
      -- ���������� ������� �� ������� ���������:
      -- ���� �������� ��� ���� �� ���-����������, � ������� ��� ���, ������� ���������� Ok
      begin
        select last_error
          into p_msg
          from msg_submit_data
         where msg_id = p_msgid;
      exception when no_data_found then p_msg := null;
      end;

      if p_msg is not null
      then
       UPDATE kl_cellphone_code
               SET EFFECTDATE = SYSDATE,
                   SMS_STATUS = substr(p_msg,1,100)
             WHERE phonenumber = p_phonenumber
               AND code = l_code
               and sms_id = p_msgid;
      end if;
     end if;
 else -- ������ �����, ������������ ���� ��� �� ���� �������
   begin
       select 0
         into p_result
         from kl_cellphone_code
        where (rnk = p_rnk or p_rnk is null)
          and phonenumber = p_phonenumber
          and code = p_code
          and EFFECTDATE >= sysdate - 1/24;
   exception when no_data_found
             then p_result := 1;
             l_errmsg := '�������� ��� �� ������� � �����������'|| p_phonenumber;
                        BARS_AUDIT.INFO(title || l_errmsg);
   end;

   if p_result = 0 -- ����������� ��� 0!
   then
    delete from kl_cellphone_code where phonenumber = p_phonenumber;
    if p_rnk is not null
    then
     update person
        set cellphone_confirmed = 1
      where rnk = p_rnk;
    end if;
   end if;
  end if;
 bars_audit.info(title || 'finished with params: p_code=>' || to_char(p_code) || ',p_result=>'||p_result);
 p_msg := l_errmsg;
end;
/
show err;

PROMPT *** Create  grants  KL_SMSCODE ***
grant EXECUTE                                                                on KL_SMSCODE      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KL_SMSCODE.sql =========*** End **
PROMPT ===================================================================================== 
