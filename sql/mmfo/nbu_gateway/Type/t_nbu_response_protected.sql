create or replace type t_nbu_response_protected force as object
(
       alg      varchar2(32767 byte), -- ��������������� �������� ���� ���� ����������� ��� �������� JWS ��'����
       typ      varchar2(32767 byte), -- ��� ���������� JWS
       cty      varchar2(32767 byte), -- ��� �������� JWS ��'����
       kid      varchar2(32767 byte), -- ��������� ������������� ����� ������� ������� ���, ���� ���� �������� ���
       dateOper varchar2(32767 byte), -- ���� ��������� �����������
       appId    varchar2(32767 byte), -- ��������� ��� ������

       constructor function t_nbu_response_protected(
           p_protected in varchar2)
       return self as result
);
/
create or replace type body t_nbu_response_protected is

    constructor function t_nbu_response_protected(
        p_protected in varchar2)
    return self as result
    is
    begin
        return;
    end;
end;
/
