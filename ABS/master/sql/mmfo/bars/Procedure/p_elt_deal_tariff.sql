

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL_TARIFF.sql =========***
PROMPT ===================================================================================== 


create or replace procedure bars.p_elt_deal_tariff(
  p_otm      e_tar_nd.otm%type,
  p_nd       e_deal$base.nd%type,
  p_id       e_tarif.id%type,
  p_dat_beg  e_tar_nd.dat_beg%type,
  p_dat_end  e_tar_nd.dat_end%type,
  p_n_sumt   e_tar_nd.sumt%type,
  p_n_sumt1  e_tar_nd.sumt1%type,
  p_dat_lb   e_tar_nd.dat_lb%type,
  p_dat_le   e_tar_nd.dat_le%type
)
is
  l_cnt  int;
  l_otm  e_tar_nd.otm%type;
begin
  select count(*),min(otm) into l_cnt,l_otm from e_tar_nd where nd = p_nd and id = p_id;

  if l_cnt = 0 then
    insert into e_tar_nd (nd,     id,   otm,   dat_beg,   dat_end,         sumt,         sumt1,   dat_lb,   dat_le)
         values          (p_nd, p_id, p_otm, nvl(p_dat_beg,sysdate), p_dat_end, p_n_sumt*100, p_n_sumt1*100, p_dat_lb, p_dat_le);
  else
    update e_tar_nd
       set otm = p_otm,
           sumt = p_n_sumt*100,
           dat_end = case when p_otm = 0 and l_otm =1 then sysdate else p_dat_end end,
           sumt1 = p_n_sumt1*100,
           dat_beg = p_dat_beg,
           dat_lb = p_dat_lb,
           dat_le = p_dat_le
     where nd = p_nd and id = p_id;
  end if;

end;
/

PROMPT *** Create  grants  P_ELT_DEAL_TARIFF ***
grant EXECUTE                                                                on P_ELT_DEAL_TARIFF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL_TARIFF.sql =========***
PROMPT ===================================================================================== 
