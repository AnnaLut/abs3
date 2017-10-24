

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TDDL_CRTAB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TDDL_CRTAB ***

  CREATE OR REPLACE TRIGGER BARS.TDDL_CRTAB 
before create on database
declare

l_dummy   number;

begin
    --
    -- ������� ��������� ��������� �������, �������
    -- �� ������� � ������� POLICY_TABLE
    --
    -- !!!! ������� �� ��������� !!!!
    --
    --
   if (ora_sysevent = 'CREATE'
       and ora_dict_obj_type = 'TABLE'
       and ora_dict_obj_owner in ('BARS','HIST')
       and ora_dict_obj_name not like 'AQ$\_%'     escape '\'
       and ora_dict_obj_name not like 'SYS\_%'     escape '\'
       and ora_dict_obj_name not like 'TEST%'
       and ora_dict_obj_name not like 'TMP\_%'     escape '\'
       and ora_dict_obj_name not like 'MV\_%'      escape '\'
       and ora_dict_obj_name not like 'S6\_%'      escape '\'
       and ora_dict_obj_name not like 'ASVO\_%'    escape '\'
       and ora_dict_obj_name not like 'REFSYNC\_%' escape '\' -- ������������� ������������
       and ora_dict_obj_name not like '%\_BAK'     escape '\' -- ��� ������� � ��������� _BAK
       and ora_dict_obj_name not like 'EXT\_%'     escape '\' -- external tables
       and ora_dict_obj_name not like 'MLOG$\_%'   escape '\' -- materialized log for MV
       and ora_dict_obj_name not like '%\_QT'      escape '\' -- queue table
       and ora_dict_obj_name not like 'ERR$\_%'    escape '\' -- error logging tables
       and ora_dict_obj_name not like 'DIFF\_%'    escape '\' -- difference tables
      ) then

       begin
       	  select 1 into l_dummy from policy_table
          where owner = ora_dict_obj_owner and table_name = ora_dict_obj_name and rownum=1;
       exception when no_data_found then
          raise_application_error(-20999, '�� �������� ������� �� ���������� ������� � ������� POLICY_TABLE');
       end;

   end if;

end;
/
ALTER TRIGGER BARS.TDDL_CRTAB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TDDL_CRTAB.sql =========*** End *** 
PROMPT ===================================================================================== 
