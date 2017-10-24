
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_blk_val_corp.sql =========*** Run
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE function BARS.f_blk_val_corp(
    p_nlsa   in varchar2,
    p_nlsb   in varchar2,
    p_kv     in integer,
    p_okpo_a in varchar2,
    p_okpo_b in varchar2)
return integer
is
    l_block_flag integer := 0;
begin
    if (p_kv = 980) then
        return 0;
    elsif (p_okpo_a = p_okpo_b) then
        return 0;
    elsif ((p_nlsa like '2600%' or p_nlsa like '2650%' or p_nlsa like '25%') and
           (p_nlsb like '2600%' or p_nlsb like '2650%' or p_nlsb like '25%')) then

        if (p_okpo_a in ('40075815', '21560045')) then
            select nvl(min(0), 1)
              into l_block_flag
              from rnkp_kod t
             where t.rnk in (select c.rnk
                               from customer c
                              where c.okpo = p_okpo_b);

            return l_block_flag;
        elsif (p_okpo_b in ('40075815', '21560045')) then
            select nvl(min(1), 0)
              into l_block_flag
              from rnkp_kod t
             where t.rnk in (select c.rnk
                               from customer c
                              where c.okpo = p_okpo_a);

            return l_block_flag;
        else
            return 1;
        end if;
    end if;

    return l_block_flag;
end;
/ 

PROMPT *** Create  grants  F_BLK_VAL_CORP ***
grant EXECUTE                                                                on F_BLK_VAL_CORP  to BARS014;
grant EXECUTE                                                                on F_BLK_VAL_CORP  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BLK_VAL_CORP  to TOSS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_blk_val_corp.sql =========*** End
 PROMPT ===================================================================================== 
 