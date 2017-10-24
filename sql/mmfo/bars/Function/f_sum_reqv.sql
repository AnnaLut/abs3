
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_sum_reqv.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SUM_REQV 
                              (reqv1 op_field.tag%type default null,
                               reqv2 op_field.tag%type default null,
                               reqv3 op_field.tag%type default null,
                               reqv4 op_field.tag%type default null,
                               reqv5 op_field.tag%type default null,
                               reqv6 op_field.tag%type default null,
                               reqv7 op_field.tag%type default null,
                               reqv8 op_field.tag%type default null,
                               reqv9 op_field.tag%type default null,
                               reqv10 op_field.tag%type default null,
                               reqv11 op_field.tag%type default null,
                               reqv12 op_field.tag%type default null,
                               reqv13 op_field.tag%type default null,
                               reqv14 op_field.tag%type default null,
                               reqv15 op_field.tag%type default null)

RETURN number
 is
   l_sum oper.s%type;
begin
 begin
   select
           nvl(replace(replace(case when instr(replace(reqv1,'.',','),',')=0 then reqv1||',00' else reqv1 end,'.', null),',',null),0)+
          nvl(replace(replace(case when instr(replace(reqv2,'.',','),',')=0 then reqv2||',00' else reqv2 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv3,'.',','),',')=0 then reqv3||',00' else reqv3 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv4,'.',','),',')=0 then reqv4||',00' else reqv4 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv5,'.',','),',')=0 then reqv5||',00' else reqv5 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv6,'.',','),',')=0 then reqv6||',00' else reqv6 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv7,'.',','),',')=0 then reqv7||',00' else reqv7 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv8,'.',','),',')=0 then reqv8||',00' else reqv8 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv9,'.',','),',')=0 then reqv9||',00' else reqv9 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv10,'.',','),',')=0 then reqv10||',00' else reqv10 end,'.', null),',',null),0)+
          nvl(replace(replace(case when instr(replace(reqv11,'.',','),',')=0 then reqv11||',00' else reqv11 end,'.', null),',',null),0)+
          nvl(replace(replace(case when instr(replace(reqv12,'.',','),',')=0 then reqv12||',00' else reqv12 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv13,'.',','),',')=0 then reqv13||',00' else reqv13 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv14,'.',','),',')=0 then reqv14||',00' else reqv14 end,'.', null),',',null),0)+
           nvl(replace(replace(case when instr(replace(reqv15,'.',','),',')=0 then reqv15||',00' else reqv15 end,'.', null),',',null),0)
   into l_sum
      from dual;
 end;
RETURN l_sum;
end;
/
 show err;
 
PROMPT *** Create  grants  F_SUM_REQV ***
grant EXECUTE                                                                on F_SUM_REQV      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SUM_REQV      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_sum_reqv.sql =========*** End ***
 PROMPT ===================================================================================== 
 