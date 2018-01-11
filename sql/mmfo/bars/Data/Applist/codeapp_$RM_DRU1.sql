PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_DRU1.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_DRU1 ***
  declare
    l_application_code varchar2(10 char) := '$RM_DRU1';
    l_application_name varchar2(300 char) := 'АРМ Друк звітів ';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
    l_function_ids number_list := number_list();
    l_function_codeoper     OPERLIST.CODEOPER%type;
    l_function_deps         OPERLIST.CODEOPER%type;
    l_application_id integer;
    l_role_resource_type_id integer := resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE);
    l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
    l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
    l integer := 0;
	d integer := 0;
begin
     DBMS_OUTPUT.PUT_LINE(' $RM_DRU1 створюємо (або оновлюємо) АРМ АРМ Друк звітів  ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Експорт катзапитів (DBF, TXT) ********** ');
          --  Створюємо функцію Експорт катзапитів (DBF, TXT)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Експорт катзапитів (DBF, TXT)',
                                                  p_funcname => '/barsroot/cbirep/export_dbf.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Збір параметрів для експорту DBF
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Збір параметрів для експорту DBF',
															  p_funcname => '/barsroot/cbirep/export_dbf_var.aspx?kodz=\d+',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  Створюємо дочірню функцію Друк звітів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звітів',
															  p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  Створюємо дочірню функцію Друк звітів
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Друк звітів',
															  p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування звітів ********** ');
          --  Створюємо функцію Формування звітів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування звітів',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_DRU1',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Обробка запитів ********** ');
          --  Створюємо функцію Обробка запитів
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка запитів',
                                                  p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_DRU1) - АРМ Друк звітів   ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE(' Bидані функції можливо потребують підтвердження - автоматично підтверджуємо їх ');
    for i in (select a.id
              from   adm_resource_activity a
              where  a.grantee_type_id = l_arm_resource_type_id and
                     a.resource_type_id = l_func_resource_type_id and
                     a.grantee_id = l_application_id and
                     a.resource_id in (select column_value from table(l_function_ids))  and
                     a.access_mode_id = 1 and
                     a.resolution_time is null) loop
        resource_utl.approve_resource_access(i.id, 'Автоматичне підтвердження прав на функції для АРМу');
    end loop;
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
umu.add_report2arm(1,'$RM_DRU1');
umu.add_report2arm(2,'$RM_DRU1');
umu.add_report2arm(3,'$RM_DRU1');
umu.add_report2arm(4,'$RM_DRU1');
umu.add_report2arm(5,'$RM_DRU1');
umu.add_report2arm(6,'$RM_DRU1');
umu.add_report2arm(7,'$RM_DRU1');
umu.add_report2arm(8,'$RM_DRU1');
umu.add_report2arm(11,'$RM_DRU1');
umu.add_report2arm(12,'$RM_DRU1');
umu.add_report2arm(14,'$RM_DRU1');
umu.add_report2arm(15,'$RM_DRU1');
umu.add_report2arm(16,'$RM_DRU1');
umu.add_report2arm(17,'$RM_DRU1');
umu.add_report2arm(18,'$RM_DRU1');
umu.add_report2arm(25,'$RM_DRU1');
umu.add_report2arm(27,'$RM_DRU1');
umu.add_report2arm(28,'$RM_DRU1');
umu.add_report2arm(30,'$RM_DRU1');
umu.add_report2arm(31,'$RM_DRU1');
umu.add_report2arm(32,'$RM_DRU1');
umu.add_report2arm(33,'$RM_DRU1');
umu.add_report2arm(34,'$RM_DRU1');
umu.add_report2arm(35,'$RM_DRU1');
umu.add_report2arm(36,'$RM_DRU1');
umu.add_report2arm(37,'$RM_DRU1');
umu.add_report2arm(38,'$RM_DRU1');
umu.add_report2arm(39,'$RM_DRU1');
umu.add_report2arm(41,'$RM_DRU1');
umu.add_report2arm(42,'$RM_DRU1');
umu.add_report2arm(43,'$RM_DRU1');
umu.add_report2arm(45,'$RM_DRU1');
umu.add_report2arm(48,'$RM_DRU1');
umu.add_report2arm(49,'$RM_DRU1');
umu.add_report2arm(50,'$RM_DRU1');
umu.add_report2arm(54,'$RM_DRU1');
umu.add_report2arm(57,'$RM_DRU1');
umu.add_report2arm(58,'$RM_DRU1');
umu.add_report2arm(61,'$RM_DRU1');
umu.add_report2arm(63,'$RM_DRU1');
umu.add_report2arm(66,'$RM_DRU1');
umu.add_report2arm(67,'$RM_DRU1');
umu.add_report2arm(73,'$RM_DRU1');
umu.add_report2arm(77,'$RM_DRU1');
umu.add_report2arm(88,'$RM_DRU1');
umu.add_report2arm(92,'$RM_DRU1');
umu.add_report2arm(95,'$RM_DRU1');
umu.add_report2arm(107,'$RM_DRU1');
umu.add_report2arm(110,'$RM_DRU1');
umu.add_report2arm(112,'$RM_DRU1');
umu.add_report2arm(116,'$RM_DRU1');
umu.add_report2arm(118,'$RM_DRU1');
umu.add_report2arm(119,'$RM_DRU1');
umu.add_report2arm(120,'$RM_DRU1');
umu.add_report2arm(121,'$RM_DRU1');
umu.add_report2arm(122,'$RM_DRU1');
umu.add_report2arm(125,'$RM_DRU1');
umu.add_report2arm(126,'$RM_DRU1');
umu.add_report2arm(128,'$RM_DRU1');
umu.add_report2arm(130,'$RM_DRU1');
umu.add_report2arm(132,'$RM_DRU1');
umu.add_report2arm(136,'$RM_DRU1');
umu.add_report2arm(146,'$RM_DRU1');
umu.add_report2arm(147,'$RM_DRU1');
umu.add_report2arm(152,'$RM_DRU1');
umu.add_report2arm(155,'$RM_DRU1');
umu.add_report2arm(156,'$RM_DRU1');
umu.add_report2arm(165,'$RM_DRU1');
umu.add_report2arm(167,'$RM_DRU1');
umu.add_report2arm(171,'$RM_DRU1');
umu.add_report2arm(172,'$RM_DRU1');
umu.add_report2arm(173,'$RM_DRU1');
umu.add_report2arm(174,'$RM_DRU1');
umu.add_report2arm(177,'$RM_DRU1');
umu.add_report2arm(179,'$RM_DRU1');
umu.add_report2arm(180,'$RM_DRU1');
umu.add_report2arm(182,'$RM_DRU1');
umu.add_report2arm(184,'$RM_DRU1');
umu.add_report2arm(185,'$RM_DRU1');
umu.add_report2arm(186,'$RM_DRU1');
umu.add_report2arm(187,'$RM_DRU1');
umu.add_report2arm(188,'$RM_DRU1');
umu.add_report2arm(189,'$RM_DRU1');
umu.add_report2arm(190,'$RM_DRU1');
umu.add_report2arm(191,'$RM_DRU1');
umu.add_report2arm(192,'$RM_DRU1');
umu.add_report2arm(193,'$RM_DRU1');
umu.add_report2arm(194,'$RM_DRU1');
umu.add_report2arm(196,'$RM_DRU1');
umu.add_report2arm(197,'$RM_DRU1');
umu.add_report2arm(201,'$RM_DRU1');
umu.add_report2arm(202,'$RM_DRU1');
umu.add_report2arm(205,'$RM_DRU1');
umu.add_report2arm(210,'$RM_DRU1');
umu.add_report2arm(211,'$RM_DRU1');
umu.add_report2arm(212,'$RM_DRU1');
umu.add_report2arm(213,'$RM_DRU1');
umu.add_report2arm(214,'$RM_DRU1');
umu.add_report2arm(216,'$RM_DRU1');
umu.add_report2arm(217,'$RM_DRU1');
umu.add_report2arm(218,'$RM_DRU1');
umu.add_report2arm(219,'$RM_DRU1');
umu.add_report2arm(220,'$RM_DRU1');
umu.add_report2arm(221,'$RM_DRU1');
umu.add_report2arm(222,'$RM_DRU1');
umu.add_report2arm(225,'$RM_DRU1');
umu.add_report2arm(226,'$RM_DRU1');
umu.add_report2arm(227,'$RM_DRU1');
umu.add_report2arm(228,'$RM_DRU1');
umu.add_report2arm(230,'$RM_DRU1');
umu.add_report2arm(231,'$RM_DRU1');
umu.add_report2arm(232,'$RM_DRU1');
umu.add_report2arm(233,'$RM_DRU1');
umu.add_report2arm(235,'$RM_DRU1');
umu.add_report2arm(237,'$RM_DRU1');
umu.add_report2arm(238,'$RM_DRU1');
umu.add_report2arm(239,'$RM_DRU1');
umu.add_report2arm(240,'$RM_DRU1');
umu.add_report2arm(243,'$RM_DRU1');
umu.add_report2arm(245,'$RM_DRU1');
umu.add_report2arm(246,'$RM_DRU1');
umu.add_report2arm(247,'$RM_DRU1');
umu.add_report2arm(250,'$RM_DRU1');
umu.add_report2arm(253,'$RM_DRU1');
umu.add_report2arm(254,'$RM_DRU1');
umu.add_report2arm(256,'$RM_DRU1');
umu.add_report2arm(257,'$RM_DRU1');
umu.add_report2arm(259,'$RM_DRU1');
umu.add_report2arm(260,'$RM_DRU1');
umu.add_report2arm(261,'$RM_DRU1');
umu.add_report2arm(262,'$RM_DRU1');
umu.add_report2arm(263,'$RM_DRU1');
umu.add_report2arm(264,'$RM_DRU1');
umu.add_report2arm(265,'$RM_DRU1');
umu.add_report2arm(267,'$RM_DRU1');
umu.add_report2arm(268,'$RM_DRU1');
umu.add_report2arm(269,'$RM_DRU1');
umu.add_report2arm(270,'$RM_DRU1');
umu.add_report2arm(271,'$RM_DRU1');
umu.add_report2arm(272,'$RM_DRU1');
umu.add_report2arm(273,'$RM_DRU1');
umu.add_report2arm(275,'$RM_DRU1');
umu.add_report2arm(276,'$RM_DRU1');
umu.add_report2arm(279,'$RM_DRU1');
umu.add_report2arm(282,'$RM_DRU1');
umu.add_report2arm(283,'$RM_DRU1');
umu.add_report2arm(284,'$RM_DRU1');
umu.add_report2arm(285,'$RM_DRU1');
umu.add_report2arm(286,'$RM_DRU1');
umu.add_report2arm(287,'$RM_DRU1');
umu.add_report2arm(288,'$RM_DRU1');
umu.add_report2arm(291,'$RM_DRU1');
umu.add_report2arm(292,'$RM_DRU1');
umu.add_report2arm(293,'$RM_DRU1');
umu.add_report2arm(294,'$RM_DRU1');
umu.add_report2arm(296,'$RM_DRU1');
umu.add_report2arm(301,'$RM_DRU1');
umu.add_report2arm(302,'$RM_DRU1');
umu.add_report2arm(303,'$RM_DRU1');
umu.add_report2arm(304,'$RM_DRU1');
umu.add_report2arm(306,'$RM_DRU1');
umu.add_report2arm(308,'$RM_DRU1');
umu.add_report2arm(312,'$RM_DRU1');
umu.add_report2arm(314,'$RM_DRU1');
umu.add_report2arm(315,'$RM_DRU1');
umu.add_report2arm(320,'$RM_DRU1');
umu.add_report2arm(323,'$RM_DRU1');
umu.add_report2arm(329,'$RM_DRU1');
umu.add_report2arm(330,'$RM_DRU1');
umu.add_report2arm(331,'$RM_DRU1');
umu.add_report2arm(332,'$RM_DRU1');
umu.add_report2arm(333,'$RM_DRU1');
umu.add_report2arm(334,'$RM_DRU1');
umu.add_report2arm(335,'$RM_DRU1');
umu.add_report2arm(336,'$RM_DRU1');
umu.add_report2arm(340,'$RM_DRU1');
umu.add_report2arm(342,'$RM_DRU1');
umu.add_report2arm(343,'$RM_DRU1');
umu.add_report2arm(344,'$RM_DRU1');
umu.add_report2arm(345,'$RM_DRU1');
umu.add_report2arm(346,'$RM_DRU1');
umu.add_report2arm(347,'$RM_DRU1');
umu.add_report2arm(348,'$RM_DRU1');
umu.add_report2arm(349,'$RM_DRU1');
umu.add_report2arm(350,'$RM_DRU1');
umu.add_report2arm(351,'$RM_DRU1');
umu.add_report2arm(356,'$RM_DRU1');
umu.add_report2arm(358,'$RM_DRU1');
umu.add_report2arm(360,'$RM_DRU1');
umu.add_report2arm(365,'$RM_DRU1');
umu.add_report2arm(367,'$RM_DRU1');
umu.add_report2arm(370,'$RM_DRU1');
umu.add_report2arm(375,'$RM_DRU1');
umu.add_report2arm(376,'$RM_DRU1');
umu.add_report2arm(377,'$RM_DRU1');
umu.add_report2arm(379,'$RM_DRU1');
umu.add_report2arm(380,'$RM_DRU1');
umu.add_report2arm(385,'$RM_DRU1');
umu.add_report2arm(402,'$RM_DRU1');
umu.add_report2arm(403,'$RM_DRU1');
umu.add_report2arm(404,'$RM_DRU1');
umu.add_report2arm(405,'$RM_DRU1');
umu.add_report2arm(406,'$RM_DRU1');
umu.add_report2arm(407,'$RM_DRU1');
umu.add_report2arm(408,'$RM_DRU1');
umu.add_report2arm(409,'$RM_DRU1');
umu.add_report2arm(410,'$RM_DRU1');
umu.add_report2arm(411,'$RM_DRU1');
umu.add_report2arm(412,'$RM_DRU1');
umu.add_report2arm(413,'$RM_DRU1');
umu.add_report2arm(414,'$RM_DRU1');
umu.add_report2arm(415,'$RM_DRU1');
umu.add_report2arm(416,'$RM_DRU1');
umu.add_report2arm(421,'$RM_DRU1');
umu.add_report2arm(423,'$RM_DRU1');
umu.add_report2arm(424,'$RM_DRU1');
umu.add_report2arm(425,'$RM_DRU1');
umu.add_report2arm(426,'$RM_DRU1');
umu.add_report2arm(427,'$RM_DRU1');
umu.add_report2arm(428,'$RM_DRU1');
umu.add_report2arm(429,'$RM_DRU1');
umu.add_report2arm(435,'$RM_DRU1');
umu.add_report2arm(437,'$RM_DRU1');
umu.add_report2arm(438,'$RM_DRU1');
umu.add_report2arm(439,'$RM_DRU1');
umu.add_report2arm(440,'$RM_DRU1');
umu.add_report2arm(441,'$RM_DRU1');
umu.add_report2arm(444,'$RM_DRU1');
umu.add_report2arm(449,'$RM_DRU1');
umu.add_report2arm(450,'$RM_DRU1');
umu.add_report2arm(456,'$RM_DRU1');
umu.add_report2arm(457,'$RM_DRU1');
umu.add_report2arm(479,'$RM_DRU1');
umu.add_report2arm(480,'$RM_DRU1');
umu.add_report2arm(481,'$RM_DRU1');
umu.add_report2arm(490,'$RM_DRU1');
umu.add_report2arm(491,'$RM_DRU1');
umu.add_report2arm(494,'$RM_DRU1');
umu.add_report2arm(495,'$RM_DRU1');
umu.add_report2arm(496,'$RM_DRU1');
umu.add_report2arm(497,'$RM_DRU1');
umu.add_report2arm(498,'$RM_DRU1');
umu.add_report2arm(500,'$RM_DRU1');
umu.add_report2arm(501,'$RM_DRU1');
umu.add_report2arm(503,'$RM_DRU1');
umu.add_report2arm(504,'$RM_DRU1');
umu.add_report2arm(514,'$RM_DRU1');
umu.add_report2arm(515,'$RM_DRU1');
umu.add_report2arm(520,'$RM_DRU1');
umu.add_report2arm(521,'$RM_DRU1');
umu.add_report2arm(522,'$RM_DRU1');
umu.add_report2arm(523,'$RM_DRU1');
umu.add_report2arm(524,'$RM_DRU1');
umu.add_report2arm(525,'$RM_DRU1');
umu.add_report2arm(530,'$RM_DRU1');
umu.add_report2arm(531,'$RM_DRU1');
umu.add_report2arm(542,'$RM_DRU1');
umu.add_report2arm(543,'$RM_DRU1');
umu.add_report2arm(546,'$RM_DRU1');
umu.add_report2arm(547,'$RM_DRU1');
umu.add_report2arm(565,'$RM_DRU1');
umu.add_report2arm(566,'$RM_DRU1');
umu.add_report2arm(579,'$RM_DRU1');
umu.add_report2arm(582,'$RM_DRU1');
umu.add_report2arm(585,'$RM_DRU1');
umu.add_report2arm(586,'$RM_DRU1');
umu.add_report2arm(587,'$RM_DRU1');
umu.add_report2arm(588,'$RM_DRU1');
umu.add_report2arm(589,'$RM_DRU1');
umu.add_report2arm(591,'$RM_DRU1');
umu.add_report2arm(593,'$RM_DRU1');
umu.add_report2arm(594,'$RM_DRU1');
umu.add_report2arm(595,'$RM_DRU1');
umu.add_report2arm(596,'$RM_DRU1');
umu.add_report2arm(597,'$RM_DRU1');
umu.add_report2arm(598,'$RM_DRU1');
umu.add_report2arm(599,'$RM_DRU1');
umu.add_report2arm(600,'$RM_DRU1');
umu.add_report2arm(601,'$RM_DRU1');
umu.add_report2arm(602,'$RM_DRU1');
umu.add_report2arm(605,'$RM_DRU1');
umu.add_report2arm(607,'$RM_DRU1');
umu.add_report2arm(670,'$RM_DRU1');
umu.add_report2arm(674,'$RM_DRU1');
umu.add_report2arm(675,'$RM_DRU1');
umu.add_report2arm(678,'$RM_DRU1');
umu.add_report2arm(679,'$RM_DRU1');
umu.add_report2arm(684,'$RM_DRU1');
umu.add_report2arm(685,'$RM_DRU1');
umu.add_report2arm(687,'$RM_DRU1');
umu.add_report2arm(688,'$RM_DRU1');
umu.add_report2arm(699,'$RM_DRU1');
umu.add_report2arm(701,'$RM_DRU1');
umu.add_report2arm(702,'$RM_DRU1');
umu.add_report2arm(703,'$RM_DRU1');
umu.add_report2arm(706,'$RM_DRU1');
umu.add_report2arm(707,'$RM_DRU1');
umu.add_report2arm(708,'$RM_DRU1');
umu.add_report2arm(709,'$RM_DRU1');
umu.add_report2arm(764,'$RM_DRU1');
umu.add_report2arm(767,'$RM_DRU1');
umu.add_report2arm(771,'$RM_DRU1');
umu.add_report2arm(772,'$RM_DRU1');
umu.add_report2arm(773,'$RM_DRU1');
umu.add_report2arm(781,'$RM_DRU1');
umu.add_report2arm(782,'$RM_DRU1');
umu.add_report2arm(786,'$RM_DRU1');
umu.add_report2arm(787,'$RM_DRU1');
umu.add_report2arm(788,'$RM_DRU1');
umu.add_report2arm(800,'$RM_DRU1');
umu.add_report2arm(801,'$RM_DRU1');
umu.add_report2arm(871,'$RM_DRU1');
umu.add_report2arm(872,'$RM_DRU1');
umu.add_report2arm(881,'$RM_DRU1');
umu.add_report2arm(949,'$RM_DRU1');
umu.add_report2arm(951,'$RM_DRU1');
umu.add_report2arm(952,'$RM_DRU1');
umu.add_report2arm(953,'$RM_DRU1');
umu.add_report2arm(955,'$RM_DRU1');
umu.add_report2arm(956,'$RM_DRU1');
umu.add_report2arm(959,'$RM_DRU1');
umu.add_report2arm(961,'$RM_DRU1');
umu.add_report2arm(962,'$RM_DRU1');
umu.add_report2arm(963,'$RM_DRU1');
umu.add_report2arm(964,'$RM_DRU1');
umu.add_report2arm(967,'$RM_DRU1');
umu.add_report2arm(999,'$RM_DRU1');
umu.add_report2arm(1000,'$RM_DRU1');
umu.add_report2arm(1001,'$RM_DRU1');
umu.add_report2arm(1002,'$RM_DRU1');
umu.add_report2arm(1005,'$RM_DRU1');
umu.add_report2arm(1006,'$RM_DRU1');
umu.add_report2arm(1007,'$RM_DRU1');
umu.add_report2arm(1008,'$RM_DRU1');
umu.add_report2arm(1012,'$RM_DRU1');
umu.add_report2arm(1050,'$RM_DRU1');
umu.add_report2arm(1102,'$RM_DRU1');
umu.add_report2arm(1315,'$RM_DRU1');
umu.add_report2arm(3012,'$RM_DRU1');
umu.add_report2arm(3016,'$RM_DRU1');
umu.add_report2arm(3017,'$RM_DRU1');
umu.add_report2arm(3022,'$RM_DRU1');
umu.add_report2arm(3031,'$RM_DRU1');
umu.add_report2arm(3038,'$RM_DRU1');
umu.add_report2arm(3041,'$RM_DRU1');
umu.add_report2arm(3042,'$RM_DRU1');
umu.add_report2arm(3043,'$RM_DRU1');
umu.add_report2arm(3120,'$RM_DRU1');
umu.add_report2arm(3121,'$RM_DRU1');
umu.add_report2arm(4000,'$RM_DRU1');
umu.add_report2arm(4001,'$RM_DRU1');
umu.add_report2arm(4011,'$RM_DRU1');
umu.add_report2arm(4017,'$RM_DRU1');
umu.add_report2arm(5042,'$RM_DRU1');
umu.add_report2arm(5043,'$RM_DRU1');
umu.add_report2arm(5044,'$RM_DRU1');
umu.add_report2arm(5045,'$RM_DRU1');
umu.add_report2arm(5046,'$RM_DRU1');
umu.add_report2arm(5047,'$RM_DRU1');
umu.add_report2arm(5048,'$RM_DRU1');
umu.add_report2arm(5099,'$RM_DRU1');
umu.add_report2arm(5502,'$RM_DRU1');
umu.add_report2arm(7111,'$RM_DRU1');
umu.add_report2arm(14000,'$RM_DRU1');
umu.add_report2arm(100073,'$RM_DRU1');
umu.add_report2arm(100502,'$RM_DRU1');
umu.add_report2arm(100516,'$RM_DRU1');
umu.add_report2arm(100517,'$RM_DRU1');
umu.add_report2arm(1000510,'$RM_DRU1');
umu.add_report2arm(1000511,'$RM_DRU1');
umu.add_report2arm(1000550,'$RM_DRU1');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_DRU1.sql =========**
PROMPT ===================================================================================== 
