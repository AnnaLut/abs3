create or replace type t_core_company_group_member force as object
(
       whois            number(1),                      -- ������ ����� �������� ����� � ���� (0 � �������, 1 � ����������� �������/���������, 2 - ������� �����, ����� ������ �������)
       isrezgr          varchar2(5 char),               -- true � ���� ����� � ����������; false � ���� ����� �� � ����������
       codedrpougr      varchar2(20 char),              -- ��� ������
       nameurgr         varchar2(254 char),             -- ������������ �����
       countrycodgr     varchar2(3 char),               -- ��� ����� ���� ���������

       member function get_json
       return varchar2
);
/

create or replace type body t_core_company_group_member is

    member function get_json
    return varchar2
    is
        l_attributes bars.string_list := bars.string_list();
        l integer;
    begin
        l_attributes.extend(5);
        l_attributes(1) := json_utl.make_json_value('whois', nvl(whois, 0), p_mandatory => true);
        l_attributes(2) := json_utl.make_json_value('isrezgr', nvl(isrezgr, 'true'), p_mandatory => true);
        l_attributes(3) := json_utl.make_json_string('codedrpougr', codedrpougr, p_mandatory => true);
        l_attributes(4) := json_utl.make_json_string('nameurgr', nameurgr, p_mandatory => true);
        l_attributes(5) := json_utl.make_json_string('countrycodgr', countrycodgr, p_mandatory => true);

        return '{' || bars.tools.words_to_string(l_attributes, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || '}';
    end;
end;
/

create or replace type t_core_company_group force as table of t_core_company_group_member;
/
