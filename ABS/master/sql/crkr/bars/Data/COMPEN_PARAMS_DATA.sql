prompt Loading COMPEN_PARAMS_DATA...
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (1, ''COMPEN_LIMIT'', ''3000'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 

prompt ... 


begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (2, ''COMPEN_BURIAL'', ''1000'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''09-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''20-09-2016 16:56:11'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_PARAMS_DATA T (ID, PAR, VAL, KF, BRANCH, DATE_FROM, DATE_TO, IS_ENABLE, USERID, UPD_DATE)
  VALUES (3, ''COMPEN_OFFSET_DAYS'', ''25'', NULL, NULL, TO_DATE(''2016/04/07'', ''YYYY/MM/DD HH24:MI:SS''), TO_DATE(''2017/04/07'', ''YYYY/MM/DD HH24:MI:SS''), 1, 999, TO_DATE(''2016/10/27 17:36:41'', ''YYYY/MM/DD HH24:MI:SS''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_02'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_03'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_04'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_05'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_06'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_07'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_08'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_09'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_10'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_11'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_12'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_13'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_14'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_15'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_16'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_17'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_18'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_19'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_20'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'insert into COMPEN_PARAMS_DATA (id, par, val, kf, branch, date_from, date_to, is_enable, userid, upd_date)
values (s_compen_params_data_id.nextval, ''COMPEN_LIMIT_21'', ''1500'', null, null, to_date(''07-04-2016'', ''dd-mm-yyyy''), to_date(''07-04-2017'', ''dd-mm-yyyy''), 1, 20094, to_date(''23-09-2016 11:21:37'', ''dd-mm-yyyy hh24:mi:ss''))';
 exception when others then 
    if (sqlcode = -1 or sqlcode = -20123) then null; else raise; 
    end if; 
end;
/ 


commit;