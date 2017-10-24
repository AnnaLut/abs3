

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BUSS_MAKE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BUSS_MAKE ***

  CREATE OR REPLACE PROCEDURE BARS.BUSS_MAKE 
  (p_NI  in OUT int,
   p_RET    OUT int,
   p_err    OUT varchar2
  )
IS
  rnk_  number;
  our_  varchar2(12);
  uid_  number;
begin
  bars_audit.info('BUSS_MAKE: begin');
  p_NI  := 0;
  p_RET := 0;
  p_err := null;
  begin
    delete
    from   customerw
    where  tag in ('BUSSL','BUSSS');
  exception when others then
    p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
    bars_audit.error('BUSS_MAKE(-3): '||p_err);
    p_RET := -3;
    RETURN;
  end;
  uid_ := user_id;
  our_ := f_ourmfo_g;
  for k in (select EDRPOU,
                   MFO   ,
                   RNK   ,
                   BUSSLINE
            from   CUSTOMER_BUSS
            where  EDRPOU is not null or
                   (EDRPOU is null and MFO is not null and RNK is not null))
  loop
    if k.mfo=our_ then
      rnk_ := k.rnk;
    else -- работа по ОКПО
      begin
        select rnk
        into   rnk_
        from   customer
        where  okpo=k.EDRPOU    and
               date_off is null and
               rownum<2;
      exception when no_data_found then
        rnk_ := null;
      end;
    end if;
    if rnk_ is not null then
      begin
        update customerw
        set    value=k.BUSSLINE
        where  rnk=rnk_ and
               tag='BUSSL';
        if sql%rowcount=0 then
          begin
            insert
            into   customerw (rnk  ,
                              value,
                              tag  ,
                              isp)
                      values (rnk_      ,
                              k.BUSSLINE,
                              'BUSSL'   ,
                              uid_);
            p_NI := p_NI+1;
          exception when others then
            if sqlcode=-2291 then
              null;
            else
              p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
              bars_audit.error('BUSS_MAKE(-2): '||p_err);
              p_RET := -2;
              RETURN;
            end if;
          end;
        else
          p_NI := p_NI+1;
        end if;
      exception when others then
        p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
        bars_audit.error('BUSS_MAKE(-1): '||p_err);
        p_RET := -1;
        RETURN;
      end;
    end if;
  end loop;
  bars_audit.info('BUSS_MAKE: end');
  RETURN;
end buss_make;
/
show err;

PROMPT *** Create  grants  BUSS_MAKE ***
grant EXECUTE                                                                on BUSS_MAKE       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BUSS_MAKE       to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BUSS_MAKE.sql =========*** End ***
PROMPT ===================================================================================== 
