

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BANK_EMPLOYEE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BANK_EMPLOYEE ***

  CREATE OR REPLACE PROCEDURE BARS.BANK_EMPLOYEE (p_n out int)
IS
  type         cur is ref cursor;
  cur_         cur;
  sql_         varchar2(960);
  rnk_         customer.rnk%type;
  date_off_    customer.date_off%type;
  pl_          varchar2(64);
  nmk_         varchar2(70);
  okpo_        varchar2(14);
  ser_         varchar2(10);
  numdoc_      varchar2(10);
  pensioner_   int;
  text_        varchar2(96);
  description_ varchar2(250);
BEGIN
  p_n := 0;
  delete
  from   tmp_bank_employee_prot;
  sql_:='SELECT nmk   ,
                okpo  ,
                ser   ,
                numdoc,
                pensioner
         FROM   tmp_bank_employee';
  open cur_ for sql_;
  loop
    begin
      fetch cur_ into nmk_   ,
                      okpo_  ,
                      ser_   ,
                      numdoc_,
                      pensioner_;
      exit when cur_%notfound;
    exception when OTHERS then
      text_  := 'Ошибка чтения исходных данных (возможно неверна структура DBF-файла)';
      bars_audit.error('WORKB: '||text_);
      p_n := -1;
    end;
--  проверка допустимости значения pensioner
    begin
      select description
      into   description_
      from   CCK_WORKER_BANK
      where  code=pensioner_;
    exception when no_data_found then
      insert
      into   tmp_bank_employee_prot (pl,nmk,okpo,ser,numdoc)
                             values ('недопустимый параметр WORKB'||to_char(pensioner_),nmk_,okpo_,ser_,numdoc_);
      goto dalee;
    end;
    if p_n>=0 then
      rnk_ := null;
      BEGIN
        select rnk
        into   rnk_
        from   customer
        where  okpo=okpo_         and
               okpo<>'9999999999' and
               date_off is null   and
               rownum<2;
      exception when no_data_found then
        begin
          select rnk
          into   rnk_
          from   person
          where  ser=ser_       and
                 numdoc=numdoc_ and
                 rownum<2;
          begin
            select date_off
            into   date_off_
            from   customer
            where  rnk=rnk_;
            if date_off_ is not null then
              rnk_ := null;
            end if;
          end;
        exception when no_data_found then
          pl_ := 'працівник не знайдений';
          null;
        end;
      end;
      if rnk_ is not null then
        pl_ := 'змінений параметр WORKB = '||to_char(pensioner_);
        update customerw
        set    value=to_char(pensioner_)
        where  rnk=rnk_ and
               tag='WORKB';
        if sql%rowcount=0 then
          pl_ := 'внесений параметр WORKB = '||to_char(pensioner_);
          insert
          into   customerw (rnk,tag,value,isp)
                    values (rnk_,'WORKB',to_char(pensioner_),0);
        end if;
        p_n := p_n+1;
      end if;
      insert
      into   tmp_bank_employee_prot (pl,nmk,okpo,ser,numdoc)
                             values (pl_,nmk_,okpo_,ser_,numdoc_);
    else
      goto endw;
    end if;
<<dalee>>
    null;
  END LOOP;
<<endw>>
  null;
END bank_employee;
/
show err;

PROMPT *** Create  grants  BANK_EMPLOYEE ***
grant EXECUTE                                                                on BANK_EMPLOYEE   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BANK_EMPLOYEE.sql =========*** End
PROMPT ===================================================================================== 
