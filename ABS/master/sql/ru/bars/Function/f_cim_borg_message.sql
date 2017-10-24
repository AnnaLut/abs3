
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cim_borg_message.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CIM_BORG_MESSAGE (p_file_name out varchar2 --Назва файла
                                             ) return clob
is
   cursor c is select * from v_cim_borg_message
     where delete_date is null and file_name is null and branch=sys_context('bars_context', 'user_branch');
   l_txt clob; -- Текст повідомлення
   l_n number;
begin
  select count(*) into l_n from cim_borg_message
    where delete_date is null and file_name is null and branch=sys_context('bars_context', 'user_branch') and nvl(approve,0) != 1;
  if l_n>0 then bars_error.raise_error('CIM', 5); end if;
  select count(*) into l_n from cim_borg_message
    where delete_date is null and file_name is null and branch=sys_context('bars_context', 'user_branch');
  if l_n<1 then bars_error.raise_error('CIM', 4); end if;
  p_file_name:='BORG_'||to_char(sysdate,'YYYYMMDDHHMMSS')||sys_guid();
  for pc in c loop
    select l_txt||XmlConcat(XmlElement("Name_bank", pc.name_bank),
                     XmlElement("Adr_bank", pc.adr_bank),
                     XmlElement("Tin", pc.okpo),
                     XmlElement("Name", pc.name_kl ),
                     XmlElement("Adr_kl", pc.adr_kl),
                     XmlElement("Nom_dog", pc.nom_dog),
                     XmlElement("Date_dog", pc.date_dog),
                     XmlElement("Date_plat", pc.date_plat)) into l_txt from dual;
    update cim_borg_message set file_name=p_file_name where id=pc.id;
  end loop;
  l_txt:='<?xml version="1.0" encoding="windows-1251"?><DATA FORMAT_VERSION="1.0">'||l_txt||'</DATA>';
  return l_txt;
end f_cim_borg_message;
/
 show err;
 
PROMPT *** Create  grants  F_CIM_BORG_MESSAGE ***
grant EXECUTE                                                                on F_CIM_BORG_MESSAGE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cim_borg_message.sql =========***
 PROMPT ===================================================================================== 
 