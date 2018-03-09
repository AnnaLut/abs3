-- исключение (удаление) из списка

--SWIFT. Оплата ностро документів	                                 begin BARS_SWIFT.PUT_NOS_VISA; end;
--Нарахування відсотків по вкладам	                                 begin dpt_execute_job('JOB_INTX', null); end;
--#5) КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО	         begin bars.p_interest_cck(NULL,7, gl.bd); end;
--КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ЮО	     begin cck_sber('2', '5', null); end;
--КП S42: Нарахування %% по поточних платіж. датах у КП ЮЛ	         begin bars.p_interest_cck(NULL,6, gl.bd); end;
--Погашення заборг.за РО: Дт 2600 - Кт 3570,3579	                 begin rko_finis(gl.bd); end;
--Перенакоплення ЩОДЕННИХ SNAP на дату	                             begin draps(gl.bd); end;
--#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО	 begin cck_sber('3', '4', null); end;
--Start/ Авто-просрочка рахунків боргу SS - ФО	                     begin cck.cc_asp(-11, 1); end;


delete from tms_task_run where task_id in (202,124,161,265,165,110,138,130,89);
delete from tms_task where id in (202,124,161,265,165,110,138,130,89);
commit;


-- включнеие  - Автопроплата проведень ASG
update tms_task set state_id = 1 where id = 371;
commit;
