
create or replace function f_ost_compen (p_id  COMPEN_PORTFOLIO.id%type,
                                         p_dat date
                                         ) return number
as
l_datm   date; 
l_ost    number;
l_tran_mig number := 0;
l_tran     number := 0;
begin
 
   Begin 
       select datl, ost
         into l_datm, l_ost
         from BARS.COMPEN_PORTFOLIO
        where id = p_id;
     exception when no_data_found then 
           return 0;
    end;


   
      if  p_dat <  l_datm then
        select  sum(ao.sumop *  decode(ao.dk,0,-1,1))
          into l_tran_mig   
          from BARS.COMPEN_PORTFOLIO p 
          join  COMPEN_MOTIONS ao  on   AO.ID_COMPEN = p.id
          join  COMPEN_ASVOTYPO at on AT.TYPO = AO.TYPO
         where id = p_id
           and ao.dk in (0,1)
           and AO.DATP  > p_dat+0.999;
      End if;    
         


      select nvl(sum(amount * decode(case when t.type_id in (1,2,4) then 0 else 1 end,0,-1,1)),0)
        into l_tran   
        from BARS.COMPEN_PORTFOLIO p 
        join  compen_oper o  on   O.COMPEN_ID = p.id
        join  COMPEN_OPER_TYPES t on O.OPER_TYPE = T.TYPE_ID 
       where id = p_id
         and O.STATE = 20
         and t.type_id < 5
         and O.VISA_DATE  > p_dat+0.999;
    
    
    return l_ost - l_tran_mig - l_tran;
    
         
         
end; 
/

grant execute   on f_ost_compen to BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.COMPEN_PORTFOLIO TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.COMPEN_OPER TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.COMPEN_OPER_TYPES TO BARS_ACCESS_DEFROLE;          
GRANT SELECT ON BARS.COMPEN_MOTIONS TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.COMPEN_ASVOTYPO TO BARS_ACCESS_DEFROLE; 