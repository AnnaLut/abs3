begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('100', 'Гарантований державою борг', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/


begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('211', 'Короткостроковi кредити, отриманi банком вiд материнського банку', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/


begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('212', 'Короткостроковi кредити, отриманi банком вiд iнших банкiв або фiнансових установ', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/


begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('220', 'Iншi короткостроковi кредити, отриманi банком', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/


begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('230', 'Банкiвський сектор - розмiщенi короткостроковi борговi цiннi папери', to_date('01-06-2009', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('241', 'Довгостроковi кредити, отриманi банком вiд материнського банку', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('242', 'Довгостроковi кредити, отриманi банком вiд iнших банкiв або фiнансових установ', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('250', 'Iншi довгостроковi кредити, отриманi банком', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('261', 'Банкiвський сектор - довгостроковi борговi цiннi папери - єврооблiгацiї', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('262', 'Банкiвський сектор - довгостроковi борговi цiннi папери - крiм єврооблiгацiй', to_date('01-06-2009', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('270', 'Банкiвський сектор - залученi депозити (мiжбанкiвськi, вiд юридичних та фiзичних осiб, коротко  та довгострковi)', to_date('01-06-2009', 'dd-mm-yyyy'), to_date('01-01-2010', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('279', 'Субординований борг у формi депозиту', to_date('01-02-2011', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('271', 'Банкiвський сектор - залученi мiжбанкiвськi депозити, включаючи субординований борг у формi депозиту', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('272', 'Банкiвський сектор - залученi депозити вiд юридичних осiб, включаючи субординований борг у формi депозиту', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('273', 'Банкiвський сектор - залученi депозити вiд фiзичних осiб, включаючи субординований борг у формi депозиту', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('311', 'Короткостроковi кредити, отриманi клiєнтом вiд прямих iнвесторiв-материнських компанiй', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('312', 'Короткостроковi кредити, отриманi клiєнтом вiд iнших прямих iнвесторiв', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('320', 'Iншi короткостроковi кредити, отриманi клiєнтом', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('330', 'Iншi позичальники - розмiщенi короткостроковi борговi цiннi папери', to_date('01-06-2009', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('341', 'Довгостроковi кредити, отриманi клiєнтом вiд прямих iнвесторiв-материнських компанiй', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('342', 'Довгостроковi кредити, отриманi клiєнтом вiд iнших прямих iнвесторiв', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('350', 'Iншi довгостроковi кредити, отриманi клiєнтом', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('361', 'Iншi позичальники - розмiщенi довгостроковi борговi цiннi папери - єврооблiгації', to_date('01-02-2010', 'dd-mm-yyyy'), null, null, '34,35,6A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('362', 'Iншi позичальники - розмiщенi довгостроковi борговi цiннi папери - крiм єврооблiгацiй', to_date('01-06-2009', 'dd-mm-yyyy'), null, null, '1A');
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('410', 'Iншi операцiї - зобов''язання за банкiвськими гарантiями', to_date('01-06-2009', 'dd-mm-yyyy'), to_date('31-07-2012', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('421', 'Iншi операцiї - зобов''язання за операцiями з використанням акредитивної форми розрахункiв за зовнiшньоекономічних оперцій', to_date('01-06-2009', 'dd-mm-yyyy'), to_date('31-07-2012', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('422', 'Iншi операцiї - зобов''язання за операцiями з використанням акредитивної форми розрахункiв за iншими операцiями', to_date('01-06-2009', 'dd-mm-yyyy'), to_date('31-07-2012', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('430', 'Iншi операцiї - акцiї та iншi цiннi папери з нефiксованим прибутком', to_date('01-06-2009', 'dd-mm-yyyy'), to_date('31-07-2012', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('440', 'Iншi операцiї - зобов''язання за деривативами (форварди, ф''ючерси, опцiони, свопи)', to_date('01-06-2009', 'dd-mm-yyyy'), to_date('31-07-2012', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f057 (F057, TXT, D_OPEN, D_CLOSE, D_MODE, A010)
values ('450', 'Iншi операцiї - зобов''язання за iншими фiнансовими iнструментами', to_date('01-06-2009', 'dd-mm-yyyy'), to_date('31-07-2012', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;