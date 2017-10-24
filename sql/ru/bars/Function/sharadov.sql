
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sharadov.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SHARADOV ( KV_ int, NLS_ varchar2  ) return varchar2 
is
nms_ varchar2(50);
begin
 begin
   select nms into nms_ from accounts where kv=kv_ and nls=nls_;
  end;
 return nms_;
end SHARADOV; 
/
 show err;
 
PROMPT *** Create  grants  SHARADOV ***
grant EXECUTE                                                                on SHARADOV        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SHARADOV        to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sharadov.sql =========*** End *** =
 PROMPT ===================================================================================== 
 