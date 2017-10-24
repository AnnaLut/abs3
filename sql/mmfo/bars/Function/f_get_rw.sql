
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_rw.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_RW (S1 varchar2)
RETURN VARCHAR2 IS
  fio_s VARCHAR2(250);
--
--
--
--
BEGIN
  select
    case when
    f_getNameInGenitiveCase (substr(S1, instr(S1,' ',instr(S1,' ')+2)),3,0)=trim(f_getNameInGenitiveCase (substr(S1, instr(S1,' ',instr(S1,' ')+2)),3,0)) then
    f_getNameInGenitiveCase (substr(S1,1,instr(S1,' ')-1),1,0)||' '||f_getNameInGenitiveCase (substr(S1,instr(S1,' '),instr(S1,' ',instr(S1,' ')+1)-instr(S1,' ')+1),2,0) ||' '||
    f_getNameInGenitiveCase (substr(S1, instr(S1,' ',instr(S1,' ')+2)),3,0)
    else
    f_getNameInGenitiveCase (substr(S1,1,instr(S1,' ')-1),1,1)||' '||f_getNameInGenitiveCase (substr(S1,instr(S1,' '),instr(S1,' ',instr(S1,' ')+1)-instr(S1,' ')+1),2,1) ||' '||
    f_getNameInGenitiveCase (substr(S1, instr(S1,' ',instr(S1,' ')+2)),3,1)
    end fio_s_ into fio_s

    from dual;

  RETURN fio_s;

END f_get_rw;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_rw.sql =========*** End *** =
 PROMPT ===================================================================================== 
 