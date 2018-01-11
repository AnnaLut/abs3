
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_concatstr.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_CONCATSTR as object
(
  str varchar2(4000), -- ?????????
  static FUNCTION ODCIAggregateInitialize(sctx IN OUT T_ConcatStr) RETURN NUMBER,
  MEMBER FUNCTION ODCIAggregateIterate(self IN OUT T_ConcatStr, value IN VARCHAR2) RETURN NUMBER,
  MEMBER FUNCTION ODCIAggregateTerminate(self IN T_ConcatStr, returnValue OUT VARCHAR2, flags IN NUMBER) RETURN NUMBER,
  MEMBER FUNCTION ODCIAggregateMerge(self IN OUT T_ConcatStr, ctx2 IN T_ConcatStr) RETURN NUMBER
);
/
CREATE OR REPLACE TYPE BODY BARS.T_CONCATSTR is
   -- Функция, выполняющая инициализацию объекта
   static function ODCIAggregateInitialize(sctx IN OUT t_ConcatStr)
   return number is
   begin
   sctx := t_ConcatStr(null);
   return ODCIConst.Success;
   end;

   -- Функция, выполняющая расчет
   member function ODCIAggregateIterate(self IN OUT t_ConcatStr, value IN VARCHAR2)
   return number is
   begin
     --dbms_output.put_line(self.str);

     if nvl(instr (trim(self.str), TO_CHAR(value)),0) = 0 then
        self.str := substr(self.str|| TO_CHAR(value) || ', ' ,1,1500);
     end if;
     return ODCIConst.Success;
   end;

   -- Функция, заканчивающая расчет
   member function ODCIAggregateTerminate(self IN t_ConcatStr, returnValue OUT VARCHAR2, flags IN number) return number is
   begin
     returnValue := rtrim(self.str,', '); -- Передаем результат в выходной параметр
     return ODCIConst.Success;
   end;

   -- На случай распараллеливания
   member function ODCIAggregateMerge(self IN OUT t_ConcatStr, ctx2 IN t_ConcatStr) return number IS
   begin
     self.str := self.str || ', ' || ctx2.str;
     return ODCIConst.Success;
   end;
end;
/
 show err;
 
PROMPT *** Create  grants  T_CONCATSTR ***
grant EXECUTE                                                                on T_CONCATSTR     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_concatstr.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 