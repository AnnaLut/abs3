
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_DICT_DMSU_DEPTS.sql ========
PROMPT ===================================================================================== 

declare
l_DICT_DMSU_DEPTS  DICT_DMSU_DEPTS%rowtype;

procedure p_merge(p_DICT_DMSU_DEPTS DICT_DMSU_DEPTS%rowtype) 
as
Begin
   insert into DICT_DMSU_DEPTS
      values p_DICT_DMSU_DEPTS; 
 exception when dup_val_on_index then  
   update DICT_DMSU_DEPTS
      set row = p_DICT_DMSU_DEPTS
    where ID = p_DICT_DMSU_DEPTS.ID;
End;
Begin

l_DICT_DMSU_DEPTS.ID :=1;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Державна міграційна служба України';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=2;
l_DICT_DMSU_DEPTS.CODE :='0040';
l_DICT_DMSU_DEPTS.NAME :='Департамент організаційного забезпечення Державної міграційної служби України';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=3;
l_DICT_DMSU_DEPTS.CODE :='0050';
l_DICT_DMSU_DEPTS.NAME :='Управління фінансового забезпечення та бухгалтерської служби Державної міграційної служби України';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=4;
l_DICT_DMSU_DEPTS.CODE :='0070';
l_DICT_DMSU_DEPTS.NAME :='Депаратмент інформатизації, телекомунікацій та захисту інформації Державної міграційної служби України';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=5;
l_DICT_DMSU_DEPTS.CODE :='0060';
l_DICT_DMSU_DEPTS.NAME :='Депаратмент з питань громадянства, паспортизації та  реєстрації Державної міграційної служби України';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=6;
l_DICT_DMSU_DEPTS.CODE :='0080';
l_DICT_DMSU_DEPTS.NAME :='Департамент у справах іноземців та осіб без громадянства Державної міграційної служби України';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=7;
l_DICT_DMSU_DEPTS.CODE :='0099';
l_DICT_DMSU_DEPTS.NAME :='Департамент адміністрування Реєстру Державного підприємства "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=8;
l_DICT_DMSU_DEPTS.CODE :='0501';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=9;
l_DICT_DMSU_DEPTS.CODE :='0501';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=10;
l_DICT_DMSU_DEPTS.CODE :='0588';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=11;
l_DICT_DMSU_DEPTS.CODE :='0514';
l_DICT_DMSU_DEPTS.NAME :='Барський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=12;
l_DICT_DMSU_DEPTS.CODE :='0515';
l_DICT_DMSU_DEPTS.NAME :='Бершадський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=13;
l_DICT_DMSU_DEPTS.CODE :='0516';
l_DICT_DMSU_DEPTS.NAME :='Вінницький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=14;
l_DICT_DMSU_DEPTS.CODE :='0517';
l_DICT_DMSU_DEPTS.NAME :='Гайсинський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=15;
l_DICT_DMSU_DEPTS.CODE :='0536';
l_DICT_DMSU_DEPTS.NAME :='Гніванський міський сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=16;
l_DICT_DMSU_DEPTS.CODE :='0518';
l_DICT_DMSU_DEPTS.NAME :='Жмеринський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=17;
l_DICT_DMSU_DEPTS.CODE :='0510';
l_DICT_DMSU_DEPTS.NAME :='2-й міський відділ у місті Вінниці Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=18;
l_DICT_DMSU_DEPTS.CODE :='0510';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів 2-го міського відділу у місті Вінниці Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=19;
l_DICT_DMSU_DEPTS.CODE :='0505';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=20;
l_DICT_DMSU_DEPTS.CODE :='0519';
l_DICT_DMSU_DEPTS.NAME :='Іллінецький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=21;
l_DICT_DMSU_DEPTS.CODE :='0521';
l_DICT_DMSU_DEPTS.NAME :='Калинівський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=22;
l_DICT_DMSU_DEPTS.CODE :='0520';
l_DICT_DMSU_DEPTS.NAME :='Козятинський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=23;
l_DICT_DMSU_DEPTS.CODE :='0522';
l_DICT_DMSU_DEPTS.NAME :='Крижопільський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=24;
l_DICT_DMSU_DEPTS.CODE :='0513';
l_DICT_DMSU_DEPTS.NAME :='Ладижинський міський сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=25;
l_DICT_DMSU_DEPTS.CODE :='0511';
l_DICT_DMSU_DEPTS.NAME :='1-й міський відділ у місті Вінниці Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=26;
l_DICT_DMSU_DEPTS.CODE :='0502';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів 1-го міського відділу у місті Вінниці Управління Державної міграційної служби ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=27;
l_DICT_DMSU_DEPTS.CODE :='0511';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів 1-го міського відділу у місті Вінниці Управління Державної міграційної служби ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=28;
l_DICT_DMSU_DEPTS.CODE :='0523';
l_DICT_DMSU_DEPTS.NAME :='Липовецький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=29;
l_DICT_DMSU_DEPTS.CODE :='0524';
l_DICT_DMSU_DEPTS.NAME :='Літинський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=30;
l_DICT_DMSU_DEPTS.CODE :='0525';
l_DICT_DMSU_DEPTS.NAME :='Могилів-Подільський районний відділ Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=31;
l_DICT_DMSU_DEPTS.CODE :='0526';
l_DICT_DMSU_DEPTS.NAME :='Мурованокуриловецький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=32;
l_DICT_DMSU_DEPTS.CODE :='0527';
l_DICT_DMSU_DEPTS.NAME :='Немирівський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=33;
l_DICT_DMSU_DEPTS.CODE :='0528';
l_DICT_DMSU_DEPTS.NAME :='Оратівський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=34;
l_DICT_DMSU_DEPTS.CODE :='0529';
l_DICT_DMSU_DEPTS.NAME :='Піщанський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=35;
l_DICT_DMSU_DEPTS.CODE :='0530';
l_DICT_DMSU_DEPTS.NAME :='Погребищенський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=36;
l_DICT_DMSU_DEPTS.CODE :='0512';
l_DICT_DMSU_DEPTS.NAME :='3-й міський відділ у місті Вінниці Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=37;
l_DICT_DMSU_DEPTS.CODE :='0531';
l_DICT_DMSU_DEPTS.NAME :='Теплицький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=38;
l_DICT_DMSU_DEPTS.CODE :='0535';
l_DICT_DMSU_DEPTS.NAME :='Тиврівський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=39;
l_DICT_DMSU_DEPTS.CODE :='0532';
l_DICT_DMSU_DEPTS.NAME :='Томашпільський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:04','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=40;
l_DICT_DMSU_DEPTS.CODE :='0533';
l_DICT_DMSU_DEPTS.NAME :='Тростянецький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=41;
l_DICT_DMSU_DEPTS.CODE :='0534';
l_DICT_DMSU_DEPTS.NAME :='Тульчинський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=42;
l_DICT_DMSU_DEPTS.CODE :='0537';
l_DICT_DMSU_DEPTS.NAME :='Хмільницький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=43;
l_DICT_DMSU_DEPTS.CODE :='0538';
l_DICT_DMSU_DEPTS.NAME :='Чернівецький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=44;
l_DICT_DMSU_DEPTS.CODE :='0539';
l_DICT_DMSU_DEPTS.NAME :='Чечельницький районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=45;
l_DICT_DMSU_DEPTS.CODE :='0540';
l_DICT_DMSU_DEPTS.NAME :='Шаргородський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=46;
l_DICT_DMSU_DEPTS.CODE :='0541';
l_DICT_DMSU_DEPTS.NAME :='Ямпільський районний сектор Управління Державної міграційної служби України у Вінницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=47;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету  Ладижинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=48;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг "Прозорий офіс" (Центральне відділення) виконавчого комітету Вінницької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=49;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг "Прозорий офіс" (відділення "Вишенька") виконавчого комітету Вінницької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=50;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг "Прозорий офіс" (відділення "Замостя") виконавчого комітету Вінницької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=51;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг "Прозорий офіс" (відділення "Старе місто") виконавчого комітету Вінницької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=52;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Жмеринської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=53;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету  Козятинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=54;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Могилів-Подільський міськрайонний центр адміністративних послуг "Прозорий офіс"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=55;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету  Хмільницької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=56;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Барській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=57;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Бершадській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=58;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Гайсинській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=59;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Іллінецькій районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=60;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Калинівській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=61;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Крижопільській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=62;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Лiтинській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=63;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Липовецькій районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=64;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Мурованокуриловецькій районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=65;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при  Немирівськiй районнiй державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=66;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання  адміністративних послуг при  Оратівській районній державній  адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=67;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання  адміністративних послуг при  Піщанській районній державній  адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=68;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг при Погребищенській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=69;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг при Теплицькій районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=70;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Тиврівській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=71;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Томашпільській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=72;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Тростянецькій районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=73;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Тульчинській районній  державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=74;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Чернівецькій районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=75;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при  Чечельницькій районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=76;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при  Шаргородській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=77;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при  Ямпільській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=78;
l_DICT_DMSU_DEPTS.CODE :='0701';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України у Волинській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=79;
l_DICT_DMSU_DEPTS.CODE :='0701';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України у Волинській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=80;
l_DICT_DMSU_DEPTS.CODE :='0788';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=81;
l_DICT_DMSU_DEPTS.CODE :='0712';
l_DICT_DMSU_DEPTS.NAME :='Володимир-Волинський районний відділ Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=82;
l_DICT_DMSU_DEPTS.CODE :='0713';
l_DICT_DMSU_DEPTS.NAME :='Горохівський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=83;
l_DICT_DMSU_DEPTS.CODE :='0714';
l_DICT_DMSU_DEPTS.NAME :='Іваничівський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=84;
l_DICT_DMSU_DEPTS.CODE :='0715';
l_DICT_DMSU_DEPTS.NAME :='Камінь-Каширський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=85;
l_DICT_DMSU_DEPTS.CODE :='0716';
l_DICT_DMSU_DEPTS.NAME :='Ківерцівський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=86;
l_DICT_DMSU_DEPTS.CODE :='0717';
l_DICT_DMSU_DEPTS.NAME :='Ковельський районний відділ Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=87;
l_DICT_DMSU_DEPTS.CODE :='0718';
l_DICT_DMSU_DEPTS.NAME :='Локачинський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=88;
l_DICT_DMSU_DEPTS.CODE :='0710';
l_DICT_DMSU_DEPTS.NAME :='Луцький міській відділ Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=89;
l_DICT_DMSU_DEPTS.CODE :='0710';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=90;
l_DICT_DMSU_DEPTS.CODE :='0719';
l_DICT_DMSU_DEPTS.NAME :='Луцький районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=91;
l_DICT_DMSU_DEPTS.CODE :='0720';
l_DICT_DMSU_DEPTS.NAME :='Любешівський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=92;
l_DICT_DMSU_DEPTS.CODE :='0721';
l_DICT_DMSU_DEPTS.NAME :='Любомльський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=93;
l_DICT_DMSU_DEPTS.CODE :='0722';
l_DICT_DMSU_DEPTS.NAME :='Маневицький районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=94;
l_DICT_DMSU_DEPTS.CODE :='0711';
l_DICT_DMSU_DEPTS.NAME :='Нововолинський міський відділ Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=95;
l_DICT_DMSU_DEPTS.CODE :='0723';
l_DICT_DMSU_DEPTS.NAME :='Ратнівський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=96;
l_DICT_DMSU_DEPTS.CODE :='0724';
l_DICT_DMSU_DEPTS.NAME :='Рожищенський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=97;
l_DICT_DMSU_DEPTS.CODE :='0725';
l_DICT_DMSU_DEPTS.NAME :='Старовижівський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=98;
l_DICT_DMSU_DEPTS.CODE :='0726';
l_DICT_DMSU_DEPTS.NAME :='Турійський районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=99;
l_DICT_DMSU_DEPTS.CODE :='0727';
l_DICT_DMSU_DEPTS.NAME :='Шацький районний сектор Управління Державної міграційної служби України у Волинській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=100;
l_DICT_DMSU_DEPTS.CODE :='0777';
l_DICT_DMSU_DEPTS.NAME :='Волинський пункт тимчасового перебування іноземців та осіб без громадянства';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=101;
l_DICT_DMSU_DEPTS.CODE :='0710';
l_DICT_DMSU_DEPTS.NAME :='Департамент "Центр надання адміністративних послуг у місті Луцьку" Луцької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=102;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Володимир-Волинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=103;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету  Ковельської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=104;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ "Центр надання адміністративних послуг" Нововолинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=105;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Володимир-Волинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=106;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Горохівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=107;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Іваничівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=108;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор центр надання адміністративних послуг апарату Камінь-Каширської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=109;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ківерцівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=110;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор надання адміністративних послуг Ковельської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=111;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Локачинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=112;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор-Центр надання адміністративних послуг апарату Луцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=113;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор Центр надання адміністративних послуг апарату Любомльської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=114;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Любешівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=115;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Маневицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=116;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор Центр надання адміністративних послуг апарату Ратнівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=117;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор "Центр надання адміністративних послуг"  апарату Рожищенської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=118;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор "Центр надання адміністративних послуг" апарату Старовижівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=119;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор-центр надання адміністративних послуг Турійської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=120;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Шацької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=121;
l_DICT_DMSU_DEPTS.CODE :='1201';
l_DICT_DMSU_DEPTS.NAME :='Головне управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=122;
l_DICT_DMSU_DEPTS.CODE :='1201';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 1 Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=123;
l_DICT_DMSU_DEPTS.CODE :='1202';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 2 Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=124;
l_DICT_DMSU_DEPTS.CODE :='1202';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=125;
l_DICT_DMSU_DEPTS.CODE :='1288';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління з питань громадянства, паспортизації та реєстрації  Головного Управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=126;
l_DICT_DMSU_DEPTS.CODE :='1210';
l_DICT_DMSU_DEPTS.NAME :='Амур-Нижньодніпровський районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=127;
l_DICT_DMSU_DEPTS.CODE :='1240';
l_DICT_DMSU_DEPTS.NAME :='Апостолівський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=128;
l_DICT_DMSU_DEPTS.CODE :='1211';
l_DICT_DMSU_DEPTS.NAME :='Шевченківський районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=129;
l_DICT_DMSU_DEPTS.CODE :='1211';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Шевченківського районного відділу у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=130;
l_DICT_DMSU_DEPTS.CODE :='1220';
l_DICT_DMSU_DEPTS.NAME :='Південний районний відділ у місті Кам''янське (Дніпродзержинську) Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=131;
l_DICT_DMSU_DEPTS.CODE :='1242';
l_DICT_DMSU_DEPTS.NAME :='Васильківський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=132;
l_DICT_DMSU_DEPTS.CODE :='1243';
l_DICT_DMSU_DEPTS.NAME :='Верхньодніпровський районний відділ Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=133;
l_DICT_DMSU_DEPTS.CODE :='1218';
l_DICT_DMSU_DEPTS.NAME :='Вільногірський міський сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=134;
l_DICT_DMSU_DEPTS.CODE :='1225';
l_DICT_DMSU_DEPTS.NAME :='Дзержинський районний відділ у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=135;
l_DICT_DMSU_DEPTS.CODE :='1221';
l_DICT_DMSU_DEPTS.NAME :='Дніпровський районний відділ у місті Кам''янське  Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=136;
l_DICT_DMSU_DEPTS.CODE :='1244';
l_DICT_DMSU_DEPTS.NAME :='Дніпровський районний відділ Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=137;
l_DICT_DMSU_DEPTS.CODE :='1226';
l_DICT_DMSU_DEPTS.NAME :='Довгинцівський районний відділ у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=138;
l_DICT_DMSU_DEPTS.CODE :='1212';
l_DICT_DMSU_DEPTS.NAME :='Соборний районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=139;
l_DICT_DMSU_DEPTS.CODE :='1227';
l_DICT_DMSU_DEPTS.NAME :='Жовтневий районний відділ у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=140;
l_DICT_DMSU_DEPTS.CODE :='1223';
l_DICT_DMSU_DEPTS.NAME :='Жовтоводський міський сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=141;
l_DICT_DMSU_DEPTS.CODE :='1222';
l_DICT_DMSU_DEPTS.NAME :='Заводський районний відділ у місті Кам''янське  Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=142;
l_DICT_DMSU_DEPTS.CODE :='1219';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Заводського районного відділу у місті Кам''янське  Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=143;
l_DICT_DMSU_DEPTS.CODE :='1228';
l_DICT_DMSU_DEPTS.NAME :='Інгулецький районний сектор у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=144;
l_DICT_DMSU_DEPTS.CODE :='1213';
l_DICT_DMSU_DEPTS.NAME :='Індустріальний районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=145;
l_DICT_DMSU_DEPTS.CODE :='1214';
l_DICT_DMSU_DEPTS.NAME :='Центральний районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=146;
l_DICT_DMSU_DEPTS.CODE :='1215';
l_DICT_DMSU_DEPTS.NAME :='Чечелівський районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=147;
l_DICT_DMSU_DEPTS.CODE :='1245';
l_DICT_DMSU_DEPTS.NAME :='Криворізький районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=148;
l_DICT_DMSU_DEPTS.CODE :='1246';
l_DICT_DMSU_DEPTS.NAME :='Криничанський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=149;
l_DICT_DMSU_DEPTS.CODE :='1216';
l_DICT_DMSU_DEPTS.NAME :='Новокодацький районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=150;
l_DICT_DMSU_DEPTS.CODE :='1216';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Новокодацького районного відділу у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=151;
l_DICT_DMSU_DEPTS.CODE :='1247';
l_DICT_DMSU_DEPTS.NAME :='Магдалинівський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=152;
l_DICT_DMSU_DEPTS.CODE :='1233';
l_DICT_DMSU_DEPTS.NAME :='Марганецький міський сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=153;
l_DICT_DMSU_DEPTS.CODE :='1248';
l_DICT_DMSU_DEPTS.NAME :='Межівський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=154;
l_DICT_DMSU_DEPTS.CODE :='1234';
l_DICT_DMSU_DEPTS.NAME :='Нікопольський районний відділ Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=155;
l_DICT_DMSU_DEPTS.CODE :='1234';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Нікопольського районного відділу Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=156;
l_DICT_DMSU_DEPTS.CODE :='1235';
l_DICT_DMSU_DEPTS.NAME :='Новомосковський районний відділ Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=157;
l_DICT_DMSU_DEPTS.CODE :='1235';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Новомосковського районного відділу Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=158;
l_DICT_DMSU_DEPTS.CODE :='1236';
l_DICT_DMSU_DEPTS.NAME :='Покровський  міський сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=159;
l_DICT_DMSU_DEPTS.CODE :='1256';
l_DICT_DMSU_DEPTS.NAME :='П`ятихатський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=160;
l_DICT_DMSU_DEPTS.CODE :='1237';
l_DICT_DMSU_DEPTS.NAME :='Павлоградський районний відділ Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=161;
l_DICT_DMSU_DEPTS.CODE :='1237';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Павлоградського районного відділу Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=162;
l_DICT_DMSU_DEPTS.CODE :='1238';
l_DICT_DMSU_DEPTS.NAME :='Першотравенський міський сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=163;
l_DICT_DMSU_DEPTS.CODE :='1253';
l_DICT_DMSU_DEPTS.NAME :='Петриківський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=164;
l_DICT_DMSU_DEPTS.CODE :='1254';
l_DICT_DMSU_DEPTS.NAME :='Петропавлівський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=165;
l_DICT_DMSU_DEPTS.CODE :='1255';
l_DICT_DMSU_DEPTS.NAME :='Покровський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=166;
l_DICT_DMSU_DEPTS.CODE :='1229';
l_DICT_DMSU_DEPTS.NAME :='Саксаганський районний відділ у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=167;
l_DICT_DMSU_DEPTS.CODE :='1217';
l_DICT_DMSU_DEPTS.NAME :='Самарський районний відділ у місті Дніпрі Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=168;
l_DICT_DMSU_DEPTS.CODE :='1257';
l_DICT_DMSU_DEPTS.NAME :='Синельниківський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=169;
l_DICT_DMSU_DEPTS.CODE :='1258';
l_DICT_DMSU_DEPTS.NAME :='Солонянський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=170;
l_DICT_DMSU_DEPTS.CODE :='1259';
l_DICT_DMSU_DEPTS.NAME :='Софіївський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=171;
l_DICT_DMSU_DEPTS.CODE :='1239';
l_DICT_DMSU_DEPTS.NAME :='Тернівський міський сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=172;
l_DICT_DMSU_DEPTS.CODE :='1230';
l_DICT_DMSU_DEPTS.NAME :='Тернівський районний сектор у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=173;
l_DICT_DMSU_DEPTS.CODE :='1260';
l_DICT_DMSU_DEPTS.NAME :='Томаківський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=174;
l_DICT_DMSU_DEPTS.CODE :='1261';
l_DICT_DMSU_DEPTS.NAME :='Царичанський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=175;
l_DICT_DMSU_DEPTS.CODE :='1231';
l_DICT_DMSU_DEPTS.NAME :='Центрально-Міський районний відділ у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=176;
l_DICT_DMSU_DEPTS.CODE :='1224';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Центрально-Міського районного відділу у місті Кривому Розі Головного управління Державної міграційної служби України в Дніпропетровській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=177;
l_DICT_DMSU_DEPTS.CODE :='1224';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=178;
l_DICT_DMSU_DEPTS.CODE :='1262';
l_DICT_DMSU_DEPTS.NAME :='Широківський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=179;
l_DICT_DMSU_DEPTS.CODE :='1263';
l_DICT_DMSU_DEPTS.NAME :='Юр`ївський районний сектор Головного управління Державної міграційної служби України в Дніпропетровській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=180;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Філія центру надання адміністративних послуг Дніпропетровської міської ради "Правобережний"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=181;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Філія центру надання адміністративних послуг Дніпропетровської міської ради "Лівобережний"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=182;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг "Муніципальний центр послуг м.Вільногірськ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=183;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг «Міський центр муніципальних послуг» Кам"янської (Дніпродзержинської) міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=184;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Жовтоводської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=185;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг "Муніципальний центр послуг м.Кривого Рогу "';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=186;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг міста Марганця Марганецької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=187;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Нікополя';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=188;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Новомосковської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=189;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету міської ради міста Покров';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=190;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Павлоградської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=191;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання вдміністративних послуг виконавчого комітету Першотравенської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=192;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Синельниківської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=193;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Тернівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=194;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Апостолівської районної державної адміністраціі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=195;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Васильківського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=196;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Верхньодніпровської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=197;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Дніпропетровської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=198;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Криворізької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=199;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Криничанської райдержадмістрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=200;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Магдалинівської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=201;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Межівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=202;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Нікопольської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=203;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Новомосковській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=204;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Павлоградської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=205;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг "Єдність" при Петриківській райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=206;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр  надання адміністративних послуг Петропавлівської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=207;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Покровської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=208;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при П''ятихатській райдержадміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=209;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Синельниківської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=210;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Солонянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=211;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг в  Софіївському районі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=212;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Томаківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=213;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  "Альтернатива" при  Царичанській районій державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=214;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Широківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=215;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Юр’ївської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=216;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг смт. Ювілейне';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=217;
l_DICT_DMSU_DEPTS.CODE :='1401';
l_DICT_DMSU_DEPTS.NAME :='Головне управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=218;
l_DICT_DMSU_DEPTS.CODE :='1401';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 1 Управління з питань громадянства, паспортизації та реєстрації  Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=219;
l_DICT_DMSU_DEPTS.CODE :='1435';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 2 Управління з питань громадянства, паспортизації та реєстрації  Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=220;
l_DICT_DMSU_DEPTS.CODE :='1403';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 3 Управління з питань громадянства, паспортизації та реєстрації  Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=221;
l_DICT_DMSU_DEPTS.CODE :='1488';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління з питань громадянства, паспортизації та реєстрації  Головного Управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=222;
l_DICT_DMSU_DEPTS.CODE :='1419';
l_DICT_DMSU_DEPTS.NAME :='Авдіївський міський сектор з обслуговуванням Очеретинської територіальної громади Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=223;
l_DICT_DMSU_DEPTS.CODE :='1420';
l_DICT_DMSU_DEPTS.NAME :='Бахмутський (Артемівський) міський відділ Головного управління Державної міграційної служби України в Донецькій області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=224;
l_DICT_DMSU_DEPTS.CODE :='1469';
l_DICT_DMSU_DEPTS.NAME :='Великоновосілківський районний сектор Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=225;
l_DICT_DMSU_DEPTS.CODE :='1470';
l_DICT_DMSU_DEPTS.NAME :='Волноваський районний відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=226;
l_DICT_DMSU_DEPTS.CODE :='1471';
l_DICT_DMSU_DEPTS.NAME :='Нікольський (Володарський) районний сектор Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=227;
l_DICT_DMSU_DEPTS.CODE :='1460';
l_DICT_DMSU_DEPTS.NAME :='Вугледарський міський сектор Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=228;
l_DICT_DMSU_DEPTS.CODE :='1427';
l_DICT_DMSU_DEPTS.NAME :='Дебальцевський міський сектор Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=229;
l_DICT_DMSU_DEPTS.CODE :='1428';
l_DICT_DMSU_DEPTS.NAME :='Торецький (Дзержинський) міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=230;
l_DICT_DMSU_DEPTS.CODE :='1429';
l_DICT_DMSU_DEPTS.NAME :='Мирноградський (Димитровський) міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=231;
l_DICT_DMSU_DEPTS.CODE :='1430';
l_DICT_DMSU_DEPTS.NAME :='Добропільський міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=232;
l_DICT_DMSU_DEPTS.CODE :='1432';
l_DICT_DMSU_DEPTS.NAME :='Дружківський міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=233;
l_DICT_DMSU_DEPTS.CODE :='1436';
l_DICT_DMSU_DEPTS.NAME :='Центральний (Жовтневий) районний відділ у місті Маріуполі Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=234;
l_DICT_DMSU_DEPTS.CODE :='1437';
l_DICT_DMSU_DEPTS.NAME :='Кальміуський (Іллічівський) районний відділ у місті Маріуполі Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=235;
l_DICT_DMSU_DEPTS.CODE :='1442';
l_DICT_DMSU_DEPTS.NAME :='Костянтинівський міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=236;
l_DICT_DMSU_DEPTS.CODE :='1443';
l_DICT_DMSU_DEPTS.NAME :='Краматорський міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=237;
l_DICT_DMSU_DEPTS.CODE :='1443';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Краматорського міського відділу Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=238;
l_DICT_DMSU_DEPTS.CODE :='1444';
l_DICT_DMSU_DEPTS.NAME :='Покровський (Красноармійський) міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=239;
l_DICT_DMSU_DEPTS.CODE :='1444';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Покровського (Красноармійського) міського відділу Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=240;
l_DICT_DMSU_DEPTS.CODE :='1445';
l_DICT_DMSU_DEPTS.NAME :='Лиманський (Краснолиманський) міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=241;
l_DICT_DMSU_DEPTS.CODE :='1474';
l_DICT_DMSU_DEPTS.NAME :='Мар''їнський районний відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=242;
l_DICT_DMSU_DEPTS.CODE :='1465';
l_DICT_DMSU_DEPTS.NAME :='Олександрівський районний сектор Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=243;
l_DICT_DMSU_DEPTS.CODE :='1438';
l_DICT_DMSU_DEPTS.NAME :='Лівобережний (Орджонікідзевський) районний відділ у місті Маріуполі Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=244;
l_DICT_DMSU_DEPTS.CODE :='1477';
l_DICT_DMSU_DEPTS.NAME :='Мангушський (Першотравневий) районний відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=245;
l_DICT_DMSU_DEPTS.CODE :='1439';
l_DICT_DMSU_DEPTS.NAME :='Приморський районний відділ у місті Маріуполі Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=246;
l_DICT_DMSU_DEPTS.CODE :='1452';
l_DICT_DMSU_DEPTS.NAME :='Селидівський міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=247;
l_DICT_DMSU_DEPTS.CODE :='1455';
l_DICT_DMSU_DEPTS.NAME :='Слов''янський міський відділ Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=248;
l_DICT_DMSU_DEPTS.CODE :='1455';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Слов''янського  міського  відділу Головного управління Державної міграційної служби України в Донецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=249;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Департамент адміністративних послуг Маріупольської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=250;
l_DICT_DMSU_DEPTS.CODE :='1435';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=251;
l_DICT_DMSU_DEPTS.CODE :='1436';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=252;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Авдіївської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=253;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Бахмутської  міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=254;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Вугледарської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=255;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг міста Дебальцеве';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=256;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг міста Торецька (Дзержинська) ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=257;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у м.Димитрові';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=258;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у місті Добропіллі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=259;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м.Дружківка';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=260;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Костянтинівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=261;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Краматорської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=262;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Лиман (Красний Лиман)';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=263;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Покровської (Красноармійської) міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=264;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг "Діалог" Маріупольської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=265;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг Новогродівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=266;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у м.Селидове';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=267;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг міста Слов''янська';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=268;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Бахмутській (Артемівській) районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=269;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Великоновосілківській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=270;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Волноваській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=271;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Нікольської (Володарської) районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=272;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Добропільської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=273;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Костянтинівській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=274;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Красноармійської районної державної адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=275;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Мар"їнської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=276;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Олександрівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=277;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг в Першотравневому районі  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=278;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Слов''янської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=279;
l_DICT_DMSU_DEPTS.CODE :='1801';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Житомирській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=280;
l_DICT_DMSU_DEPTS.CODE :='1801';
l_DICT_DMSU_DEPTS.NAME :='Сектор по роботі з Єдиним державним демографічним реєстром Управління Державної міграційної служби України в Житомирській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=281;
l_DICT_DMSU_DEPTS.CODE :='1801';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=282;
l_DICT_DMSU_DEPTS.CODE :='1888';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Житомирській  області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=283;
l_DICT_DMSU_DEPTS.CODE :='1812';
l_DICT_DMSU_DEPTS.NAME :='Андрушівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=284;
l_DICT_DMSU_DEPTS.CODE :='1813';
l_DICT_DMSU_DEPTS.NAME :='Баранівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=285;
l_DICT_DMSU_DEPTS.CODE :='1814';
l_DICT_DMSU_DEPTS.NAME :='Бердичівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=286;
l_DICT_DMSU_DEPTS.CODE :='1836';
l_DICT_DMSU_DEPTS.NAME :='Богунський районний відділ у м. Житомирі Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=287;
l_DICT_DMSU_DEPTS.CODE :='1815';
l_DICT_DMSU_DEPTS.NAME :='Брусилівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=288;
l_DICT_DMSU_DEPTS.CODE :='1816';
l_DICT_DMSU_DEPTS.NAME :='Хорошівський (Володарсько-Волинський) районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=289;
l_DICT_DMSU_DEPTS.CODE :='1818';
l_DICT_DMSU_DEPTS.NAME :='Ємільчинський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=290;
l_DICT_DMSU_DEPTS.CODE :='1819';
l_DICT_DMSU_DEPTS.NAME :='Житомирський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=291;
l_DICT_DMSU_DEPTS.CODE :='1810';
l_DICT_DMSU_DEPTS.NAME :='Корольовський районний відділ у м. Житомирі Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=292;
l_DICT_DMSU_DEPTS.CODE :='1820';
l_DICT_DMSU_DEPTS.NAME :='Коростенський районний відділ Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=293;
l_DICT_DMSU_DEPTS.CODE :='1821';
l_DICT_DMSU_DEPTS.NAME :='Коростишівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=294;
l_DICT_DMSU_DEPTS.CODE :='1822';
l_DICT_DMSU_DEPTS.NAME :='Лугинський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=295;
l_DICT_DMSU_DEPTS.CODE :='1823';
l_DICT_DMSU_DEPTS.NAME :='Любарський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=296;
l_DICT_DMSU_DEPTS.CODE :='1824';
l_DICT_DMSU_DEPTS.NAME :='Малинський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=297;
l_DICT_DMSU_DEPTS.CODE :='1825';
l_DICT_DMSU_DEPTS.NAME :='Народицький районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=298;
l_DICT_DMSU_DEPTS.CODE :='1826';
l_DICT_DMSU_DEPTS.NAME :='Новоград-Волинський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=299;
l_DICT_DMSU_DEPTS.CODE :='1827';
l_DICT_DMSU_DEPTS.NAME :='Овруцький районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=300;
l_DICT_DMSU_DEPTS.CODE :='1828';
l_DICT_DMSU_DEPTS.NAME :='Олевський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=301;
l_DICT_DMSU_DEPTS.CODE :='1829';
l_DICT_DMSU_DEPTS.NAME :='Попільнянський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=302;
l_DICT_DMSU_DEPTS.CODE :='1830';
l_DICT_DMSU_DEPTS.NAME :='Радомишльський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=303;
l_DICT_DMSU_DEPTS.CODE :='1835';
l_DICT_DMSU_DEPTS.NAME :='Романівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=304;
l_DICT_DMSU_DEPTS.CODE :='1831';
l_DICT_DMSU_DEPTS.NAME :='Ружинський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=305;
l_DICT_DMSU_DEPTS.CODE :='1832';
l_DICT_DMSU_DEPTS.NAME :='Пулинський (Червоноармійський) районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=306;
l_DICT_DMSU_DEPTS.CODE :='1833';
l_DICT_DMSU_DEPTS.NAME :='Черняхівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=307;
l_DICT_DMSU_DEPTS.CODE :='1834';
l_DICT_DMSU_DEPTS.NAME :='Чуднівський районний сектор Управління Державної міграційної служби України в Житомирській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=308;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Бердичівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=309;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Житомирської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=310;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у місті Коростені';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=311;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у місті Малині                       ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=312;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новоград-Волинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=313;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Андрушівський центр надання адміністративний послуг Андрушівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=314;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Брусилівської районної державної адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=315;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Баранівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=316;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бердичівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=317;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Володарсько-Волинській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=318;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ємільчинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=319;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Житомирської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=320;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Коростишівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=321;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Коростенській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=322;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Лугинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=323;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Любарської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=324;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Малинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=325;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Народицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=326;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новоград-Волинської районної державної адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=327;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг Овруцької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=328;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг Олевської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=329;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Попільнянській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=330;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Романівській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=331;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Радомишльської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=332;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ружинської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=333;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Черняхівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=334;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Чуднівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=335;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Червоноармійської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=336;
l_DICT_DMSU_DEPTS.CODE :='2101';
l_DICT_DMSU_DEPTS.NAME :='Головне управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=337;
l_DICT_DMSU_DEPTS.CODE :='2101';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1  Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=338;
l_DICT_DMSU_DEPTS.CODE :='2101';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2  Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=339;
l_DICT_DMSU_DEPTS.CODE :='2105';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=340;
l_DICT_DMSU_DEPTS.CODE :='2188';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління з питань громадянства, паспортизації та реєстрації Головного Управління Державної міграційної служби України в Закрапатській   області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=341;
l_DICT_DMSU_DEPTS.CODE :='2112';
l_DICT_DMSU_DEPTS.NAME :='Берегівський районний відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=342;
l_DICT_DMSU_DEPTS.CODE :='2126';
l_DICT_DMSU_DEPTS.NAME :='Великоберезнянський районний сектор Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=343;
l_DICT_DMSU_DEPTS.CODE :='2114';
l_DICT_DMSU_DEPTS.NAME :='Виноградівський районний відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=344;
l_DICT_DMSU_DEPTS.CODE :='2127';
l_DICT_DMSU_DEPTS.NAME :='Воловецький районний сектор Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=345;
l_DICT_DMSU_DEPTS.CODE :='2116';
l_DICT_DMSU_DEPTS.NAME :='Іршавський районний вііділ  Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=346;
l_DICT_DMSU_DEPTS.CODE :='2128';
l_DICT_DMSU_DEPTS.NAME :='Міжгірський районний сектор Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=347;
l_DICT_DMSU_DEPTS.CODE :='2129';
l_DICT_DMSU_DEPTS.NAME :='Мукачівський районний сектор Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=348;
l_DICT_DMSU_DEPTS.CODE :='2111';
l_DICT_DMSU_DEPTS.NAME :='Мукачівський міський відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=349;
l_DICT_DMSU_DEPTS.CODE :='2125';
l_DICT_DMSU_DEPTS.NAME :='Перечинський районний сектор Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=350;
l_DICT_DMSU_DEPTS.CODE :='2120';
l_DICT_DMSU_DEPTS.NAME :='Рахівський районний відділ Головного управління Державної міграційної служби в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=351;
l_DICT_DMSU_DEPTS.CODE :='2121';
l_DICT_DMSU_DEPTS.NAME :='Свалявський районний відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=352;
l_DICT_DMSU_DEPTS.CODE :='2122';
l_DICT_DMSU_DEPTS.NAME :='Тячівський районний відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=353;
l_DICT_DMSU_DEPTS.CODE :='2123';
l_DICT_DMSU_DEPTS.NAME :='Ужгородський районний відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=354;
l_DICT_DMSU_DEPTS.CODE :='2110';
l_DICT_DMSU_DEPTS.NAME :='Ужгородський міський відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=355;
l_DICT_DMSU_DEPTS.CODE :='2124';
l_DICT_DMSU_DEPTS.NAME :='Хустський районний відділ Головного управління Державної міграційної служби України в Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=356;
l_DICT_DMSU_DEPTS.CODE :='2177';
l_DICT_DMSU_DEPTS.NAME :='Пункт тимчасового розміщення біженців у Закарпатській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=357;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Ужгородської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=358;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Берегівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=359;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при виконавчому комітеті Мукачівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=360;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при виконкомі Хустської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=361;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Чопської міської ради                            ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=362;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Cектор надання  адміністративних послуг Берегівської районної державної';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=363;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ "Центр надання адміністративних послуг" Великоберезнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=364;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Виноградівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=365;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Воловецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=366;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Іршавської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=367;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Міжгірської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=368;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Мукачівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:05','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=369;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Перечинській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=370;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Рахівській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=371;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Свалявській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=372;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання  адміністративних послуг Тячівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=373;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ужгородської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=374;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Хустської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=375;
l_DICT_DMSU_DEPTS.CODE :='2301';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=376;
l_DICT_DMSU_DEPTS.CODE :='2301';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 відділу з питань громадянства, паспортизації  та реєстрації Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=377;
l_DICT_DMSU_DEPTS.CODE :='2301';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=378;
l_DICT_DMSU_DEPTS.CODE :='2301';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 відділу з питань громадянства, паспортизації  та реєстрації Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=379;
l_DICT_DMSU_DEPTS.CODE :='2388';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=380;
l_DICT_DMSU_DEPTS.CODE :='2317';
l_DICT_DMSU_DEPTS.NAME :='Бердянський міський відділ Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=381;
l_DICT_DMSU_DEPTS.CODE :='2317';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Бердянського  міського відділу Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=382;
l_DICT_DMSU_DEPTS.CODE :='2322';
l_DICT_DMSU_DEPTS.NAME :='Василівський районний відділ Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=383;
l_DICT_DMSU_DEPTS.CODE :='2324';
l_DICT_DMSU_DEPTS.NAME :='Великобілозерський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=384;
l_DICT_DMSU_DEPTS.CODE :='2325';
l_DICT_DMSU_DEPTS.NAME :='Веселівський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=385;
l_DICT_DMSU_DEPTS.CODE :='2326';
l_DICT_DMSU_DEPTS.NAME :='Вільнянський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=386;
l_DICT_DMSU_DEPTS.CODE :='2327';
l_DICT_DMSU_DEPTS.NAME :='Гуляйпільський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=387;
l_DICT_DMSU_DEPTS.CODE :='2319';
l_DICT_DMSU_DEPTS.NAME :='Енергодарський міський відділ Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=388;
l_DICT_DMSU_DEPTS.CODE :='2310';
l_DICT_DMSU_DEPTS.NAME :='Олександрівський (Жовтневий) районний відділ у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=389;
l_DICT_DMSU_DEPTS.CODE :='2311';
l_DICT_DMSU_DEPTS.NAME :='Заводський районний відділ у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=390;
l_DICT_DMSU_DEPTS.CODE :='2328';
l_DICT_DMSU_DEPTS.NAME :='Запорізький районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=391;
l_DICT_DMSU_DEPTS.CODE :='2329';
l_DICT_DMSU_DEPTS.NAME :='Кам''янсько-Дніпровський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=392;
l_DICT_DMSU_DEPTS.CODE :='2312';
l_DICT_DMSU_DEPTS.NAME :='Комунарський районний відділ у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=393;
l_DICT_DMSU_DEPTS.CODE :='2330';
l_DICT_DMSU_DEPTS.NAME :='Більмацький (Куйбишевський) районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=394;
l_DICT_DMSU_DEPTS.CODE :='2313';
l_DICT_DMSU_DEPTS.NAME :='Дніпровський (Ленінський) районний відділ у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=395;
l_DICT_DMSU_DEPTS.CODE :='2313';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Дніпровського (Ленінського) районного віддіул у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=396;
l_DICT_DMSU_DEPTS.CODE :='2318';
l_DICT_DMSU_DEPTS.NAME :='Мелітопольський міський відділ Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=397;
l_DICT_DMSU_DEPTS.CODE :='2318';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів   Мелітопольського міського відділу Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=398;
l_DICT_DMSU_DEPTS.CODE :='2332';
l_DICT_DMSU_DEPTS.NAME :='Михайлівський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=399;
l_DICT_DMSU_DEPTS.CODE :='2333';
l_DICT_DMSU_DEPTS.NAME :='Новомиколаївський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=400;
l_DICT_DMSU_DEPTS.CODE :='2314';
l_DICT_DMSU_DEPTS.NAME :='Вознесенівський (Орджонікідзевський) районний відділ у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=401;
l_DICT_DMSU_DEPTS.CODE :='2314';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Вознесенівського (Орджонікідзевського) районного відділу у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=402;
l_DICT_DMSU_DEPTS.CODE :='2334';
l_DICT_DMSU_DEPTS.NAME :='Оріхівський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=403;
l_DICT_DMSU_DEPTS.CODE :='2335';
l_DICT_DMSU_DEPTS.NAME :='Пологівський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=404;
l_DICT_DMSU_DEPTS.CODE :='2336';
l_DICT_DMSU_DEPTS.NAME :='Приазовський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=405;
l_DICT_DMSU_DEPTS.CODE :='2337';
l_DICT_DMSU_DEPTS.NAME :='Приморський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=406;
l_DICT_DMSU_DEPTS.CODE :='2338';
l_DICT_DMSU_DEPTS.NAME :='Розівський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=407;
l_DICT_DMSU_DEPTS.CODE :='2339';
l_DICT_DMSU_DEPTS.NAME :='Токмацький районний відділ Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=408;
l_DICT_DMSU_DEPTS.CODE :='2315';
l_DICT_DMSU_DEPTS.NAME :='Хортицький районний відділ у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=409;
l_DICT_DMSU_DEPTS.CODE :='2340';
l_DICT_DMSU_DEPTS.NAME :='Чернігівський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=410;
l_DICT_DMSU_DEPTS.CODE :='2316';
l_DICT_DMSU_DEPTS.NAME :='Шевченківський районний відділ у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=411;
l_DICT_DMSU_DEPTS.CODE :='2316';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Шевченківського районного відділу у місті Запоріжжі Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=412;
l_DICT_DMSU_DEPTS.CODE :='2320';
l_DICT_DMSU_DEPTS.NAME :='Якимівський районний сектор Управління Державної міграційної служби України в Запорізькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=413;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Запоріжжя ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=414;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг "Єдиний офіс" Виконавчого комітету Бердянської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=415;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг "Єдиний офіс" Енергодарської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=416;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Мелітополя Запорізької області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=417;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг відділу підприємства та надання адміністративних послуг виконавчого комітету Токмацької міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=418;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Бердянської райдержадміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=419;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Василівської райдержадміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=420;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор з питань організації діяльності центру надання адміністративних послуг райдержадміністрації Великобілозерського району ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=421;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ економічного розвитку і торгівлі та з питань надання адміністративних послуг  Веселівської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=422;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Вільнянська райдержадміністрація';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=423;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Гуляйпільської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=424;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Запорізькій райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=425;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Кам''янсько-Дніпровській райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=426;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Більмацькій райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=427;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ надання адміністративних послуг  Мелітопольської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=428;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Михайлівській райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=429;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новомиколаївської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=430;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ економічного розвитку та торгівлі  Оріхівській райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=431;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ з питань надання адміністративних послуг при Пологівській райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=432;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Приазовської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=433;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ з питань організації дільяності Центру надання адміністративних послуг Приморської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=434;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор з питань надання адміністративних послуг Розівської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=435;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ з питань організації діяльності Центру надання адміністративних послуг Токмацької райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=436;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ економічного розвитку та надання адміністративних послуг Чернігівської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=437;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ з питань надання адміністративних послуг Якимівської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=438;
l_DICT_DMSU_DEPTS.CODE :='2601';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Івано-Франківській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=439;
l_DICT_DMSU_DEPTS.CODE :='2601';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації  Державної міграційної служби України в Івано-Франківській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=440;
l_DICT_DMSU_DEPTS.CODE :='2601';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=441;
l_DICT_DMSU_DEPTS.CODE :='2688';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Івано-Франківській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=442;
l_DICT_DMSU_DEPTS.CODE :='2613';
l_DICT_DMSU_DEPTS.NAME :='Богородчанський районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=443;
l_DICT_DMSU_DEPTS.CODE :='2614';
l_DICT_DMSU_DEPTS.NAME :='Верховинський районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=444;
l_DICT_DMSU_DEPTS.CODE :='2615';
l_DICT_DMSU_DEPTS.NAME :='Галицький районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=445;
l_DICT_DMSU_DEPTS.CODE :='2616';
l_DICT_DMSU_DEPTS.NAME :='Городенківський районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=446;
l_DICT_DMSU_DEPTS.CODE :='2617';
l_DICT_DMSU_DEPTS.NAME :='Долинський районний відділ Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=447;
l_DICT_DMSU_DEPTS.CODE :='2610';
l_DICT_DMSU_DEPTS.NAME :='Івано-Франківський міський відділ Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=448;
l_DICT_DMSU_DEPTS.CODE :='2618';
l_DICT_DMSU_DEPTS.NAME :='Калуський районний відділ Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=449;
l_DICT_DMSU_DEPTS.CODE :='2619';
l_DICT_DMSU_DEPTS.NAME :='Коломийський районний відділ Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=450;
l_DICT_DMSU_DEPTS.CODE :='2620';
l_DICT_DMSU_DEPTS.NAME :='Косівський районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=451;
l_DICT_DMSU_DEPTS.CODE :='2621';
l_DICT_DMSU_DEPTS.NAME :='Надвірнянський районний відділ Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=452;
l_DICT_DMSU_DEPTS.CODE :='2622';
l_DICT_DMSU_DEPTS.NAME :='Рогатинський районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=453;
l_DICT_DMSU_DEPTS.CODE :='2623';
l_DICT_DMSU_DEPTS.NAME :='Рожнятівський районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=454;
l_DICT_DMSU_DEPTS.CODE :='2624';
l_DICT_DMSU_DEPTS.NAME :='Снятинський районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=455;
l_DICT_DMSU_DEPTS.CODE :='2626';
l_DICT_DMSU_DEPTS.NAME :='Тисменицький районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=456;
l_DICT_DMSU_DEPTS.CODE :='2625';
l_DICT_DMSU_DEPTS.NAME :='Тлумацький районний сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=457;
l_DICT_DMSU_DEPTS.CODE :='2612';
l_DICT_DMSU_DEPTS.NAME :='Яремчанський міський сектор Управління Державної міграційної служби України в Івано-Франківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=458;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Івано-Франківської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=459;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Болехівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=460;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Бурштинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=461;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Калуської міської ради                 ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=462;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Коломийської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=463;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Яремчанської міської ради                                                      ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=464;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Богородчанської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=465;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Верховинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=466;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Галицької районної державної адміністрації     ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=467;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Городенківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=468;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Долинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=469;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Калуської районної державної адміністрації                  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=470;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Коломийської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=471;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Косівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=472;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Надвірнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=473;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Рожнятівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=474;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Рогатинський центр надання адміністративних послуг                                      ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=475;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Снятинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=476;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Тисменицької  районної державної адміністрації   ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=477;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Тлумацький  районної державної адміністрації   ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=478;
l_DICT_DMSU_DEPTS.CODE :='3201';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=479;
l_DICT_DMSU_DEPTS.CODE :='3201';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=480;
l_DICT_DMSU_DEPTS.CODE :='3201';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=481;
l_DICT_DMSU_DEPTS.CODE :='3202';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=482;
l_DICT_DMSU_DEPTS.CODE :='3202';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=483;
l_DICT_DMSU_DEPTS.CODE :='3288';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=484;
l_DICT_DMSU_DEPTS.CODE :='3219';
l_DICT_DMSU_DEPTS.NAME :='Баришівський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=485;
l_DICT_DMSU_DEPTS.CODE :='3210';
l_DICT_DMSU_DEPTS.NAME :='Білоцерківський  районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=486;
l_DICT_DMSU_DEPTS.CODE :='3210';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 Білоцерківського  районного відділу Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=487;
l_DICT_DMSU_DEPTS.CODE :='3220';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 Білоцерківського  районного відділу Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=488;
l_DICT_DMSU_DEPTS.CODE :='3221';
l_DICT_DMSU_DEPTS.NAME :='Богуславський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=489;
l_DICT_DMSU_DEPTS.CODE :='3222';
l_DICT_DMSU_DEPTS.NAME :='Бориспільський районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=490;
l_DICT_DMSU_DEPTS.CODE :='3222';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Бориспільського районного відділу Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=491;
l_DICT_DMSU_DEPTS.CODE :='3223';
l_DICT_DMSU_DEPTS.NAME :='Бородянський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=492;
l_DICT_DMSU_DEPTS.CODE :='3213';
l_DICT_DMSU_DEPTS.NAME :='Броварський районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=493;
l_DICT_DMSU_DEPTS.CODE :='3213';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Броварського районного відділу Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=494;
l_DICT_DMSU_DEPTS.CODE :='3214';
l_DICT_DMSU_DEPTS.NAME :='Васильківський районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=495;
l_DICT_DMSU_DEPTS.CODE :='3228';
l_DICT_DMSU_DEPTS.NAME :='Вишгородський районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=496;
l_DICT_DMSU_DEPTS.CODE :='3227';
l_DICT_DMSU_DEPTS.NAME :='Володарський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=497;
l_DICT_DMSU_DEPTS.CODE :='3229';
l_DICT_DMSU_DEPTS.NAME :='Згурівський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=498;
l_DICT_DMSU_DEPTS.CODE :='3230';
l_DICT_DMSU_DEPTS.NAME :='Іванківський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=499;
l_DICT_DMSU_DEPTS.CODE :='3215';
l_DICT_DMSU_DEPTS.NAME :='Ірпінський міський відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=500;
l_DICT_DMSU_DEPTS.CODE :='3215';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Ірпінського міського відділу Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=501;
l_DICT_DMSU_DEPTS.CODE :='3231';
l_DICT_DMSU_DEPTS.NAME :='Кагарлицький районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=502;
l_DICT_DMSU_DEPTS.CODE :='3232';
l_DICT_DMSU_DEPTS.NAME :='Києво-Святошинський районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=503;
l_DICT_DMSU_DEPTS.CODE :='3236';
l_DICT_DMSU_DEPTS.NAME :='Макарівський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=504;
l_DICT_DMSU_DEPTS.CODE :='3237';
l_DICT_DMSU_DEPTS.NAME :='Миронівський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=505;
l_DICT_DMSU_DEPTS.CODE :='3238';
l_DICT_DMSU_DEPTS.NAME :='Обухівський районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=506;
l_DICT_DMSU_DEPTS.CODE :='3240';
l_DICT_DMSU_DEPTS.NAME :='Переяслав-Хмельницький районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=507;
l_DICT_DMSU_DEPTS.CODE :='3242';
l_DICT_DMSU_DEPTS.NAME :='Рокитнянський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=508;
l_DICT_DMSU_DEPTS.CODE :='3243';
l_DICT_DMSU_DEPTS.NAME :='Сквирський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=509;
l_DICT_DMSU_DEPTS.CODE :='3218';
l_DICT_DMSU_DEPTS.NAME :='Славутицький міський сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=510;
l_DICT_DMSU_DEPTS.CODE :='3244';
l_DICT_DMSU_DEPTS.NAME :='Ставищенський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=511;
l_DICT_DMSU_DEPTS.CODE :='3245';
l_DICT_DMSU_DEPTS.NAME :='Таращанський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=512;
l_DICT_DMSU_DEPTS.CODE :='3246';
l_DICT_DMSU_DEPTS.NAME :='Тетіївський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=513;
l_DICT_DMSU_DEPTS.CODE :='3247';
l_DICT_DMSU_DEPTS.NAME :='Фастівський районний відділ Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=514;
l_DICT_DMSU_DEPTS.CODE :='3248';
l_DICT_DMSU_DEPTS.NAME :='Яготинський районний сектор Управління Державної міграційної служби України в Київській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=515;
l_DICT_DMSU_DEPTS.CODE :='3277';
l_DICT_DMSU_DEPTS.NAME :='Пункт тимчасового розміщення біженців у місті Яготин Київської області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=516;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Березанській міській раді';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=517;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Білоцерківській міській раді';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=518;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Бориспільської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=519;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Броварської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=520;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бучанської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=521;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Васильківської міської ради            ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=522;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Ірпінської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=523;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Обухівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=524;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Переяслав-Хмельицької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=525;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  в місті Ржищеві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=526;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Славутицької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=527;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Фастівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=528;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Баришівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=529;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Білоцерківській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=530;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Богуславської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=531;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бориспільської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=532;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :=' Центр надання адміністративних послуг Бородянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=533;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Броварської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=534;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Васильківській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=535;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Вишгородської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=536;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Володарської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=537;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Згурівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=538;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Іванківській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=539;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кагарлицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=540;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Києво-Святошинській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=541;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Макарівській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=542;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Миронівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=543;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Обухівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=544;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр з надання адміністративних послуг Переяслав-Хмельницької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=545;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Поліської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=546;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Рокитнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=547;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Сквирської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=548;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ставищенської районної державної адміністрації     ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=549;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Таращанської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=550;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Тетіївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=551;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Фастівській  районній державній адміністрації                 ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=552;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Яготинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=553;
l_DICT_DMSU_DEPTS.CODE :='3501';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=554;
l_DICT_DMSU_DEPTS.CODE :='3501';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Кіровоградській  області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=555;
l_DICT_DMSU_DEPTS.CODE :='3588';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=556;
l_DICT_DMSU_DEPTS.CODE :='3512';
l_DICT_DMSU_DEPTS.NAME :='Олександрійський міський відділ Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=557;
l_DICT_DMSU_DEPTS.CODE :='3515';
l_DICT_DMSU_DEPTS.NAME :='Бобринецький районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=558;
l_DICT_DMSU_DEPTS.CODE :='3528';
l_DICT_DMSU_DEPTS.NAME :='Вільшанський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=559;
l_DICT_DMSU_DEPTS.CODE :='3516';
l_DICT_DMSU_DEPTS.NAME :='Гайворонський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=560;
l_DICT_DMSU_DEPTS.CODE :='3517';
l_DICT_DMSU_DEPTS.NAME :='Голованівський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=561;
l_DICT_DMSU_DEPTS.CODE :='3518';
l_DICT_DMSU_DEPTS.NAME :='Добровеличківський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=562;
l_DICT_DMSU_DEPTS.CODE :='3519';
l_DICT_DMSU_DEPTS.NAME :='Долинський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=563;
l_DICT_DMSU_DEPTS.CODE :='3520';
l_DICT_DMSU_DEPTS.NAME :='Знам‘янський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=564;
l_DICT_DMSU_DEPTS.CODE :='3521';
l_DICT_DMSU_DEPTS.NAME :='Кіровоградський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=565;
l_DICT_DMSU_DEPTS.CODE :='3510';
l_DICT_DMSU_DEPTS.NAME :='Фортечний районний відділ у м. Кропивницький Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=566;
l_DICT_DMSU_DEPTS.CODE :='3522';
l_DICT_DMSU_DEPTS.NAME :='Компаніївський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=567;
l_DICT_DMSU_DEPTS.CODE :='3511';
l_DICT_DMSU_DEPTS.NAME :='Подільський районний сектор у місті Кропивницькому Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=568;
l_DICT_DMSU_DEPTS.CODE :='3523';
l_DICT_DMSU_DEPTS.NAME :='Маловисківський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=569;
l_DICT_DMSU_DEPTS.CODE :='3524';
l_DICT_DMSU_DEPTS.NAME :='Новгородківський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=570;
l_DICT_DMSU_DEPTS.CODE :='3525';
l_DICT_DMSU_DEPTS.NAME :='Новоархангельський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=571;
l_DICT_DMSU_DEPTS.CODE :='3526';
l_DICT_DMSU_DEPTS.NAME :='Новомиргородський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=572;
l_DICT_DMSU_DEPTS.CODE :='3527';
l_DICT_DMSU_DEPTS.NAME :='Новоукраїнський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=573;
l_DICT_DMSU_DEPTS.CODE :='3514';
l_DICT_DMSU_DEPTS.NAME :='Олександрівський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=574;
l_DICT_DMSU_DEPTS.CODE :='3513';
l_DICT_DMSU_DEPTS.NAME :='Олександрійський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=575;
l_DICT_DMSU_DEPTS.CODE :='3529';
l_DICT_DMSU_DEPTS.NAME :='Онуфріївський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=576;
l_DICT_DMSU_DEPTS.CODE :='3530';
l_DICT_DMSU_DEPTS.NAME :='Петрівський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=577;
l_DICT_DMSU_DEPTS.CODE :='3531';
l_DICT_DMSU_DEPTS.NAME :='Світловодський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=578;
l_DICT_DMSU_DEPTS.CODE :='3532';
l_DICT_DMSU_DEPTS.NAME :='Благовіщенський  районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=579;
l_DICT_DMSU_DEPTS.CODE :='3533';
l_DICT_DMSU_DEPTS.NAME :='Устинівський районний сектор Управління Державної міграційної служби України в Кіровоградській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=580;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кропивницької (Кіровоградської) міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=581;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Знам’янської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=582;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Олександрійської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=583;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Світловодської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=584;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бобринецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=585;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Вільшанської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=586;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Гайворонської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=587;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Голованівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=588;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Добровеличківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=589;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Долинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=590;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Знам’янської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=591;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кропивницької (Кіровоградської) районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=592;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Компаніївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=593;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Маловисківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=594;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новгородківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=595;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новоархангельскої районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=596;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новомиргородської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=597;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новоукраїнської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=598;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Олександрівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=599;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Олександрійської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=600;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Онуфріївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=601;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Петрівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=602;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Світловодської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=603;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Благовіщенської (Ульяновської) районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=604;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Устинівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=605;
l_DICT_DMSU_DEPTS.CODE :='4401';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=606;
l_DICT_DMSU_DEPTS.CODE :='4488';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в  Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=607;
l_DICT_DMSU_DEPTS.CODE :='4444';
l_DICT_DMSU_DEPTS.NAME :='Біловодський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=608;
l_DICT_DMSU_DEPTS.CODE :='4445';
l_DICT_DMSU_DEPTS.NAME :='Білокуракинський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=609;
l_DICT_DMSU_DEPTS.CODE :='4447';
l_DICT_DMSU_DEPTS.NAME :='Кремінський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=610;
l_DICT_DMSU_DEPTS.CODE :='4430';
l_DICT_DMSU_DEPTS.NAME :='Лисичанський міський відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=611;
l_DICT_DMSU_DEPTS.CODE :='4449';
l_DICT_DMSU_DEPTS.NAME :='Марківський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=612;
l_DICT_DMSU_DEPTS.CODE :='4450';
l_DICT_DMSU_DEPTS.NAME :='Міловський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=613;
l_DICT_DMSU_DEPTS.CODE :='4451';
l_DICT_DMSU_DEPTS.NAME :='Новоайдарський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=614;
l_DICT_DMSU_DEPTS.CODE :='4452';
l_DICT_DMSU_DEPTS.NAME :='Новопсковський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=615;
l_DICT_DMSU_DEPTS.CODE :='4454';
l_DICT_DMSU_DEPTS.NAME :='Попаснянський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=616;
l_DICT_DMSU_DEPTS.CODE :='4436';
l_DICT_DMSU_DEPTS.NAME :='Рубіжанський міський відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=617;
l_DICT_DMSU_DEPTS.CODE :='4455';
l_DICT_DMSU_DEPTS.NAME :='Сватівський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=618;
l_DICT_DMSU_DEPTS.CODE :='4439';
l_DICT_DMSU_DEPTS.NAME :='Сєвєродонецький міський відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=619;
l_DICT_DMSU_DEPTS.CODE :='4457';
l_DICT_DMSU_DEPTS.NAME :='Станично-Луганський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=620;
l_DICT_DMSU_DEPTS.CODE :='4458';
l_DICT_DMSU_DEPTS.NAME :='Старобільський районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=621;
l_DICT_DMSU_DEPTS.CODE :='4458';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Старобільського районного відділу Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=622;
l_DICT_DMSU_DEPTS.CODE :='4459';
l_DICT_DMSU_DEPTS.NAME :='Троїцький районний відділ Управління Державної міграційної служби України в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=623;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Лисичанської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=624;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг загального відділу Рубіжанської міської ради Луганської області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=625;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ адміністративних послуг Сєвєродонецької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=626;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Біловодської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=627;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Білокуракинської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=628;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кремінської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=629;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг Марківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=630;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ з питань надання адміністративних послуг Міловської районної державної адміністрації Луганської області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=631;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор "Центр надання адміністративних послуг" Новоайдарської районної державної адміністрації Луганської області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=632;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Новопсковській районній державній адміністрації в Луганській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=633;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Попаснянській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=634;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Сватівській районній державній адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=635;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг в Станично-Луганському районі ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=636;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Старобільської районної державної адміністрації
';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=637;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Троїцькій районній державній адміністрації   ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=638;
l_DICT_DMSU_DEPTS.CODE :='4601';
l_DICT_DMSU_DEPTS.NAME :='Головне управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=639;
l_DICT_DMSU_DEPTS.CODE :='4601';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=640;
l_DICT_DMSU_DEPTS.CODE :='4690';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 2 Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=641;
l_DICT_DMSU_DEPTS.CODE :='4601';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 1 Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=642;
l_DICT_DMSU_DEPTS.CODE :='4601';
l_DICT_DMSU_DEPTS.NAME :='Відділ з питань тимчасового та постійного проживання іноземців та осіб без громадянства Управління у справах іноземців та осіб без громадянства Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=643;
l_DICT_DMSU_DEPTS.CODE :='4602';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=644;
l_DICT_DMSU_DEPTS.CODE :='4602';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=645;
l_DICT_DMSU_DEPTS.CODE :='4688';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання  Управління з питань ідентифікації та паспортизації  Головного Управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=646;
l_DICT_DMSU_DEPTS.CODE :='4616';
l_DICT_DMSU_DEPTS.NAME :='Бориславський міський сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=647;
l_DICT_DMSU_DEPTS.CODE :='4620';
l_DICT_DMSU_DEPTS.NAME :='Бродівський районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=648;
l_DICT_DMSU_DEPTS.CODE :='4621';
l_DICT_DMSU_DEPTS.NAME :='Буський районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=649;
l_DICT_DMSU_DEPTS.CODE :='4611';
l_DICT_DMSU_DEPTS.NAME :='Галицький районний відділ у місті Львові Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=650;
l_DICT_DMSU_DEPTS.CODE :='4622';
l_DICT_DMSU_DEPTS.NAME :='Городоцький районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=651;
l_DICT_DMSU_DEPTS.CODE :='4623';
l_DICT_DMSU_DEPTS.NAME :='Дрогобицький міський відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=652;
l_DICT_DMSU_DEPTS.CODE :='4623';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Дрогобицького міського відділу Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=653;
l_DICT_DMSU_DEPTS.CODE :='4624';
l_DICT_DMSU_DEPTS.NAME :='Жидачівський міській сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=654;
l_DICT_DMSU_DEPTS.CODE :='4628';
l_DICT_DMSU_DEPTS.NAME :='Жовківський районний відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=655;
l_DICT_DMSU_DEPTS.CODE :='4610';
l_DICT_DMSU_DEPTS.NAME :='Залізничний районний відділ у місті Львові Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=656;
l_DICT_DMSU_DEPTS.CODE :='4625';
l_DICT_DMSU_DEPTS.NAME :='Золочівський районний відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=657;
l_DICT_DMSU_DEPTS.CODE :='4626';
l_DICT_DMSU_DEPTS.NAME :='Кам''янка-Бузький районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=658;
l_DICT_DMSU_DEPTS.CODE :='4614';
l_DICT_DMSU_DEPTS.NAME :='Личаківський районний відділ у місті Львові Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=659;
l_DICT_DMSU_DEPTS.CODE :='4629';
l_DICT_DMSU_DEPTS.NAME :='Миколаївський районний відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=660;
l_DICT_DMSU_DEPTS.CODE :='4627';
l_DICT_DMSU_DEPTS.NAME :='Мостиський районний відділ  Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=661;
l_DICT_DMSU_DEPTS.CODE :='4631';
l_DICT_DMSU_DEPTS.NAME :='Перемишлянський районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=662;
l_DICT_DMSU_DEPTS.CODE :='4632';
l_DICT_DMSU_DEPTS.NAME :='Пустомитівський районний відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=663;
l_DICT_DMSU_DEPTS.CODE :='4633';
l_DICT_DMSU_DEPTS.NAME :='Радехівський районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=664;
l_DICT_DMSU_DEPTS.CODE :='4634';
l_DICT_DMSU_DEPTS.NAME :='Самбірський міський відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=665;
l_DICT_DMSU_DEPTS.CODE :='4612';
l_DICT_DMSU_DEPTS.NAME :='Сихівський районний відділ у місті Львові Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=666;
l_DICT_DMSU_DEPTS.CODE :='4635';
l_DICT_DMSU_DEPTS.NAME :='Сколівський районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=667;
l_DICT_DMSU_DEPTS.CODE :='4636';
l_DICT_DMSU_DEPTS.NAME :='Сокальський районний відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=668;
l_DICT_DMSU_DEPTS.CODE :='4637';
l_DICT_DMSU_DEPTS.NAME :='Старосамбірський районний сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=669;
l_DICT_DMSU_DEPTS.CODE :='4638';
l_DICT_DMSU_DEPTS.NAME :='Стрийський міський відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=670;
l_DICT_DMSU_DEPTS.CODE :='4618';
l_DICT_DMSU_DEPTS.NAME :='Трускавецький міський сектор Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=671;
l_DICT_DMSU_DEPTS.CODE :='4640';
l_DICT_DMSU_DEPTS.NAME :='Турківський районний відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=672;
l_DICT_DMSU_DEPTS.CODE :='4613';
l_DICT_DMSU_DEPTS.NAME :='Франківський районний відділ у місті Львові Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=673;
l_DICT_DMSU_DEPTS.CODE :='4619';
l_DICT_DMSU_DEPTS.NAME :='Червоноградський міський відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=674;
l_DICT_DMSU_DEPTS.CODE :='4615';
l_DICT_DMSU_DEPTS.NAME :='Шевченківський районний відділ у місті Львові Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=675;
l_DICT_DMSU_DEPTS.CODE :='4641';
l_DICT_DMSU_DEPTS.NAME :='Яворівський районнний відділ Головного управління Державної міграційної служби України у Львівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=676;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адмінстративних послуг смт. Винники';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=677;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Львова ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=678;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Галицькому районі          ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=679;
l_DICT_DMSU_DEPTS.CODE :='4615';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Шевченківському районі ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=680;
l_DICT_DMSU_DEPTS.CODE :='4613';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Франківському районі     ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=681;
l_DICT_DMSU_DEPTS.CODE :='4614';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Личаківському районі     ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=682;
l_DICT_DMSU_DEPTS.CODE :='4610';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Залізничному районі       ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=683;
l_DICT_DMSU_DEPTS.CODE :='4612';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Сихівському районі         ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=684;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бориславської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=685;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Дрогобицької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=686;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Моршинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=687;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ Центр надання адміністративних послуг Новороздільської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=688;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Стрийської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=689;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Самбірської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=690;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Трускавецької міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=691;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Червоноградської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=692;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ходорівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=693;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бродівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=694;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Буської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=695;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Городоцькій районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=696;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Дрогобицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=697;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Жидачівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=698;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Жовківській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=699;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Золочівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=700;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кам’янка-Бузької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=701;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Миколаївського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=702;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Мостиській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=703;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Перемишлянській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=704;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Пустомитівській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=705;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Радехівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=706;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Самбірської районної державної адміністрації       ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=707;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Сколівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=708;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Сокальської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=709;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Старосамбірській районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=710;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центтр надання адміністративних послуг при Стрийській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=711;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр падання адміністративних послуг Турківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=712;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Яворівській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=713;
l_DICT_DMSU_DEPTS.CODE :='4801';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=714;
l_DICT_DMSU_DEPTS.CODE :='4801
';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=715;
l_DICT_DMSU_DEPTS.CODE :='4803';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=716;
l_DICT_DMSU_DEPTS.CODE :='4803';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=717;
l_DICT_DMSU_DEPTS.CODE :='4888';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=718;
l_DICT_DMSU_DEPTS.CODE :='4816';
l_DICT_DMSU_DEPTS.NAME :='Арбузинський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=719;
l_DICT_DMSU_DEPTS.CODE :='4817';
l_DICT_DMSU_DEPTS.NAME :='Баштанський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=720;
l_DICT_DMSU_DEPTS.CODE :='4818';
l_DICT_DMSU_DEPTS.NAME :='Березанський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=721;
l_DICT_DMSU_DEPTS.CODE :='4819';
l_DICT_DMSU_DEPTS.NAME :='Березнегуватський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=722;
l_DICT_DMSU_DEPTS.CODE :='4820';
l_DICT_DMSU_DEPTS.NAME :='Братський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=723;
l_DICT_DMSU_DEPTS.CODE :='4821';
l_DICT_DMSU_DEPTS.NAME :='Веселинівський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=724;
l_DICT_DMSU_DEPTS.CODE :='4822';
l_DICT_DMSU_DEPTS.NAME :='Вознесенський районний відділ Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=725;
l_DICT_DMSU_DEPTS.CODE :='4823';
l_DICT_DMSU_DEPTS.NAME :='Врадіївський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=726;
l_DICT_DMSU_DEPTS.CODE :='4824';
l_DICT_DMSU_DEPTS.NAME :='Доманівський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=727;
l_DICT_DMSU_DEPTS.CODE :='4825';
l_DICT_DMSU_DEPTS.NAME :='Єланецький районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=728;
l_DICT_DMSU_DEPTS.CODE :='4826';
l_DICT_DMSU_DEPTS.NAME :='Вітовський (Жовтневий) районний відділ Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=729;
l_DICT_DMSU_DEPTS.CODE :='4810';
l_DICT_DMSU_DEPTS.NAME :='Заводський районний відділ у місті Миколаєві Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=730;
l_DICT_DMSU_DEPTS.CODE :='4810';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Заводського районного відділу у місті Миколаєві Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=731;
l_DICT_DMSU_DEPTS.CODE :='4827';
l_DICT_DMSU_DEPTS.NAME :='Казанківський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=732;
l_DICT_DMSU_DEPTS.CODE :='4811';
l_DICT_DMSU_DEPTS.NAME :='Корабельний районний відділ у місті Миколаєві Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=733;
l_DICT_DMSU_DEPTS.CODE :='4828';
l_DICT_DMSU_DEPTS.NAME :='Кривоозерський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=734;
l_DICT_DMSU_DEPTS.CODE :='4812';
l_DICT_DMSU_DEPTS.NAME :='Інгульський (Ленінський) районний відділ у місті Миколаєві Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=735;
l_DICT_DMSU_DEPTS.CODE :='4812';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Інгульського (Ленінського) районного відділу у місті Миколаєві Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=736;
l_DICT_DMSU_DEPTS.CODE :='4829';
l_DICT_DMSU_DEPTS.NAME :='Миколаївський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=737;
l_DICT_DMSU_DEPTS.CODE :='4830';
l_DICT_DMSU_DEPTS.NAME :='Новобузький районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=738;
l_DICT_DMSU_DEPTS.CODE :='4831';
l_DICT_DMSU_DEPTS.NAME :='Новоодеський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=739;
l_DICT_DMSU_DEPTS.CODE :='4832';
l_DICT_DMSU_DEPTS.NAME :='Очаківський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=740;
l_DICT_DMSU_DEPTS.CODE :='4814';
l_DICT_DMSU_DEPTS.NAME :='Первомайський районний відділ Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=741;
l_DICT_DMSU_DEPTS.CODE :='4834';
l_DICT_DMSU_DEPTS.NAME :='Снігурівський районний сектор Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=742;
l_DICT_DMSU_DEPTS.CODE :='4813';
l_DICT_DMSU_DEPTS.NAME :='Центральний районний відділ у місті Миколаєві Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=743;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Центрального районного відділу у місті Миколаєві Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=744;
l_DICT_DMSU_DEPTS.CODE :='4815';
l_DICT_DMSU_DEPTS.NAME :='Южноукраїнський районний відділ Управління Державної міграційної служби України в Миколаївській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=745;
l_DICT_DMSU_DEPTS.CODE :='4877';
l_DICT_DMSU_DEPTS.NAME :='Державна установа "Миколаївській пункт тимчасового перебування іноземців та осіб без громадянства, які незаконно перебувають в Україні, ДМС"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=746;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Миколаївської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=747;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у м. Вознесенську Вознесенської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=748;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Очаківської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=749;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг апарату виконавчого комітету Первомайської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=750;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг міста Южноукраїнська';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=751;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Арбузинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=752;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при  Баштанській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=753;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Березанській районній  державній  адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=754;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Березнегуватської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=755;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Братській районній  державній  адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=756;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Веселинівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=757;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Вознесенської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=758;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Врадіївському районі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=759;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Доманівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=760;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Єланецької  районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=761;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Жовтневої районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=762;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Казанківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=763;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кривоозерського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=764;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Миколаївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=765;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Новобузькій районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=766;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новоодеської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=767;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Очаківській районній  державній  адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=768;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Первомайської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:06','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=769;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Снігурівської  районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=770;
l_DICT_DMSU_DEPTS.CODE :='5101';
l_DICT_DMSU_DEPTS.NAME :='Головне управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=771;
l_DICT_DMSU_DEPTS.CODE :='5101';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України в Одеській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=772;
l_DICT_DMSU_DEPTS.CODE :='5102';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України в Одеській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=773;
l_DICT_DMSU_DEPTS.CODE :='5101';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів Управління з питань громадянства, паспортизації та реєстрації Головного управління Державної міграційної служби України в Одеській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=774;
l_DICT_DMSU_DEPTS.CODE :='5101';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=775;
l_DICT_DMSU_DEPTS.CODE :='5188';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання  Управління з питань громадянства, паспортизації та реєстрації Головне Управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=776;
l_DICT_DMSU_DEPTS.CODE :='5123';
l_DICT_DMSU_DEPTS.NAME :='Ананьївський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=777;
l_DICT_DMSU_DEPTS.CODE :='5124';
l_DICT_DMSU_DEPTS.NAME :='Арцизький районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=778;
l_DICT_DMSU_DEPTS.CODE :='5125';
l_DICT_DMSU_DEPTS.NAME :='Балтський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=779;
l_DICT_DMSU_DEPTS.CODE :='5128';
l_DICT_DMSU_DEPTS.NAME :='Березівський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=780;
l_DICT_DMSU_DEPTS.CODE :='5118';
l_DICT_DMSU_DEPTS.NAME :='Білгород-Дністровський районний відділ Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=781;
l_DICT_DMSU_DEPTS.CODE :='5118';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Білгород-Дністровського районного відділу Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=782;
l_DICT_DMSU_DEPTS.CODE :='5127';
l_DICT_DMSU_DEPTS.NAME :='Біляївський районний відділ Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=783;
l_DICT_DMSU_DEPTS.CODE :='5129';
l_DICT_DMSU_DEPTS.NAME :='Болградський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=784;
l_DICT_DMSU_DEPTS.CODE :='5130';
l_DICT_DMSU_DEPTS.NAME :='Великомихайлівський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=785;
l_DICT_DMSU_DEPTS.CODE :='5131';
l_DICT_DMSU_DEPTS.NAME :='Іванівський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=786;
l_DICT_DMSU_DEPTS.CODE :='5119';
l_DICT_DMSU_DEPTS.NAME :='Ізмаїльський районний відділ Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=787;
l_DICT_DMSU_DEPTS.CODE :='5119';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Ізмаїльського районного відділу Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=788;
l_DICT_DMSU_DEPTS.CODE :='5119';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=789;
l_DICT_DMSU_DEPTS.CODE :='5120';
l_DICT_DMSU_DEPTS.NAME :='Чорноморський (Іллічівський) міський відділ Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=790;
l_DICT_DMSU_DEPTS.CODE :='5112';
l_DICT_DMSU_DEPTS.NAME :='Київський районний відділ у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=791;
l_DICT_DMSU_DEPTS.CODE :='5112';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 Київського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=792;
l_DICT_DMSU_DEPTS.CODE :='5112';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 Київського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=793;
l_DICT_DMSU_DEPTS.CODE :='5133';
l_DICT_DMSU_DEPTS.NAME :='Кілійський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=794;
l_DICT_DMSU_DEPTS.CODE :='5134';
l_DICT_DMSU_DEPTS.NAME :='Кодимський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=795;
l_DICT_DMSU_DEPTS.CODE :='5135';
l_DICT_DMSU_DEPTS.NAME :='Лиманський (Комінтернівський) районний відділ Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=796;
l_DICT_DMSU_DEPTS.CODE :='5136';
l_DICT_DMSU_DEPTS.NAME :='Подільський (Котовський районний) відділ Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=797;
l_DICT_DMSU_DEPTS.CODE :='5137';
l_DICT_DMSU_DEPTS.NAME :='Окнянський (Красноокнянський) районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=798;
l_DICT_DMSU_DEPTS.CODE :='5138';
l_DICT_DMSU_DEPTS.NAME :='Любашівський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=799;
l_DICT_DMSU_DEPTS.CODE :='5114';
l_DICT_DMSU_DEPTS.NAME :='Малиновський районний відділ у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=800;
l_DICT_DMSU_DEPTS.CODE :='5114';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 Малиновського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=801;
l_DICT_DMSU_DEPTS.CODE :='5114';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 Малиновського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=802;
l_DICT_DMSU_DEPTS.CODE :='5139';
l_DICT_DMSU_DEPTS.NAME :='Миколаївський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=803;
l_DICT_DMSU_DEPTS.CODE :='5140';
l_DICT_DMSU_DEPTS.NAME :='Овідіопольський районний відділ Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=804;
l_DICT_DMSU_DEPTS.CODE :='5115';
l_DICT_DMSU_DEPTS.NAME :='Приморський районний відділ у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=805;
l_DICT_DMSU_DEPTS.CODE :='5115';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 Приморського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=806;
l_DICT_DMSU_DEPTS.CODE :='5115';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 Приморського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=807;
l_DICT_DMSU_DEPTS.CODE :='5142';
l_DICT_DMSU_DEPTS.NAME :='Ренійський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=808;
l_DICT_DMSU_DEPTS.CODE :='5141';
l_DICT_DMSU_DEPTS.NAME :='Роздільнянський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=809;
l_DICT_DMSU_DEPTS.CODE :='5143';
l_DICT_DMSU_DEPTS.NAME :='Савранський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=810;
l_DICT_DMSU_DEPTS.CODE :='5144';
l_DICT_DMSU_DEPTS.NAME :='Саратський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=811;
l_DICT_DMSU_DEPTS.CODE :='5116';
l_DICT_DMSU_DEPTS.NAME :='Суворовський районний відділ у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=812;
l_DICT_DMSU_DEPTS.CODE :='5116';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 Суворовського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=813;
l_DICT_DMSU_DEPTS.CODE :='5116';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 Суворовського районного відділу у місті Одесі Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=814;
l_DICT_DMSU_DEPTS.CODE :='5145';
l_DICT_DMSU_DEPTS.NAME :='Тарутинський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=815;
l_DICT_DMSU_DEPTS.CODE :='5146';
l_DICT_DMSU_DEPTS.NAME :='Татарбунарський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=816;
l_DICT_DMSU_DEPTS.CODE :='5121';
l_DICT_DMSU_DEPTS.NAME :='Теплодарський міський сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=817;
l_DICT_DMSU_DEPTS.CODE :='5147';
l_DICT_DMSU_DEPTS.NAME :='Захарівський (Фрунзівський) районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=818;
l_DICT_DMSU_DEPTS.CODE :='5148';
l_DICT_DMSU_DEPTS.NAME :='Ширяївський районний сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=819;
l_DICT_DMSU_DEPTS.CODE :='5122';
l_DICT_DMSU_DEPTS.NAME :='Южненський міський сектор Головного управління Державної міграційної служби України в Одеській області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=820;
l_DICT_DMSU_DEPTS.CODE :='5177';
l_DICT_DMSU_DEPTS.NAME :='Пункт тимчасового розміщення біженців у місті  Одеса';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=821;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Департамент надання адміністративних послуг Одеської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=822;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Приморського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=823;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Суворовського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=824;
l_DICT_DMSU_DEPTS.CODE :='5112';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Київського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=825;
l_DICT_DMSU_DEPTS.CODE :='5114';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Малиновського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=826;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Білгород-Дністровської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=827;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ізмаїльської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=828;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Чорноморської (Іллічівської) міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=829;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Подільської (Котовської) міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=830;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при виконавчому комітеті Теплодарської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=831;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Виконавчого комітету Южненської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=832;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ананьївської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=833;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Арцизької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=834;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Балтської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=835;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Березівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=836;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Біляївській районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=837;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр адміністративних послуг Болградської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=838;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Великомихайлівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=839;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Іванівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=840;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ надання адміністративних послуг Кілійської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=841;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кодимської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=842;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кодинцевської (Комінтернівської районної) державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=843;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Красноокнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=844;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Любашівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=845;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Миколаївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=846;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Овідіопольської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=847;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ренійської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=848;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Роздільнянської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=849;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Савранської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=850;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Саратської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=851;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Тарутинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=852;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Татарбунарської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=853;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Захарівської (Фрунзівськой) районної державної адміністрації Одеської області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=854;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ надання адміністративних послуг Ширяївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=855;
l_DICT_DMSU_DEPTS.CODE :='5301';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=856;
l_DICT_DMSU_DEPTS.CODE :='5301';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=857;
l_DICT_DMSU_DEPTS.CODE :='5388';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Полтавській  області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=858;
l_DICT_DMSU_DEPTS.CODE :='5316';
l_DICT_DMSU_DEPTS.NAME :='Автозаводський районний відділ у місті Кременчуці Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=859;
l_DICT_DMSU_DEPTS.CODE :='5316';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Автозаводського районного відділу у місті Кременчуці Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=860;
l_DICT_DMSU_DEPTS.CODE :='5317';
l_DICT_DMSU_DEPTS.NAME :='Крюківський районний відділ у місті Кременчуці Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=861;
l_DICT_DMSU_DEPTS.CODE :='5318';
l_DICT_DMSU_DEPTS.NAME :='Великобагачанський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=862;
l_DICT_DMSU_DEPTS.CODE :='5319';
l_DICT_DMSU_DEPTS.NAME :='Гадяцький районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=863;
l_DICT_DMSU_DEPTS.CODE :='5320';
l_DICT_DMSU_DEPTS.NAME :='Глобинський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=864;
l_DICT_DMSU_DEPTS.CODE :='5321';
l_DICT_DMSU_DEPTS.NAME :='Гребінківський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=865;
l_DICT_DMSU_DEPTS.CODE :='5322';
l_DICT_DMSU_DEPTS.NAME :='Диканський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=866;
l_DICT_DMSU_DEPTS.CODE :='5323';
l_DICT_DMSU_DEPTS.NAME :='Зіньківський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=867;
l_DICT_DMSU_DEPTS.CODE :='5324';
l_DICT_DMSU_DEPTS.NAME :='Карлівський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=868;
l_DICT_DMSU_DEPTS.CODE :='5325';
l_DICT_DMSU_DEPTS.NAME :='Кобеляцький районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=869;
l_DICT_DMSU_DEPTS.CODE :='5326';
l_DICT_DMSU_DEPTS.NAME :='Козельщинський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=870;
l_DICT_DMSU_DEPTS.CODE :='5327';
l_DICT_DMSU_DEPTS.NAME :='Котелевський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=871;
l_DICT_DMSU_DEPTS.CODE :='5328';
l_DICT_DMSU_DEPTS.NAME :='Кременчуцький районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=872;
l_DICT_DMSU_DEPTS.CODE :='5329';
l_DICT_DMSU_DEPTS.NAME :='Лохвицький районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=873;
l_DICT_DMSU_DEPTS.CODE :='5330';
l_DICT_DMSU_DEPTS.NAME :='Лубенський міськрайонний відділ Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=874;
l_DICT_DMSU_DEPTS.CODE :='5331';
l_DICT_DMSU_DEPTS.NAME :='Машівський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=875;
l_DICT_DMSU_DEPTS.CODE :='5332';
l_DICT_DMSU_DEPTS.NAME :='Миргородський міськрайонний відділ Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=876;
l_DICT_DMSU_DEPTS.CODE :='5333';
l_DICT_DMSU_DEPTS.NAME :='Новосанжарський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=877;
l_DICT_DMSU_DEPTS.CODE :='5334';
l_DICT_DMSU_DEPTS.NAME :='Оржицький районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=878;
l_DICT_DMSU_DEPTS.CODE :='5335';
l_DICT_DMSU_DEPTS.NAME :='Пирятинський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=879;
l_DICT_DMSU_DEPTS.CODE :='5336';
l_DICT_DMSU_DEPTS.NAME :='Полтавський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=880;
l_DICT_DMSU_DEPTS.CODE :='5337';
l_DICT_DMSU_DEPTS.NAME :='Решетилівський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=881;
l_DICT_DMSU_DEPTS.CODE :='5338';
l_DICT_DMSU_DEPTS.NAME :='Семенівський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=882;
l_DICT_DMSU_DEPTS.CODE :='5339';
l_DICT_DMSU_DEPTS.NAME :='Хорольський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=883;
l_DICT_DMSU_DEPTS.CODE :='5340';
l_DICT_DMSU_DEPTS.NAME :='Чорнухинський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=884;
l_DICT_DMSU_DEPTS.CODE :='5341';
l_DICT_DMSU_DEPTS.NAME :='Чутівський районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=885;
l_DICT_DMSU_DEPTS.CODE :='5342';
l_DICT_DMSU_DEPTS.NAME :='Шишацький районний сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=886;
l_DICT_DMSU_DEPTS.CODE :='5313';
l_DICT_DMSU_DEPTS.NAME :='Горішньоплавнівський (Комсомольський) міський сектор Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=887;
l_DICT_DMSU_DEPTS.CODE :='5310';
l_DICT_DMSU_DEPTS.NAME :='Київський районний відділ у місті Полтаві Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=888;
l_DICT_DMSU_DEPTS.CODE :='5312';
l_DICT_DMSU_DEPTS.NAME :='Шевченківській (Октябрський) районний відділ у місті Полтаві Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=889;
l_DICT_DMSU_DEPTS.CODE :='5311';
l_DICT_DMSU_DEPTS.NAME :='Подільській (Ленінський) районний сектор у місті Полтаві Управління Державної міграційної служби України в Полтавській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=890;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  виконавчого комітету Полтавської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=891;
l_DICT_DMSU_DEPTS.CODE :='5316';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  виконавчого комітету Кременчуцької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=892;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  виконавчого комітету Комсомольської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=893;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  виконавчого комітету Миргородської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=894;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  виконавчого комітету Лубенської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=895;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Великобагачанської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=896;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Гадяцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=897;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Глобинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=898;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Гребінківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=899;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Диканської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=900;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Зіньківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=901;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Карлівської  районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=902;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Кобеляцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=903;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Козельщинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=904;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Котелевської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=905;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Кременчуцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=906;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Лохвицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=907;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Лубенської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=908;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Машівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=909;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Миргородської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=910;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Новосанжарської  районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=911;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Оржицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=912;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Пирятинської  районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=913;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Полтавської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=914;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Решетилівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=915;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Семенівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=916;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Хорольської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=917;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Чорнухинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=918;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Чутівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=919;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Шишацької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=920;
l_DICT_DMSU_DEPTS.CODE :='5601';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=921;
l_DICT_DMSU_DEPTS.CODE :='5601';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  відділу з питань громадянства, паспортизації та реєстрації  Управління Державної міграційної служби України в Рівненьскій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=922;
l_DICT_DMSU_DEPTS.CODE :='5688';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Рівненській  області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=923;
l_DICT_DMSU_DEPTS.CODE :='5612';
l_DICT_DMSU_DEPTS.NAME :='Березнівський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=924;
l_DICT_DMSU_DEPTS.CODE :='5613';
l_DICT_DMSU_DEPTS.NAME :='Володимирецький районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=925;
l_DICT_DMSU_DEPTS.CODE :='5614';
l_DICT_DMSU_DEPTS.NAME :='Гощанський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=926;
l_DICT_DMSU_DEPTS.CODE :='5615';
l_DICT_DMSU_DEPTS.NAME :='Демидівський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=927;
l_DICT_DMSU_DEPTS.CODE :='5616';
l_DICT_DMSU_DEPTS.NAME :='Дубенський районний відділ Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=928;
l_DICT_DMSU_DEPTS.CODE :='5617';
l_DICT_DMSU_DEPTS.NAME :='Дубровицький районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=929;
l_DICT_DMSU_DEPTS.CODE :='5618';
l_DICT_DMSU_DEPTS.NAME :='Зарічненський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=930;
l_DICT_DMSU_DEPTS.CODE :='5619';
l_DICT_DMSU_DEPTS.NAME :='Здолбунівський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=931;
l_DICT_DMSU_DEPTS.CODE :='5620';
l_DICT_DMSU_DEPTS.NAME :='Корецький районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=932;
l_DICT_DMSU_DEPTS.CODE :='5621';
l_DICT_DMSU_DEPTS.NAME :='Костопільський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=933;
l_DICT_DMSU_DEPTS.CODE :='5611';
l_DICT_DMSU_DEPTS.NAME :='Варашський (Кузнецовський) міський сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=934;
l_DICT_DMSU_DEPTS.CODE :='5622';
l_DICT_DMSU_DEPTS.NAME :='Млинівський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=935;
l_DICT_DMSU_DEPTS.CODE :='5623';
l_DICT_DMSU_DEPTS.NAME :='Острозький районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=936;
l_DICT_DMSU_DEPTS.CODE :='5627';
l_DICT_DMSU_DEPTS.NAME :='Радивилівський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=937;
l_DICT_DMSU_DEPTS.CODE :='5610';
l_DICT_DMSU_DEPTS.NAME :='Рівненський міський відділ Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=938;
l_DICT_DMSU_DEPTS.CODE :='5610';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Рівненського міського відділу Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=939;
l_DICT_DMSU_DEPTS.CODE :='5610';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=940;
l_DICT_DMSU_DEPTS.CODE :='5624';
l_DICT_DMSU_DEPTS.NAME :='Рівненський районний відділ Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=941;
l_DICT_DMSU_DEPTS.CODE :='5625';
l_DICT_DMSU_DEPTS.NAME :='Рокитнівський районний сектор Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=942;
l_DICT_DMSU_DEPTS.CODE :='5626';
l_DICT_DMSU_DEPTS.NAME :='Сарненський районний відділ Управління Державної міграційної служби України в Рівненській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=943;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  у місті Рівному Рівненської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=944;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ "Центр надання адміністративних послуг" Дубенської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=945;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Варашської (Кузнецовської) міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=946;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Острозької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=947;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор "Центр надання адміністративних послуг"  Березнівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=948;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Володимирецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=949;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор “Центр надання адміністративних послуг”  Гощанської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=950;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор "Центр надання адміністративних послуг" Демидівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=951;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ надання адміністративних послуг  Дубенської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=952;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Дубровицької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=953;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Зарічненської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=954;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Здолбунівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=955;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Корецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=956;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор (центр) надання адміністративних послуг Костопільської  районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=957;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Млинівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=958;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор "Центр  надання адміністративних послуг" Острозької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=959;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор (цент) надання адміністративних послуг Радивилівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=960;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр (відділ) надання адміністративних послуг Рівненської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=961;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор “Центр надання адміністративних послуг” Рокитнівської  районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=962;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор з обслуговування Центру надання адміністративних послуг Сарненської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=963;
l_DICT_DMSU_DEPTS.CODE :='5901';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=964;
l_DICT_DMSU_DEPTS.CODE :='5901';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=965;
l_DICT_DMSU_DEPTS.CODE :='5901';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=966;
l_DICT_DMSU_DEPTS.CODE :='5988';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Сумській  області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=967;
l_DICT_DMSU_DEPTS.CODE :='5913';
l_DICT_DMSU_DEPTS.NAME :='Білопільський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=968;
l_DICT_DMSU_DEPTS.CODE :='5914';
l_DICT_DMSU_DEPTS.NAME :='Буринський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=969;
l_DICT_DMSU_DEPTS.CODE :='5915';
l_DICT_DMSU_DEPTS.NAME :='Великописарівський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=970;
l_DICT_DMSU_DEPTS.CODE :='5916';
l_DICT_DMSU_DEPTS.NAME :='Глухівський міський сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=971;
l_DICT_DMSU_DEPTS.CODE :='5910';
l_DICT_DMSU_DEPTS.NAME :='Зарічний районний відділ у місті Суми Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=972;
l_DICT_DMSU_DEPTS.CODE :='5911';
l_DICT_DMSU_DEPTS.NAME :='Ковпаківський районний відділ у місті Суми Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=973;
l_DICT_DMSU_DEPTS.CODE :='5911';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  Ковпаківського районного відділу у місті Суми Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=974;
l_DICT_DMSU_DEPTS.CODE :='5917';
l_DICT_DMSU_DEPTS.NAME :='Конотопський міський відділ Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=975;
l_DICT_DMSU_DEPTS.CODE :='5918';
l_DICT_DMSU_DEPTS.NAME :='Краснопільський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=976;
l_DICT_DMSU_DEPTS.CODE :='5919';
l_DICT_DMSU_DEPTS.NAME :='Кролевецький районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=977;
l_DICT_DMSU_DEPTS.CODE :='5920';
l_DICT_DMSU_DEPTS.NAME :='Лебединський міський сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=978;
l_DICT_DMSU_DEPTS.CODE :='5921';
l_DICT_DMSU_DEPTS.NAME :='Липоводолинський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=979;
l_DICT_DMSU_DEPTS.CODE :='5922';
l_DICT_DMSU_DEPTS.NAME :='Недригайлівський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=980;
l_DICT_DMSU_DEPTS.CODE :='5912';
l_DICT_DMSU_DEPTS.NAME :='Охтирський міський відділ Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=981;
l_DICT_DMSU_DEPTS.CODE :='5923';
l_DICT_DMSU_DEPTS.NAME :='Путивльський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=982;
l_DICT_DMSU_DEPTS.CODE :='5924';
l_DICT_DMSU_DEPTS.NAME :='Роменський міський відділ Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=983;
l_DICT_DMSU_DEPTS.CODE :='5925';
l_DICT_DMSU_DEPTS.NAME :='Середино-Будський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=984;
l_DICT_DMSU_DEPTS.CODE :='5926';
l_DICT_DMSU_DEPTS.NAME :='Сумський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=985;
l_DICT_DMSU_DEPTS.CODE :='5927';
l_DICT_DMSU_DEPTS.NAME :='Тростянецький районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=986;
l_DICT_DMSU_DEPTS.CODE :='5928';
l_DICT_DMSU_DEPTS.NAME :='Шосткинський міський відділ Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=987;
l_DICT_DMSU_DEPTS.CODE :='5929';
l_DICT_DMSU_DEPTS.NAME :='Ямпільський районний сектор Управління Державної міграційної служби України в Сумській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=988;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Управління "Центр надання адміністративних послуг у м. Суми" Сумської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=989;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м.Конотоп';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=990;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ "Центр надання адміністративних послуг" Глухівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=991;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Лебединської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=992;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Охтирської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=993;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг міста Ромни ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=994;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг міста Шостка виконавчого комітету Шосткинської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=995;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Білопільської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=996;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Буринському районі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=997;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Великописарівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=998;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Глухівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=999;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Конотопської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1000;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Краснопільської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1001;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кролевецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1002;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор "Центр надання адміністративних послуг" Лебединської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1003;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Липоводолинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1004;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр з надання адміністративних послуг  Недригайлівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1005;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Охтирської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1006;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Путивльської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1007;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр з надання адміністративних послуг при Роменській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1008;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Середино-Будської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1009;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Сумської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1010;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Тростянецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1011;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Шосткинському районі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1012;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ямпільської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1013;
l_DICT_DMSU_DEPTS.CODE :='6101';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1014;
l_DICT_DMSU_DEPTS.CODE :='6101';
l_DICT_DMSU_DEPTS.NAME :='Відділ у справах іноземців та осіб без громадянства Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1015;
l_DICT_DMSU_DEPTS.CODE :='6101';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації   Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1016;
l_DICT_DMSU_DEPTS.CODE :='6190';
l_DICT_DMSU_DEPTS.NAME :='Сектор по роботі з єдиним державним демографічним реєстром відділу з питань громадянства, паспортизації та реєстрації   Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1017;
l_DICT_DMSU_DEPTS.CODE :='6190';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1018;
l_DICT_DMSU_DEPTS.CODE :='6188';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Тернопільській  області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1019;
l_DICT_DMSU_DEPTS.CODE :='6111';
l_DICT_DMSU_DEPTS.NAME :='Бережанський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1020;
l_DICT_DMSU_DEPTS.CODE :='6112';
l_DICT_DMSU_DEPTS.NAME :='Борщівський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1021;
l_DICT_DMSU_DEPTS.CODE :='6113';
l_DICT_DMSU_DEPTS.NAME :='Бучацький районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1022;
l_DICT_DMSU_DEPTS.CODE :='6114';
l_DICT_DMSU_DEPTS.NAME :='Гусятинський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1023;
l_DICT_DMSU_DEPTS.CODE :='6115';
l_DICT_DMSU_DEPTS.NAME :='Заліщицький районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1024;
l_DICT_DMSU_DEPTS.CODE :='6116';
l_DICT_DMSU_DEPTS.NAME :='Збаразький районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1025;
l_DICT_DMSU_DEPTS.CODE :='6117';
l_DICT_DMSU_DEPTS.NAME :='Зборівський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1026;
l_DICT_DMSU_DEPTS.CODE :='6118';
l_DICT_DMSU_DEPTS.NAME :='Козівський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1027;
l_DICT_DMSU_DEPTS.CODE :='6119';
l_DICT_DMSU_DEPTS.NAME :='Кременецький районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1028;
l_DICT_DMSU_DEPTS.CODE :='6121';
l_DICT_DMSU_DEPTS.NAME :='Лановецький районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1029;
l_DICT_DMSU_DEPTS.CODE :='6122';
l_DICT_DMSU_DEPTS.NAME :='Монастириський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1030;
l_DICT_DMSU_DEPTS.CODE :='6123';
l_DICT_DMSU_DEPTS.NAME :='Підволочиський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1031;
l_DICT_DMSU_DEPTS.CODE :='6124';
l_DICT_DMSU_DEPTS.NAME :='Підгаєцький районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1032;
l_DICT_DMSU_DEPTS.CODE :='6125';
l_DICT_DMSU_DEPTS.NAME :='Теребовлянський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1033;
l_DICT_DMSU_DEPTS.CODE :='6110';
l_DICT_DMSU_DEPTS.NAME :='Тернопільський міський відділ Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1034;
l_DICT_DMSU_DEPTS.CODE :='6110';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Тернопільськиого міського відділу Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1035;
l_DICT_DMSU_DEPTS.CODE :='6126';
l_DICT_DMSU_DEPTS.NAME :='Тернопільський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1036;
l_DICT_DMSU_DEPTS.CODE :='6127';
l_DICT_DMSU_DEPTS.NAME :='Чортківський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1037;
l_DICT_DMSU_DEPTS.CODE :='6128';
l_DICT_DMSU_DEPTS.NAME :='Шумський районний сектор Управління Державної міграційної служби України в Тернопільській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1038;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у місті Тернополі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1039;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  міста Чорткова ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1040;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бережанської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1041;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Борщівський відділ-центр надання адміністративних послуг та видачі дозвільних документів';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1042;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бучацької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1043;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Гусятинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1044;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Заліщицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1045;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Збаразької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1046;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Зборівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1047;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Козівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1048;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ надання адміністративних послуг Кременецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1049;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Лановецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1050;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Монастириський центр надання адміністративних послуг- сектор управління економічного розвитку райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1051;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг Підволочиської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1052;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр  надання адміністративних послуг Підгаєцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1053;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Теребовлянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1054;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Тернопільському районі';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1055;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Чортківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1056;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ надання адміністративних послуг Шумської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1057;
l_DICT_DMSU_DEPTS.CODE :='6301';
l_DICT_DMSU_DEPTS.NAME :='Головне управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1058;
l_DICT_DMSU_DEPTS.CODE :='6301';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 1  Управління з питань громадянства, паспортизації та реєстрації  Головного управління Державної міграційної служби України в Харківській  області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1059;
l_DICT_DMSU_DEPTS.CODE :='6303';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1  Управління з питань громадянства, паспортизації та  реєстрації   Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1060;
l_DICT_DMSU_DEPTS.CODE :='6391';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2  Управління з питань громадянства, паспортизації та  реєстрації   Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1061;
l_DICT_DMSU_DEPTS.CODE :='6391';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1062;
l_DICT_DMSU_DEPTS.CODE :='6390';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 2  Управління з питань громадянства, паспортизації та реєстрації  Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1063;
l_DICT_DMSU_DEPTS.CODE :='6388';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання  Управління з питань громадянства, паспортизації та реєстрації Головного Управління Державної міграційної служби України в Харківській  області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1064;
l_DICT_DMSU_DEPTS.CODE :='6326';
l_DICT_DMSU_DEPTS.NAME :='Балаклійський районний відділ Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1065;
l_DICT_DMSU_DEPTS.CODE :='6327';
l_DICT_DMSU_DEPTS.NAME :='Барвінківський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1066;
l_DICT_DMSU_DEPTS.CODE :='6328';
l_DICT_DMSU_DEPTS.NAME :='Близнюківський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1067;
l_DICT_DMSU_DEPTS.CODE :='6329';
l_DICT_DMSU_DEPTS.NAME :='Богодухівський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1068;
l_DICT_DMSU_DEPTS.CODE :='6330';
l_DICT_DMSU_DEPTS.NAME :='Борівський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1069;
l_DICT_DMSU_DEPTS.CODE :='6331';
l_DICT_DMSU_DEPTS.NAME :='Валківський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1070;
l_DICT_DMSU_DEPTS.CODE :='6332';
l_DICT_DMSU_DEPTS.NAME :='Великобурлуцький районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1071;
l_DICT_DMSU_DEPTS.CODE :='6333';
l_DICT_DMSU_DEPTS.NAME :='Вовчанський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1072;
l_DICT_DMSU_DEPTS.CODE :='6335';
l_DICT_DMSU_DEPTS.NAME :='Дворічанський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1073;
l_DICT_DMSU_DEPTS.CODE :='6336';
l_DICT_DMSU_DEPTS.NAME :='Дергачівський районний відділ Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1074;
l_DICT_DMSU_DEPTS.CODE :='6311';
l_DICT_DMSU_DEPTS.NAME :='Шевченківській (Дзержинський) районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1075;
l_DICT_DMSU_DEPTS.CODE :='6311';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Шевченківського (Дзержинського) районного відділу у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1076;
l_DICT_DMSU_DEPTS.CODE :='6320';
l_DICT_DMSU_DEPTS.NAME :='Новобаварський (Жовтневий) районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1077;
l_DICT_DMSU_DEPTS.CODE :='6338';
l_DICT_DMSU_DEPTS.NAME :='Зачепилівський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1078;
l_DICT_DMSU_DEPTS.CODE :='6334';
l_DICT_DMSU_DEPTS.NAME :='Зміївський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1079;
l_DICT_DMSU_DEPTS.CODE :='6339';
l_DICT_DMSU_DEPTS.NAME :='Золочівський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1080;
l_DICT_DMSU_DEPTS.CODE :='6340';
l_DICT_DMSU_DEPTS.NAME :='Ізюмський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1081;
l_DICT_DMSU_DEPTS.CODE :='6341';
l_DICT_DMSU_DEPTS.NAME :='Кегичівський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1082;
l_DICT_DMSU_DEPTS.CODE :='6313';
l_DICT_DMSU_DEPTS.NAME :='Київський районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1083;
l_DICT_DMSU_DEPTS.CODE :='6313';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Київського районного відділу у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1084;
l_DICT_DMSU_DEPTS.CODE :='6342';
l_DICT_DMSU_DEPTS.NAME :='Коломацький районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1085;
l_DICT_DMSU_DEPTS.CODE :='6315';
l_DICT_DMSU_DEPTS.NAME :='Слобідський (Комінтернівський) районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1086;
l_DICT_DMSU_DEPTS.CODE :='6315';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Слобідського (Комінтернівського) районного відділу у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1087;
l_DICT_DMSU_DEPTS.CODE :='6343';
l_DICT_DMSU_DEPTS.NAME :='Красноградський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1088;
l_DICT_DMSU_DEPTS.CODE :='6344';
l_DICT_DMSU_DEPTS.NAME :='Краснокутський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1089;
l_DICT_DMSU_DEPTS.CODE :='6345';
l_DICT_DMSU_DEPTS.NAME :='Куп''янський районний відділ Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1090;
l_DICT_DMSU_DEPTS.CODE :='6316';
l_DICT_DMSU_DEPTS.NAME :='Холодногірський  (Ленінський) районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1091;
l_DICT_DMSU_DEPTS.CODE :='6346';
l_DICT_DMSU_DEPTS.NAME :='Лозівський районний відділ Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1092;
l_DICT_DMSU_DEPTS.CODE :='6325';
l_DICT_DMSU_DEPTS.NAME :='Люботинський міський сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1093;
l_DICT_DMSU_DEPTS.CODE :='6317';
l_DICT_DMSU_DEPTS.NAME :='Московський районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1094;
l_DICT_DMSU_DEPTS.CODE :='6317';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Московського районного відділу у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1095;
l_DICT_DMSU_DEPTS.CODE :='6347';
l_DICT_DMSU_DEPTS.NAME :='Нововодолазький районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1096;
l_DICT_DMSU_DEPTS.CODE :='6321';
l_DICT_DMSU_DEPTS.NAME :='Індустріальний (Орджонікідзевський) районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1097;
l_DICT_DMSU_DEPTS.CODE :='6321';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Індустріального (Орджонікідзевського) районного відділу у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1098;
l_DICT_DMSU_DEPTS.CODE :='6348';
l_DICT_DMSU_DEPTS.NAME :='Первомайський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1099;
l_DICT_DMSU_DEPTS.CODE :='6349';
l_DICT_DMSU_DEPTS.NAME :='Печенізький районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1100;
l_DICT_DMSU_DEPTS.CODE :='6350';
l_DICT_DMSU_DEPTS.NAME :='Сахновщинський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1101;
l_DICT_DMSU_DEPTS.CODE :='6323';
l_DICT_DMSU_DEPTS.NAME :='Немишлянський (Фрунзенський) районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1102;
l_DICT_DMSU_DEPTS.CODE :='6351';
l_DICT_DMSU_DEPTS.NAME :='Харківський районний відділ Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1103;
l_DICT_DMSU_DEPTS.CODE :='6324';
l_DICT_DMSU_DEPTS.NAME :='Основ''янський (Червонозаводський) районний відділ у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1104;
l_DICT_DMSU_DEPTS.CODE :='6324';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Основ''янського (Червонозаводського)  районного відділу у місті Харкові Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1105;
l_DICT_DMSU_DEPTS.CODE :='6355';
l_DICT_DMSU_DEPTS.NAME :='Чугуївський районний відділ Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1106;
l_DICT_DMSU_DEPTS.CODE :='6356';
l_DICT_DMSU_DEPTS.NAME :='Шевченківський районний сектор Головного управління Державної міграційної служби України в Харківській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1107;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Харкова ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1108;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Шевченківського (Дзержинського) району ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1109;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Новобаварського (Жовтневого) району ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1110;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Київського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1111;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Слобідського (Комінтернівського) району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1112;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Ленінського району ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1113;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Московського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1114;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Орджонікідзевського району';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1115;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Фрунзенського  району ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1116;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Територіальний підрозділ Центру надання адміністративних послуг м.Харкова Червонозаводського району ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1117;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Ізюма ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1118;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ адміністративно-дозвільних процедур виконавчого комітету Куп''янської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1119;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Лозівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1120;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг  Люботинської  міської 
ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1121;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг в м. Первомайський';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1122;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Чугуєва ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1123;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Балаклійській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1124;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Барвінківської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1125;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Близнюківській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1126;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Богодухівсткої районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1127;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Борівській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1128;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Валківській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1129;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Великобурлуцькій районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1130;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг у Вовчанському районі Вовчанської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1131;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Дворічанської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1132;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Дергачівській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1133;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Зачепилівській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1134;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Зміївській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1135;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Золочівської районної державної адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1136;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Ізюмській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1137;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :=' Центр надання адміністративних послуг Кегичівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1138;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Коломацькій районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1139;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Красноградської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1140;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :=' Центр надання адміністративних послуг Краснокутської  районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1141;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг при Куп''янський районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1142;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Лозівській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1143;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Нововодолазькій районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1144;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Первомайської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1145;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :=' Центр надання адміністративних послуг при Печенізькій районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1146;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Сахновщинській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1147;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Харківської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1148;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Чугуївській районній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1149;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Ценр надання адміністративних послуг при Шевченківській районній державній адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1150;
l_DICT_DMSU_DEPTS.CODE :='6501';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1151;
l_DICT_DMSU_DEPTS.CODE :='6501';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1152;
l_DICT_DMSU_DEPTS.CODE :='6501';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1153;
l_DICT_DMSU_DEPTS.CODE :='6501';
l_DICT_DMSU_DEPTS.NAME :='Відділ у справах іноземців та осіб без громадянства Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1154;
l_DICT_DMSU_DEPTS.CODE :='6588';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Херсонській  області ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1155;
l_DICT_DMSU_DEPTS.CODE :='6510';
l_DICT_DMSU_DEPTS.NAME :='Дніпровський районний відділ у місті Херсоні Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1156;
l_DICT_DMSU_DEPTS.CODE :='6510';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Дніпровського районного відділу у місті Херсоні Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1157;
l_DICT_DMSU_DEPTS.CODE :='6515';
l_DICT_DMSU_DEPTS.NAME :='Бериславський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1158;
l_DICT_DMSU_DEPTS.CODE :='6514';
l_DICT_DMSU_DEPTS.NAME :='Білозерський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1159;
l_DICT_DMSU_DEPTS.CODE :='6517';
l_DICT_DMSU_DEPTS.NAME :='Великолепетиський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1160;
l_DICT_DMSU_DEPTS.CODE :='6516';
l_DICT_DMSU_DEPTS.NAME :='Великоолександрівський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1161;
l_DICT_DMSU_DEPTS.CODE :='6518';
l_DICT_DMSU_DEPTS.NAME :='Верхньорогачицький районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1162;
l_DICT_DMSU_DEPTS.CODE :='6519';
l_DICT_DMSU_DEPTS.NAME :='Високопільський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1163;
l_DICT_DMSU_DEPTS.CODE :='6520';
l_DICT_DMSU_DEPTS.NAME :='Генічеський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1164;
l_DICT_DMSU_DEPTS.CODE :='6521';
l_DICT_DMSU_DEPTS.NAME :='Голопристанський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1165;
l_DICT_DMSU_DEPTS.CODE :='6522';
l_DICT_DMSU_DEPTS.NAME :='Горностаївський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1166;
l_DICT_DMSU_DEPTS.CODE :='6523';
l_DICT_DMSU_DEPTS.NAME :='Іванівський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1167;
l_DICT_DMSU_DEPTS.CODE :='6524';
l_DICT_DMSU_DEPTS.NAME :='Каланчацький районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1168;
l_DICT_DMSU_DEPTS.CODE :='6525';
l_DICT_DMSU_DEPTS.NAME :='Каховський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1169;
l_DICT_DMSU_DEPTS.CODE :='6511';
l_DICT_DMSU_DEPTS.NAME :='Корабельний (Комсомольський) районний відділ у місті Херсоні Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1170;
l_DICT_DMSU_DEPTS.CODE :='6511';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Корабельного (Комсомольського)  районного відділу у місті Херсоні Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1171;
l_DICT_DMSU_DEPTS.CODE :='6526';
l_DICT_DMSU_DEPTS.NAME :='Нижньосірогозький районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1172;
l_DICT_DMSU_DEPTS.CODE :='6527';
l_DICT_DMSU_DEPTS.NAME :='Нововоронцовський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1173;
l_DICT_DMSU_DEPTS.CODE :='6513';
l_DICT_DMSU_DEPTS.NAME :='Новокаховський міський сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1174;
l_DICT_DMSU_DEPTS.CODE :='6528';
l_DICT_DMSU_DEPTS.NAME :='Новотроїцький районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1175;
l_DICT_DMSU_DEPTS.CODE :='6529';
l_DICT_DMSU_DEPTS.NAME :='Скадовський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1176;
l_DICT_DMSU_DEPTS.CODE :='6512';
l_DICT_DMSU_DEPTS.NAME :='Суворовський районний відділ у місті Херсоні Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1177;
l_DICT_DMSU_DEPTS.CODE :='6512';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Суворовського районного відділу у місті Херсоні Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1178;
l_DICT_DMSU_DEPTS.CODE :='6530';
l_DICT_DMSU_DEPTS.NAME :='Олешківський (Цюрупинський) районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1179;
l_DICT_DMSU_DEPTS.CODE :='6531';
l_DICT_DMSU_DEPTS.NAME :='Чаплинський районний сектор Управління Державної міграційної служби України в Херсонській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1180;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м.Херсона';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1181;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Голопристанської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1182;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Каховської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1183;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Новокаховської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1184;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Бериславській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1185;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Білозерській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1186;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Великолепетиській районній державній адміністрації                                        ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1187;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Великоолександрівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1188;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Верхньорогачицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1189;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Генічеської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1190;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Голопристанської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1191;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Горностаївської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1192;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Іванівської районної державної адміністрації (сектор)';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1193;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Каланчацькій районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1194;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Каховській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1195;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Нижньосірогозької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1196;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг сектору надання адміністративних послуг Нововоронцовської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1197;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новотроїцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1198;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Скадовської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1199;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Олешківської (Цюрупинської) районної державної адміністрації Херсонської області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1200;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Чаплинської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1201;
l_DICT_DMSU_DEPTS.CODE :='6801';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1202;
l_DICT_DMSU_DEPTS.CODE :='6801';
l_DICT_DMSU_DEPTS.NAME :='Відділ у справах іноземців та осіб без громадянства Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1203;
l_DICT_DMSU_DEPTS.CODE :='6802';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1204;
l_DICT_DMSU_DEPTS.CODE :='6802';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1205;
l_DICT_DMSU_DEPTS.CODE :='6802';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1206;
l_DICT_DMSU_DEPTS.CODE :='6888';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1207;
l_DICT_DMSU_DEPTS.CODE :='6814';
l_DICT_DMSU_DEPTS.NAME :='Білогірський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1208;
l_DICT_DMSU_DEPTS.CODE :='6815';
l_DICT_DMSU_DEPTS.NAME :='Віньковецький районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1209;
l_DICT_DMSU_DEPTS.CODE :='6816';
l_DICT_DMSU_DEPTS.NAME :='Волочиський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1210;
l_DICT_DMSU_DEPTS.CODE :='6817';
l_DICT_DMSU_DEPTS.NAME :='Городоцький районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1211;
l_DICT_DMSU_DEPTS.CODE :='6818';
l_DICT_DMSU_DEPTS.NAME :='Деражнянський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1212;
l_DICT_DMSU_DEPTS.CODE :='6819';
l_DICT_DMSU_DEPTS.NAME :='Дунаєвецький районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1213;
l_DICT_DMSU_DEPTS.CODE :='6820';
l_DICT_DMSU_DEPTS.NAME :='Ізяславський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1214;
l_DICT_DMSU_DEPTS.CODE :='6821';
l_DICT_DMSU_DEPTS.NAME :='Кам''янець-Подільський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1215;
l_DICT_DMSU_DEPTS.CODE :='6811';
l_DICT_DMSU_DEPTS.NAME :='Кам''янець-Подільський міський відділ Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1216;
l_DICT_DMSU_DEPTS.CODE :='6822';
l_DICT_DMSU_DEPTS.NAME :='Красилівський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1217;
l_DICT_DMSU_DEPTS.CODE :='6823';
l_DICT_DMSU_DEPTS.NAME :='Летичівський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1218;
l_DICT_DMSU_DEPTS.CODE :='6812';
l_DICT_DMSU_DEPTS.NAME :='Нетішинський міський сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1219;
l_DICT_DMSU_DEPTS.CODE :='6824';
l_DICT_DMSU_DEPTS.NAME :='Новоушицький районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1220;
l_DICT_DMSU_DEPTS.CODE :='6825';
l_DICT_DMSU_DEPTS.NAME :='Полонський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1221;
l_DICT_DMSU_DEPTS.CODE :='6813';
l_DICT_DMSU_DEPTS.NAME :='Славутський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1222;
l_DICT_DMSU_DEPTS.CODE :='6826';
l_DICT_DMSU_DEPTS.NAME :='Старокостянтинівський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1223;
l_DICT_DMSU_DEPTS.CODE :='6827';
l_DICT_DMSU_DEPTS.NAME :='Старосинявський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:07','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1224;
l_DICT_DMSU_DEPTS.CODE :='6828';
l_DICT_DMSU_DEPTS.NAME :='Теофіпольський районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1225;
l_DICT_DMSU_DEPTS.CODE :='6829';
l_DICT_DMSU_DEPTS.NAME :='Хмельницький районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1226;
l_DICT_DMSU_DEPTS.CODE :='6810';
l_DICT_DMSU_DEPTS.NAME :='Хмельницький міський відділ Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1227;
l_DICT_DMSU_DEPTS.CODE :='6810';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Хмельницького міського відділу Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1228;
l_DICT_DMSU_DEPTS.CODE :='6830';
l_DICT_DMSU_DEPTS.NAME :='Чемеровецький районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1229;
l_DICT_DMSU_DEPTS.CODE :='6831';
l_DICT_DMSU_DEPTS.NAME :='Шепетівський міський відділ Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1230;
l_DICT_DMSU_DEPTS.CODE :='6832';
l_DICT_DMSU_DEPTS.NAME :='Ярмолинецький районний сектор Управління Державної міграційної служби України в Хмельницькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1231;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Хмельницької міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1232;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Хмельницької міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1233;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Хмельницької міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1234;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Кам''янець-Подільської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1235;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Нетішинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1236;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Славутської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1237;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Старокостянтинівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1238;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Шепетівської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1239;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Білогірської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1240;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Віньковецької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1241;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Волочиської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1242;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Городоцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1243;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Деражнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1244;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Дунаєвецької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1245;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Ізяславській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1246;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кам''янець-Подільської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1247;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Красилівській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1248;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Летичівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1249;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новоушицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1250;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Полонської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1251;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Славутської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1252;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Старокостянтинівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1253;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Старосинявській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1254;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Теофіпольської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1255;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Хмельницької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1256;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Чемеровецькій районній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1257;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Шепетівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1258;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ярмолинецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1259;
l_DICT_DMSU_DEPTS.CODE :='7101';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1260;
l_DICT_DMSU_DEPTS.CODE :='7101';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 1 відділу з питань громадянства, паспортизації та реєстрації  Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1261;
l_DICT_DMSU_DEPTS.CODE :='7102';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1262;
l_DICT_DMSU_DEPTS.CODE :='7188';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1263;
l_DICT_DMSU_DEPTS.CODE :='7111';
l_DICT_DMSU_DEPTS.NAME :='Соснівський районний відділ у місті Черкаси Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1264;
l_DICT_DMSU_DEPTS.CODE :='7111';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 2 Соснівського районного відділу у місті Черкаси Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1265;
l_DICT_DMSU_DEPTS.CODE :='7110';
l_DICT_DMSU_DEPTS.NAME :='Придніпровський районний відділ у місті Черкаси Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1266;
l_DICT_DMSU_DEPTS.CODE :='7110';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів № 3 Придніпровського районного відділу у місті Черкаси Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1267;
l_DICT_DMSU_DEPTS.CODE :='7126';
l_DICT_DMSU_DEPTS.NAME :='Смілянський районний відділ Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1268;
l_DICT_DMSU_DEPTS.CODE :='7118';
l_DICT_DMSU_DEPTS.NAME :='Золотоніський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1269;
l_DICT_DMSU_DEPTS.CODE :='7130';
l_DICT_DMSU_DEPTS.NAME :='Черкаський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1270;
l_DICT_DMSU_DEPTS.CODE :='7113';
l_DICT_DMSU_DEPTS.NAME :='Уманський районний відділ Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1271;
l_DICT_DMSU_DEPTS.CODE :='7114';
l_DICT_DMSU_DEPTS.NAME :='Городищенський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1272;
l_DICT_DMSU_DEPTS.CODE :='7115';
l_DICT_DMSU_DEPTS.NAME :='Драбівський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1273;
l_DICT_DMSU_DEPTS.CODE :='7116';
l_DICT_DMSU_DEPTS.NAME :='Жашківський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1274;
l_DICT_DMSU_DEPTS.CODE :='7117';
l_DICT_DMSU_DEPTS.NAME :='Звенигородський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1275;
l_DICT_DMSU_DEPTS.CODE :='7119';
l_DICT_DMSU_DEPTS.NAME :='Кам’янський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1276;
l_DICT_DMSU_DEPTS.CODE :='7120';
l_DICT_DMSU_DEPTS.NAME :='Канівський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1277;
l_DICT_DMSU_DEPTS.CODE :='7122';
l_DICT_DMSU_DEPTS.NAME :='Корсунь-Шевченківський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1278;
l_DICT_DMSU_DEPTS.CODE :='7124';
l_DICT_DMSU_DEPTS.NAME :='Маньківський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1279;
l_DICT_DMSU_DEPTS.CODE :='7125';
l_DICT_DMSU_DEPTS.NAME :='Монастирищенський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1280;
l_DICT_DMSU_DEPTS.CODE :='7127';
l_DICT_DMSU_DEPTS.NAME :='Тальнівський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1281;
l_DICT_DMSU_DEPTS.CODE :='7132';
l_DICT_DMSU_DEPTS.NAME :='Чигиринський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1282;
l_DICT_DMSU_DEPTS.CODE :='7131';
l_DICT_DMSU_DEPTS.NAME :='Чорнобаївський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1283;
l_DICT_DMSU_DEPTS.CODE :='7133';
l_DICT_DMSU_DEPTS.NAME :='Шполянський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1284;
l_DICT_DMSU_DEPTS.CODE :='7129';
l_DICT_DMSU_DEPTS.NAME :='Христинівський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1285;
l_DICT_DMSU_DEPTS.CODE :='7123';
l_DICT_DMSU_DEPTS.NAME :='Лисянський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1286;
l_DICT_DMSU_DEPTS.CODE :='7121';
l_DICT_DMSU_DEPTS.NAME :='Катеринопільський районний сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1287;
l_DICT_DMSU_DEPTS.CODE :='7112';
l_DICT_DMSU_DEPTS.NAME :='Ватутінський міський сектор Управління Державної міграційної служби України в Черкаській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1288;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Управління надання адміністративних послуг департаменту управління справами та юридичного забезпечення Черкаської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1289;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ надання адміністративних послуг виконавчого комітету Смілянської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1290;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг у місті Золотоноша';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1291;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг виконавчого комітету Уманської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1292;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ватутінської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1293;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  послуг  виконавчого комітету Канівської міської ради ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1294;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Городищенської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1295;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Драбівської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1296;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Жашківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1297;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Звенигородської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1298;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Золотоніської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1299;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кам’янської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1300;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Канівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1301;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Катеринопільській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1302;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Корсунь-Шевченківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1303;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Лисянській  районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1304;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Маньківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1305;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Монастирищенської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1306;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Смілянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1307;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Тальнівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1308;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Уманської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1309;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Христинівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1310;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Черкаської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1311;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг при Чигиринській районній державній адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1312;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Чорнобаївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1313;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Шполянської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1314;
l_DICT_DMSU_DEPTS.CODE :='7301';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в  Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1315;
l_DICT_DMSU_DEPTS.CODE :='7301';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів  відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби України в  Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1316;
l_DICT_DMSU_DEPTS.CODE :='7302';
l_DICT_DMSU_DEPTS.NAME :='ДП "Документ"';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1317;
l_DICT_DMSU_DEPTS.CODE :='7388';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1318;
l_DICT_DMSU_DEPTS.CODE :='7313';
l_DICT_DMSU_DEPTS.NAME :='Вижницький районний сектор Управління Державної міграційної служби  України в Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1319;
l_DICT_DMSU_DEPTS.CODE :='7314';
l_DICT_DMSU_DEPTS.NAME :='Герцаївський районний сектор Управління Державної міграційної служби України в  Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1320;
l_DICT_DMSU_DEPTS.CODE :='7315';
l_DICT_DMSU_DEPTS.NAME :='Глибоцький районний відділ Управління Державної міграційної служби України в  Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1321;
l_DICT_DMSU_DEPTS.CODE :='7316';
l_DICT_DMSU_DEPTS.NAME :='Заставнівський районний сектор Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1322;
l_DICT_DMSU_DEPTS.CODE :='7318';
l_DICT_DMSU_DEPTS.NAME :='Кіцманський районний сектор Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1323;
l_DICT_DMSU_DEPTS.CODE :='7317';
l_DICT_DMSU_DEPTS.NAME :='Кельменецький районний сектор Управління Державної міграційної служби України в  Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1324;
l_DICT_DMSU_DEPTS.CODE :='7319';
l_DICT_DMSU_DEPTS.NAME :='Новоселицький районний сектор Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1325;
l_DICT_DMSU_DEPTS.CODE :='7321';
l_DICT_DMSU_DEPTS.NAME :='Сокирянський районний сектор Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1326;
l_DICT_DMSU_DEPTS.CODE :='7323';
l_DICT_DMSU_DEPTS.NAME :='Сторожинецький районний відділ Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1327;
l_DICT_DMSU_DEPTS.CODE :='7320';
l_DICT_DMSU_DEPTS.NAME :='Путильський районний сектор Управління Державної міграційної служби України в  Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1328;
l_DICT_DMSU_DEPTS.CODE :='7310';
l_DICT_DMSU_DEPTS.NAME :='Чернівецький міський відділ  Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1329;
l_DICT_DMSU_DEPTS.CODE :='7310';
l_DICT_DMSU_DEPTS.NAME :='Сектор з питань паспортизації, реєстрації фізичних осіб та еміграції № 1 Чернівецького міського відділу Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1330;
l_DICT_DMSU_DEPTS.CODE :='7310';
l_DICT_DMSU_DEPTS.NAME :='Сектор з питань паспортизації, реєстрації фізичних осіб та еміграції № 2 Чернівецького міського відділу Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1331;
l_DICT_DMSU_DEPTS.CODE :='7310';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Чернівецького міського відділу Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1332;
l_DICT_DMSU_DEPTS.CODE :='7324';
l_DICT_DMSU_DEPTS.NAME :='Хотинський районний сектор Управління Державної міграційної служби України в   Чернівецькій області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1333;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Чернівецької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1334;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг в місті Новодністровськ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1335;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Вижницької районної державної адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1336;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Герцаївської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1337;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Глибоцької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1338;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Заставнівської районної державної адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1339;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кельменецької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1340;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Кіцманської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1341;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новоселицької районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1342;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Путильської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1343;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Сокирянської районної державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1344;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Сторожинецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1345;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Хотинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1346;
l_DICT_DMSU_DEPTS.CODE :='7401';
l_DICT_DMSU_DEPTS.NAME :='Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1347;
l_DICT_DMSU_DEPTS.CODE :='7401';
l_DICT_DMSU_DEPTS.NAME :='Сектор по роботі з Єдиним державним демографічним реєстром відділу з питань громадянства, паспортизації та реєстрації Управління Державної міграційної служби в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1348;
l_DICT_DMSU_DEPTS.CODE :='7488';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1349;
l_DICT_DMSU_DEPTS.CODE :='7412';
l_DICT_DMSU_DEPTS.NAME :='Бахмацький районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1350;
l_DICT_DMSU_DEPTS.CODE :='7413';
l_DICT_DMSU_DEPTS.NAME :='Бобровицький районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1351;
l_DICT_DMSU_DEPTS.CODE :='7415';
l_DICT_DMSU_DEPTS.NAME :='Варвинський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1352;
l_DICT_DMSU_DEPTS.CODE :='7414';
l_DICT_DMSU_DEPTS.NAME :='Борзнянський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1353;
l_DICT_DMSU_DEPTS.CODE :='7416';
l_DICT_DMSU_DEPTS.NAME :='Городнянський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1354;
l_DICT_DMSU_DEPTS.CODE :='7417';
l_DICT_DMSU_DEPTS.NAME :='Ічнянський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1355;
l_DICT_DMSU_DEPTS.CODE :='7418';
l_DICT_DMSU_DEPTS.NAME :='Козелецький районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1356;
l_DICT_DMSU_DEPTS.CODE :='7419';
l_DICT_DMSU_DEPTS.NAME :='Коропський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1357;
l_DICT_DMSU_DEPTS.CODE :='7420';
l_DICT_DMSU_DEPTS.NAME :='Корюківський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1358;
l_DICT_DMSU_DEPTS.CODE :='7421';
l_DICT_DMSU_DEPTS.NAME :='Куликівський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1359;
l_DICT_DMSU_DEPTS.CODE :='7422';
l_DICT_DMSU_DEPTS.NAME :='Менський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1360;
l_DICT_DMSU_DEPTS.CODE :='7423';
l_DICT_DMSU_DEPTS.NAME :='Ніжинський міський відділ Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1361;
l_DICT_DMSU_DEPTS.CODE :='7424';
l_DICT_DMSU_DEPTS.NAME :='Новгород-Сіверський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1362;
l_DICT_DMSU_DEPTS.CODE :='7425';
l_DICT_DMSU_DEPTS.NAME :='Носівський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1363;
l_DICT_DMSU_DEPTS.CODE :='7426';
l_DICT_DMSU_DEPTS.NAME :='Прилуцький міський відділ Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1364;
l_DICT_DMSU_DEPTS.CODE :='7427';
l_DICT_DMSU_DEPTS.NAME :='Ріпкинський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1365;
l_DICT_DMSU_DEPTS.CODE :='7428';
l_DICT_DMSU_DEPTS.NAME :='Семенівський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1366;
l_DICT_DMSU_DEPTS.CODE :='7429';
l_DICT_DMSU_DEPTS.NAME :='Сосницький районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1367;
l_DICT_DMSU_DEPTS.CODE :='7430';
l_DICT_DMSU_DEPTS.NAME :='Срібнянський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1368;
l_DICT_DMSU_DEPTS.CODE :='7431';
l_DICT_DMSU_DEPTS.NAME :='Талалаївський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1369;
l_DICT_DMSU_DEPTS.CODE :='7410';
l_DICT_DMSU_DEPTS.NAME :='Чернігівський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1370;
l_DICT_DMSU_DEPTS.CODE :='7433';
l_DICT_DMSU_DEPTS.NAME :='Сновський районний сектор Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1371;
l_DICT_DMSU_DEPTS.CODE :='7434';
l_DICT_DMSU_DEPTS.NAME :='Деснянський районний відділ у місті Чернігові Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1372;
l_DICT_DMSU_DEPTS.CODE :='7411';
l_DICT_DMSU_DEPTS.NAME :='Новозаводський районний відділ у місті Чернігові Управління Державної міграційної служби України в Чернігівській області';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1373;
l_DICT_DMSU_DEPTS.CODE :='7477';
l_DICT_DMSU_DEPTS.NAME :='Чернігівський пункт тимчасового перебування іноземців та осіб без громадянства';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1374;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг м. Чернігова';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1375;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ніжинської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1376;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Прилуцької міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1377;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Новгород-Сіверської міської ради';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1378;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Бахмацької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1379;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор (Центр) надання адміністративних послуг  Бобровицької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1380;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних  Борзнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1381;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Варвинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1382;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Городнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1383;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ічнянської районної державної адміністрації.';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1384;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Козелецької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1385;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Коропської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1386;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр  надання адміністративних послуг Корюківської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1387;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр (Сектор) надання адміністративних послуг Куликівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1388;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Менської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1389;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ніжинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1390;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор (Центр ) надання адміністративних послуг Носівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1391;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Ріпкинської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1392;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Семенівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1393;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Сосницької районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1394;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Срібнянської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1395;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Талалаївської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1396;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Чернігівської районної державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1397;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Сновської райдержадміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1398;
l_DICT_DMSU_DEPTS.CODE :='8001';
l_DICT_DMSU_DEPTS.NAME :='Головне управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1399;
l_DICT_DMSU_DEPTS.CODE :='8001';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 1  Управління з питань громадянства, паспортизації та  реєстрації Головного управління Державної міграційної служби України в  місті  Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1400;
l_DICT_DMSU_DEPTS.CODE :='8099';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 2  Управління з питань громадянства, паспортизації та  реєстрації Головного управління Державної міграційної служби України в  місті  Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1401;
l_DICT_DMSU_DEPTS.CODE :='8089';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 3  Управління з питань громадянства, паспортизації та  реєстрації Головного управління Державної міграційної служби України в  місті  Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1402;
l_DICT_DMSU_DEPTS.CODE :='8079';
l_DICT_DMSU_DEPTS.NAME :='Відділ оформлення документів № 3  Управління з питань громадянства, паспортизації та  реєстрації Головного управління Державної міграційної служби України в  місті  Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1403;
l_DICT_DMSU_DEPTS.CODE :='8069';
l_DICT_DMSU_DEPTS.NAME :='Сектор централізованої обробки даних № 2 Управління з питань громадянства, паспортизації та  реєстрації Головного управління Державної міграційної служби України в  місті  Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1404;
l_DICT_DMSU_DEPTS.CODE :='8088';
l_DICT_DMSU_DEPTS.NAME :='Відділ обліку та моніторингу інформації про реєстрацію місця проживання  Управління з питань громадянства, паспортизації та реєстрації Головного Управління Державної міграційної служби України в місті Києві ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1405;
l_DICT_DMSU_DEPTS.CODE :='8024';
l_DICT_DMSU_DEPTS.NAME :='Голосіївський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1406;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Голосіївського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1407;
l_DICT_DMSU_DEPTS.CODE :='8025';
l_DICT_DMSU_DEPTS.NAME :='Дарницький районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1408;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Дарницького районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1409;
l_DICT_DMSU_DEPTS.CODE :='8026';
l_DICT_DMSU_DEPTS.NAME :='Деснянський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1410;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Деснянського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1411;
l_DICT_DMSU_DEPTS.CODE :='8027';
l_DICT_DMSU_DEPTS.NAME :='Дніпровський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1412;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Дніпровського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1413;
l_DICT_DMSU_DEPTS.CODE :='8029';
l_DICT_DMSU_DEPTS.NAME :='Оболонський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1414;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Голосіївського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1415;
l_DICT_DMSU_DEPTS.CODE :='8030';
l_DICT_DMSU_DEPTS.NAME :='Печерський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1416;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Голосіївського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1417;
l_DICT_DMSU_DEPTS.CODE :='8031';
l_DICT_DMSU_DEPTS.NAME :='Подільський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1418;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Подільського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1419;
l_DICT_DMSU_DEPTS.CODE :='8032';
l_DICT_DMSU_DEPTS.NAME :='Святошинський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1420;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Святошинського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1421;
l_DICT_DMSU_DEPTS.CODE :='8034';
l_DICT_DMSU_DEPTS.NAME :='Солом''янський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1422;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів Солом"янського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1423;
l_DICT_DMSU_DEPTS.CODE :='8036';
l_DICT_DMSU_DEPTS.NAME :='Шевченківський районний відділ Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1424;
l_DICT_DMSU_DEPTS.CODE :='8036';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів №1 Шевченківського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1425;
l_DICT_DMSU_DEPTS.CODE :='8037';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів №2 Шевченківського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1426;
l_DICT_DMSU_DEPTS.CODE :='8037';
l_DICT_DMSU_DEPTS.NAME :='Сектор оформлення документів №3 Шевченківського районного відділу Головного управління Державної міграційної служби України в місті Києві';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1427;
l_DICT_DMSU_DEPTS.CODE :='8025';
l_DICT_DMSU_DEPTS.NAME :='Департамент (Центр) надання адміністративних послуг виконавчого органу Київської міської ради (Київської міської державної адміністрації)';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=1;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1428;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг апарату Голосіївської районної в місті Києві державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1429;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг апарату Дарницької районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1430;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Філія (центр) надання адміністративних послуг апарату  Деснянської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1431;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг апарату  Деснянської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1432;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг апарату Дніпровської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1433;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Філія (Центр) надання адміністративних послуг Оболонської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1434;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (Центр) надання адміністративних послуг Оболонської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1435;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг апарату Печерської районної в місті Києві державної адміністрації  ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1436;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг апарату  Подільської районної в місті Києві державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1437;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг  Святошинської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1438;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Центр надання адміністративних послуг Солом''янської районної в місті Києві державної адміністрації ';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1439;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Філія (центр) надання адміністративних послуг апарату Шевченківської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


l_DICT_DMSU_DEPTS.ID :=1440;
l_DICT_DMSU_DEPTS.CODE :='0000';
l_DICT_DMSU_DEPTS.NAME :='Відділ (центр) надання адміністративних послуг апарату Шевченківської районної в місті Києві державної адміністрації';
l_DICT_DMSU_DEPTS.IS_ACTIVE :=0;
l_DICT_DMSU_DEPTS.VALID_FROM :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.VALID_TO :=to_date('','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_DT :=to_date('20.07.2018 14:40:08','DD.MM.YYYY HH24:MI:SS');
l_DICT_DMSU_DEPTS.LAST_USER :='BARS';

 p_merge( l_DICT_DMSU_DEPTS);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_DICT_DMSU_DEPTS.sql ========
PROMPT ===================================================================================== 
