-- параметр контрагента код розміру суб'єкта господарювання (параметр K140)
-- 16/06/2017 

begin
  bpa.alter_policy_info('KL_K140', 'FILIAL',  null, null, null, null);
  bpa.alter_policy_info('KL_K140', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/


begin
    execute immediate 'DROP TABLE BARS.KL_K140 CASCADE CONSTRAINTS';
exception
    when others then null;
end;
/    


Prompt Table KL_K140;
begin
  execute immediate 
    'create table BARS.KL_K140
(
  K140     VARCHAR2(1 BYTE),
  TXT      VARCHAR2(165 BYTE),
  D_OPEN   DATE,
  D_CLOSE  DATE,
  D_MODE   DATE,
  K140SR   VARCHAR2(2 BYTE)
)';
exception 
  when others then
    if (sqlcode = -955) then null;
    else raise;
    end if;
end;
/


COMMENT ON TABLE BARS.KL_K140 IS 'Довiдник кодів розміру суб''єктів господарювання';

COMMENT ON COLUMN BARS.KL_K140.K140 IS 'Код розміру суб''єкта господарювання';

COMMENT ON COLUMN BARS.KL_K140.TXT IS 'Назва коду';

COMMENT ON COLUMN BARS.KL_K140.D_OPEN IS 'Дата відкриття';

COMMENT ON COLUMN BARS.KL_K140.D_CLOSE IS 'Дата закриття';

COMMENT ON COLUMN BARS.KL_K140.D_MODE IS 'Дата модифікації';

COMMENT ON COLUMN BARS.KL_K140.K140SR IS 'Код K140SR';

begin
    execute immediate 'DROP PUBLIC SYNONYM KL_K140';
exception
    when others then null;
end;
/    

create public synonym KL_K140 for bars.KL_K140;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.KL_K140 TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.KL_K140 TO RPBN002;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.KL_K140 TO WR_ALL_RIGHTS;

GRANT SELECT, FLASHBACK ON BARS.KL_K140 TO WR_REFREAD;

BEGIN
   bpa.alter_policies('KL_K140');
END;
/
