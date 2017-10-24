
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_date_cck.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_DATE_CCK (CC_ID_ VARCHAR2,DAT1_ DATE)  RETURN DATE
IS
--- ������� ���������� ������ ������ ������� ������������� ���������� ����������� ���!!!!!!

       nRet_   int;     -- ��� ��������: =1 �� ������, ������ =0
       sRet_   varchar2(256); -- ����� ������ (?)
       RNK_    int;     -- ��� � ��������
       nS_     number;  -- ����� �������� �������
       nS1_    number;  -- ����� �������������� �������
       NMK_    operw.value%type; -- ������������ �������
       OKPO_   customer.okpo%type; -- OKPO         �������
       ADRES_  operw.value%type; -- �����        �������
       KV_     accounts.KV%type;  -- ��� ������   ��
       LCV_    tabval.LCV%type;    -- ISO ������   ��
       NAMEV_  tabval.NAME%type;  -- �����a       ��
       UNIT_   tabval.UNIT%type;  -- ���.������   ��
       GENDER_ tabval.GENDER%type; -- ��� ������   ��
       nSS_    number;  -- ���.����� ���.�����
       DAT4_   date;    --\ ���� ���������� ��
       nSS1_   number;  --/ �����.����� ���.�����
       DAT_SN_ date;    --\ �� ����� ���� ��� %
       nSN_    number;  --/ ����� ��� %
       nSN1_   number; -- | �����.����� ����.�����
       DAT_SK_ date;    --\ �� ����� ���� ��� ���
       nSK_    number;  --/ ����� ��� ����������� ��������
       nSK1_   number;  --| �����.����� �����.�����
       KV_KOM_ int;     -- ��� ��������
       DAT_SP_ date;    -- �� ����� ���� ��� ����
       nSP_    number;  -- ����� ��� ����������� ����
       SN8_NLS accounts.NLS%type; --\
       SD8_NLS accounts.NLS%type; --/ ����� ���������� ����
       MFOK_   varchar2(6); --\
       NLSK_   varchar2(15); --/ ���� �������
       nSSP_    number; --\ ����� ������������� ����
       nSSPN_   number; --\ ����� ������������ ���������
       nSSPK_   number; --\ �����  ������������ ��������
       KV_SN8   varchar2(3);
       Mess_    Varchar2(1024);
       ND_      cc_deal.ND%type; --\ �������� ��
       DATP_SS_   date;    --\ ���� ���������� ������� �� ���� ��
       DATP_SN_   date;    --\ ���� ���������� ������� �� ��������� ��

       SUM_SP number := 0;

       NextPayDate date;

   BEGIN
        begin
        --1. ���������� ���. ��������
           begin
              SELECT d.nd, a.KV
              INTO    ND_, KV_
              FROM cc_deal d, cc_add a
              WHERE d.ND   = a.ND   and d.sos>9 and d.sos<15
                and d.cc_id= CC_ID_ and d.SDATE = DAT1_ and d.vidd in (11,12,13);
              -- ������������, ����� ����������, ��� ������
           EXCEPTION
            WHEN TOO_MANY_ROWS THEN
                -- ����� ��������, �.�. ��������� ? �� ��������� � ���� ������ ���� ���� �� ����
                  raise_application_error(-20210,
                 '���. �1 �� � '||CC_ID_||' �� '||to_char(DAT1_,'dd/mm/yyyy')||' �� ���� � ��. ��������� � ������ ��������.',
                                        TRUE);
            WHEN NO_DATA_FOUND THEN
                 raise_application_error(-20210,
                 '���. �2 �� � '||CC_ID_||' �� '||to_char(DAT1_,'dd/mm/yyyy')||'�. �� �������� !',
                                        TRUE);
           end;
        end;

          begin
             --2. ���� ��������� �������� ��������� �� ���� ��� %
            begin
                  SELECT MIN (fdat)
                    INTO DATP_SS_
                    FROM cc_lim
                   WHERE nd = ND_ AND fdat > gl.bd AND sumg > 0
                GROUP BY nd;
             EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                    DATP_SS_:=gl.bd+1;
            end;

            begin
                  SELECT MIN (fdat)
                    INTO DATP_SN_
                    FROM cc_lim
                   WHERE nd = ND_ AND fdat > gl.bd AND sumo - sumg - nvl(sumk,0) > 0
                GROUP BY nd;
                 EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                         DATP_SN_:=gl.bd+1;
            end;


        begin
                select sum( a.ostc)
                into SUM_SP
                from accounts a, nd_acc na
                where a.acc = na.acc
                and na.nd = ND_
                and a.tip in ('SP ','SL ','SPN','SK9');

                exception
                when no_data_found then SUM_SP := 0;
                end;

                if nvl(SUM_SP,0) != 0
                then NextPayDate := gl.bd+1;
                else NextPayDate:=least(DATP_SS_,DATP_SN_);
                end if;

          end;

return NextPayDate;
END;
/
 show err;
 
PROMPT *** Create  grants  F_GET_DATE_CCK ***
grant EXECUTE                                                                on F_GET_DATE_CCK  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_date_cck.sql =========*** End
 PROMPT ===================================================================================== 
 