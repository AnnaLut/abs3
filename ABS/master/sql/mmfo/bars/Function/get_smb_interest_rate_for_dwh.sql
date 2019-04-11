PROMPT ========================================================================================= 
PROMPT *** Run *** = Scripts /Sql/BARS/function/get_smb_interest_rate_for_dwh.sql =*** Run *** =
PROMPT =========================================================================================
 
create or replace function get_smb_interest_rate_for_dwh(
                               p_deposit_id   in number
                              ,p_date         in date) 
          return number 
    is
begin
    return smb_calculation_deposit.get_interest_rate(
                                                p_id   => p_deposit_id
                                               ,p_date => p_date);
end;
/
 
PROMPT *** Create  grants  GET_SMB_INTEREST_RATE_FOR_DWH ***

grant execute  on get_smb_interest_rate_for_dwh to bars_access_defrole;
grant execute  on get_smb_interest_rate_for_dwh to barsupl, upld;
 
PROMPT ========================================================================================= 
PROMPT *** End *** = Scripts /Sql/BARS/function/get_smb_interest_rate_for_dwh.sql =*** End *** =
PROMPT =========================================================================================
 