-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for T0_NBS_LIST');
end;
/

-- ======================================================================================
-- ETL-21429 UPL - �������� ���������� T0_NBS_LIST ��� �������� �0 (ACNTADJBAL0) ����� �������� �� ����� ���� ������
--
-- ======================================================================================

delete from barsupl.t0_nbs_list;

Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1400', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1401', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1402', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1403', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1404', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1406', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1408', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1410', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1411', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1412', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1413', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1414', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1415', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1416', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1418', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1420', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1421', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1422', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1423', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1424', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1426', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1428', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1430', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1435', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1436', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1438', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1440', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1446', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1450', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1456', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1458', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1500', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1502', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1507', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1508', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1510', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1513', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1516', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1518', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1521', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1522', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1524', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1526', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1528', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1532', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1533', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1536', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1538', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1542', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1543', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1546', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1548', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1811', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('1819', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2020', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2026', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2028', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2030', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2036', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2038', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2063', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2065', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2066', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2068', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2071', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2072', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2073', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2074', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2076', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2078', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2083', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2086', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2088', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2103', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2106', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2108', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2113', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2116', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2118', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2123', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2126', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2128', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2133', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2136', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2138', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2203', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2206', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2208', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2211', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2216', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2218', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2220', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2226', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2228', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2233', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2236', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2238', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2301', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2303', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2306', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2308', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2310', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2311', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2316', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2318', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2320', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2321', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2326', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2328', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2330', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2331', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2336', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2338', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2340', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2341', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2346', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2348', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2351', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2353', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2356', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2358', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2360', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2361', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2362', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2363', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2366', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2368', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2370', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2371', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2372', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2373', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2376', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2378', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2380', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2381', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2382', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2383', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2386', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2388', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2390', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2391', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2392', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2393', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2394', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2395', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2396', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2398', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2401', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2403', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2406', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2408', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2410', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2411', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2416', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2418', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2420', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2421', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2426', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2428', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2431', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2433', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2436', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2438', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2450', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2451', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2452', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2453', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2456', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2458', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2600', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2605', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2607', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2620', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2625', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2627', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2650', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2657', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2800', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2801', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('2809', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3002', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3003', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3005', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3010', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3011', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3012', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3013', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3014', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3016', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3018', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3102', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3103', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3105', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3107', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3110', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3111', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3112', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3113', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3114', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3115', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3116', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3118', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3210', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3211', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3213', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3214', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3216', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3218', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3510', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3519', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3540', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3541', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3548', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3550', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3551', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3552', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3559', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3570', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3578', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3600', '9');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3600', '10');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3710', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9000', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9001', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9002', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9003', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9100', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9122', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9129', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9500', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9501', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9503', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9520', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9521', '__');
Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('9523', '__');
