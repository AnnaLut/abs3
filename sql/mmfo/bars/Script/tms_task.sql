begin
update tms_task t set t.state_id=1 , t.task_statement='begin
p_interest_fine(p_type => 11,
                  p_date_to => gl.bD-1);
CDB_MEDIATOR.PAY_ACCRUED_INTEREST;                
end;' where t.task_code='61';
update tms_task t set t.state_id=1 , t.task_statement='begin
  cck.cc_asp(-1, 1);
BEGIN
  FOR o IN (SELECT *
              FROM oper
             WHERE EXISTS (SELECT 1 FROM ref_que WHERE ref_que.ref = oper.ref)
               AND oper.sos = 1)
  LOOP
    IF o.tt IN (''%%1'', ''ASG'', ''ASP'') THEN
    
      SAVEPOINT front_pay;
      --------------------
      BEGIN
        gl.pay(2, o.ref, gl.bdate);
        DELETE FROM ref_que WHERE REF = o.ref;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK TO front_pay;
      END;
    END IF;
  END LOOP;
END pay_fact_ob;
END;' where t.task_code='039';
commit;
insert into tms_task_exclusion
  (task_code, kf)
values
  ('60', '300465');
insert into tms_task_exclusion
  (task_code, kf)
values
  ('60', '324805');  
commit;
end;
/
begin
INSERT INTO meta_nsifunction
  (tabid
  ,funcid
  ,descr
  ,proc_name
  ,proc_par
  ,proc_exec
  ,qst
  ,msg
  ,form_name
  ,check_func
  ,web_form_name
  ,icon_id)
VALUES
  (get_tabid('V_CCK_RF')
  ,30
  ,'КП ФО: 0.Нарахування Пені'
  ,null
  ,null
  ,'ONCE'
  ,null
  ,null
  ,null
  ,null
  ,'sPar=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_fine(11,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]'
  ,null);
exception when  DUP_VAL_ON_INDEX then
  null;
end;
/
commit;