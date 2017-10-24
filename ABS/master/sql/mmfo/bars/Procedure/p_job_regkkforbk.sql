

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_REGKKFORBK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_REGKKFORBK ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_REGKKFORBK is
  type t_kkforbk_data is table of kkforbk_data%rowtype;
  l_kkforbk_data t_kkforbk_data;
begin
  select * bulk collect
    into l_kkforbk_data
    from kkforbk_data t
   where t.errcode is null;
  if l_kkforbk_data.count > 0 then
    for i in l_kkforbk_data.first .. l_kkforbk_data.last
    loop

      regkkforbk(p_surname   => l_kkforbk_data(i).surname,
                 p_name      => l_kkforbk_data(i).name,
                 p_fname     => l_kkforbk_data(i).fname,
                 p_latname   => l_kkforbk_data(i).latname,
                 p_password  => l_kkforbk_data(i).password,
                 p_sex       => l_kkforbk_data(i).sex,
                 p_birthdate => l_kkforbk_data(i).birthdate,
                 p_series    => l_kkforbk_data(i).series,
                 p_num       => l_kkforbk_data(i).num,
                 p_issdate   => l_kkforbk_data(i).issdate,
                 p_issuer    => l_kkforbk_data(i).issuer,
                 p_identcode => l_kkforbk_data(i).identcode,
                 p_region    => l_kkforbk_data(i).region,
                 p_area      => l_kkforbk_data(i).area,
                 p_city      => l_kkforbk_data(i).city,
                 p_address   => l_kkforbk_data(i).address,
                 p_house     => l_kkforbk_data(i).house,
                 p_zipcode   => l_kkforbk_data(i).zipcode,
                 p_phone     => l_kkforbk_data(i).phone,
                 p_mphone    => l_kkforbk_data(i).mphone,
                 p_email     => l_kkforbk_data(i).email,
                 p_typedoc   => l_kkforbk_data(i).typedoc,
                 p_photodata => l_kkforbk_data(i).photodata,
                 p_branch    => l_kkforbk_data(i).branch,
                 p_card_code => l_kkforbk_data(i).card_code,
                 p_is_social => l_kkforbk_data(i).is_social,
                 p_errcode   => l_kkforbk_data(i).errcode,
                 p_errmsg    => l_kkforbk_data(i).errmsg,
                 p_rnk       => l_kkforbk_data(i).rnk,
                 p_nls       => l_kkforbk_data(i).nls);

      update kkforbk_data k
         set k.errcode  = l_kkforbk_data(i).errcode,
             k.errmsg   = l_kkforbk_data(i).errmsg,
             k.rnk      = l_kkforbk_data(i).rnk,
             k.nls      = l_kkforbk_data(i).nls,
             k.procdate = sysdate
       where k.id = l_kkforbk_data(i).id;

    end loop;
  end if;
end p_job_regkkforbk;
/
show err;

PROMPT *** Create  grants  P_JOB_REGKKFORBK ***
grant EXECUTE                                                                on P_JOB_REGKKFORBK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_REGKKFORBK.sql =========*** 
PROMPT ===================================================================================== 
