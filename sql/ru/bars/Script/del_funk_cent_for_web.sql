begin
-- Чистка центуровых функций из вебовского Арма
for c in (SELECT op.*
  FROM operapp op, operlist o
WHERE     o.codeoper = op.codeoper
       AND op.codeapp IN ('WCCK',
                          'UCCK',
                          'MSFZ',
                          'AUTU',
                          'AUTF')
       AND SUBSTR (o.funcname, 1, 10) <> '/barsroot/')
loop
         delete from operapp where codeapp = c.codeapp and codeoper = c.codeoper;
end loop;
end;
/

commit;