
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Function/F_NBUR_GET_F090.sql ======= *** Run **
PROMPT ===================================================================================== 

CREATE OR REPLACE function BARS.F_NBUR_GET_F090
                  ( p_kodf   varchar2,
                    p_ref    number,
                    p_p40    varchar2  default null )
      return varchar2
is
  l_f090        varchar2(3);

  l_rezult      varchar2(3);
begin

    begin
          select trim(value)   into l_f090
            from operw
           where ref = p_ref and tag = 'D1#3M';

    exception
        when no_data_found
           then
             begin
                 select f090    into l_f090
                   from f090
                  where (  instr(f552, p_p40)>0 and p_kodf ='C9'
                        or instr(f555, p_p40)>0 and p_kodf ='E2' )
                    and rownum =1;
             exception
                 when no_data_found
                   then  l_f090 :='#';
             end;
    end;
    l_rezult := l_f090;

    return l_rezult;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Function/F_NBUR_GET_F090.sql ======= *** End **
PROMPT ===================================================================================== 

