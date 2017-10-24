

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/W4_FORMFILE_IIC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure W4_FORMFILE_IIC ***

  CREATE OR REPLACE PROCEDURE BARS.W4_FORMFILE_IIC (p_mode IN INT)
IS
   title    CONSTANT VARCHAR2 (100) := 'W4_FORMFILE_IIC:';
   p_filename        VARCHAR2 (50);
   p_impfileid       NUMBER;
   l_mode            int;
   l_iicnum          int;
   l_count           int := 0;
BEGIN
   bc.go (getglobaloption('MFO'));
   begin
    select to_number(nvl(val,'1000')) into l_iicnum from ow_params where par = 'IICNUM';
   exception when others then
    l_iicnum := 1000;
   end;
   l_mode := p_mode;
   if l_mode = 0
   then select count(*) into l_count from v_ow_iicfiles_form;
   elsif l_mode = 1
   then select count(*) into l_count from v_ow_iicfiles_form_kd;
   elsif l_mode = 2
   then select count(*) into l_count from v_ow_iicfiles_form_sto;
   elsif l_mode = 3
   then select count(*) into l_count from V_OW_OICREVFILES_FORM;
   else l_count :=0;
   end if;

   while l_count > 0
   loop
       bars_ow.form_iic_file (l_mode, p_filename, p_impfileid);
       bars_audit.info('p_filename = '|| p_filename ||', p_impfileid ='||p_impfileid);

        begin
          for rec in (select p_filename title, file_data from ow_impfile where id = p_impfileid)
          loop DBMS_XSLPROCESSOR.clob2file(rec.file_data, 'IIC_DOCUMENTS', rec.title); end loop;
          delete ow_impfile where id = p_impfileid;
        end;
        l_count := l_count - l_iicnum;
   end loop;
END;
/
show err;

PROMPT *** Create  grants  W4_FORMFILE_IIC ***
grant EXECUTE                                                                on W4_FORMFILE_IIC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/W4_FORMFILE_IIC.sql =========*** E
PROMPT ===================================================================================== 
