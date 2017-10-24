
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tickets_dpt.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TICKETS_DPT (ref_ oper.ref%type , PR_ VARCHAR2, NUM_ NUMBER DEFAULT NULL ) RETURN VARCHAR2
IS
STR_    VARCHAR2(250);
acc_    number;
accd    number;
acra_   number;
flag    number;  --Флаг(0- основной счет, 1- процентный)

BEGIN
  STR_:='__';
  flag:=0;
  --Определяем acc счет
    begin
     select a.acc
       into acc_
       from oper o ,accounts a
      where o.ref=ref_
        and a.nls =o.nlsa
        and a.kv=o.kv;
     EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
    end;

  --Определяем счет основной или процентный.
    begin
      select unique(i.acra), 0
        into acra_, flag
        from int_accn i
       where i.acc = acc_;
       EXCEPTION WHEN NO_DATA_FOUND THEN flag:=1;
    end;

   if flag=0
      then
        begin
          if PR_ ='UVIDD'
           then
             begin
               select substr(nvl(max(v.type_name),'"Пенсійний Ощадного банку"'),1,50)
                 into STR_
                 from dpt_deposit d , dpt_vidd v
                where d.acc=acc_ and v.vidd=d.vidd;
                EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
             end;

          elsif PR_ ='UOSTB'
           then
             begin
                select substr(to_char(a.OSTB/100,'9999999990D99'),1,20)
                  into STR_
                  from accounts a
                 where a.acc =acc_;
              end;
          elsif PR_ ='UOSTP'
           then
             begin
                select substr(to_char(a.OSTC/100,'9999999990D99'),1,20)
                  into STR_
                  from accounts a
                 where a.acc =acra_;
              end;
          end if;
         end;

   elsif flag=1
     then
       begin
         begin
           select i.acc
             into accd
             from int_accn i
            where i.acra = acc_;
           EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
         end;

         if PR_ ='UVIDD'
          then
            begin
              select substr(nvl(max(v.type_name),'"Пенсійний Ощадного банку"'),1,50)
                into STR_
                from dpt_deposit d , dpt_vidd v
               where d.acc=accd and v.vidd=d.vidd;
               EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
            end;
         elsif PR_ ='UOSTB'
          then
            begin
               select substr(to_char(a.OSTC/100,'9999999990D99'),1,20)
                 into STR_
                 from accounts a
                where a.acc =accd;
             end;
         elsif PR_ ='UOSTP'
          then
            begin
               select substr(to_char(a.OSTB/100,'9999999990D99'),1,20)
                 into STR_
                 from accounts a
                where a.acc =acc_;
             end;

         end if;
       end;
    else STR_:='__';
   end if;



  RETURN  STR_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_TICKETS_DPT ***
grant EXECUTE                                                                on F_TICKETS_DPT   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tickets_dpt.sql =========*** End 
 PROMPT ===================================================================================== 
 