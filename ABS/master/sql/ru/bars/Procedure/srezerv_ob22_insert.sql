

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SREZERV_OB22_INSERT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SREZERV_OB22_INSERT ***

  CREATE OR REPLACE PROCEDURE BARS.SREZERV_OB22_INSERT ( p_mode int) is
begin
   delete from SREZERV_OB22;
   If    p_mode = 0 then goto OLD_ ;  -- стара€ верси€
   elsIf p_mode = 1 then goto NEW_ ;  -- нова€а€ верси€
   else RETURN;
   end if;
--------------------------------------
<<OLD_>> null;
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2062', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2063', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2063', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2067', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2067', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2069', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2069', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2071', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2071', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2077', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2077', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2079', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2079', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2082', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2082', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2083', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2083', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2087', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2087', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2089', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2089', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2102', '0', '0', '2', '0',
    '2400', '05', '7702', '13', '7702',
    '16', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2103', '0', '0', '2', '0',
    '2400', '05', '7702', '13', '7702',
    '16', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2107', '0', '0', '2', '0',
    '2400', '05', '7702', '13', '7702',
    '16', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2400', '43', '7702', '51', '7702',
    '58', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2400', '17', '7702', '51', '7702',
    '58', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2109', '0', '0', '0', '0',
    '2400', '17', '7702', '51', '7702',
    '58', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2112', '0', '0', '2', '0',
    '2400', '21', '7702', '44', '7702',
    '45', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2113', '0', '0', '2', '0',
    '2400', '21', '7702', '44', '7702',
    '45', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2117', '0', '0', '2', '0',
    '2400', '21', '7702', '44', '7702',
    '45', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2400', '44', '7702', '52', '7702',
    '59', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2400', '18', '7702', '52', '7702',
    '59', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2119', '0', '0', '0', '0',
    '2400', '18', '7702', '52', '7702',
    '59', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2122', '0', '0', '2', '0',
    '2400', '05', '7702', '13', '7702',
    '16', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2123', '0', '0', '2', '0',
    '2400', '05', '7702', '13', '7702',
    '16', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2127', '0', '0', '2', '0',
    '2400', '05', '7702', '13', '7702',
    '16', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2400', '43', '7702', '51', '7702',
    '58', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1410', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 1, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2400', '17', '7702', '51', '7702',
    '58', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2129', '0', '0', '0', '0',
    '2400', '17', '7702', '51', '7702',
    '58', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1410', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 1, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2132', '0', '0', '2', '0',
    '2400', '21', '7702', '44', '7702',
    '45', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2133', '0', '0', '2', '0',
    '2400', '21', '7702', '44', '7702',
    '45', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1411', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 1, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2137', '0', '0', '2', '0',
    '2400', '21', '7702', '44', '7702',
    '45', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2400', '44', '7702', '52', '7702',
    '59', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1411', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 1, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2400', '18', '7702', '52', '7702',
    '59', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2139', '0', '0', '0', '0',
    '2400', '18', '7702', '52', '7702',
    '59', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1412', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 1, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1412', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 1, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '0', '0', '3', '0',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '01', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1413', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 1, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '01', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1413', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 1, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '08', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1414', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 1, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '08', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '09', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1417', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 1, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '09', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1418', '0', '0', '0', '0',
    '1490', '03', '7703', '21', '7703',
    '22', 1, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1418', '0', '0', '0', '0',
    '1490', '04', '7703', '21', '7703',
    '22', 1, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '10', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '10', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '11', '0', '0', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1419', '0', '0', '0', '0',
    '1490', '04', '7703', '21', '7703',
    '22', 1, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '11', '0', '0', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '12', '0', '0', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1420', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '12', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '13', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1420', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '13', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '14', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1421', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1421', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '14', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1422', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '15', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1422', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1423', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1423', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1424', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1424', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '15', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1428', '0', '0', '0', '0',
    '1491', '03', '7704', '13', '7704',
    '14', 1, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1428', '0', '0', '0', '0',
    '1491', '04', '7704', '13', '7704',
    '14', 1, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1429', '0', '0', '0', '0',
    '1491', '04', '7704', '13', '7704',
    '14', 1, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1500', '0', '0', '0', '0',
    '1592', '02', '7701', '10', '7701',
    '12', 1, '0', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1500', '0', '0', '0', '0',
    '1592', '01', '7701', '09', '7701',
    '11', 1, '1', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1508', '0', '0', '1', '0',
    '1592', '04', '7701', '24', '7701',
    '27', 1, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '16', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1509', '01', '0', '1', '0',
    '1592', '05', '7701', '24', '7701',
    '27', 1, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1517', '0', '0', '0', '0',
    '1590', '02', '7701', '05', '7701',
    '06', 1, '0', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '16', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1517', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 1, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '18', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1521', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 1, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1522', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 1, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1523', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 1, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1524', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 1, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1527', '0', '0', '0', '0',
    '1590', '02', '7701', '05', '7701',
    '06', 1, '0', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '18', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '21', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1527', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 1, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1528', '0', '0', '1', '0',
    '1590', '06', '7701', '23', '7701',
    '26', 1, '1', 6);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1528', '0', '0', '1', '0',
    '1590', '08', '7701', '23', '7701',
    '26', 1, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1529', '0', '0', '1', '0',
    '1590', '08', '7701', '23', '7701',
    '26', 1, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1811', '0', '0', '0', '0',
    '1890', '02', '7700', '02', '7700',
    '04', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1819', '0', '0', '0', '0',
    '1890', '03', '7700', '07', '7700',
    '09', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2020', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '21', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2020', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2027', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '23', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '23', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2027', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2029', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2029', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2030', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2030', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2037', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2037', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2039', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2039', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2062', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2232', '0', '0', '3', '0',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '38', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '38', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '840',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '840',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '41', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '41', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '45', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '45', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '46', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '46', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '47', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '840',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '47', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '48', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '48', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '49', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '49', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '50', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '978',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '978',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '978',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '980',
    '2400', '10', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '980',
    '2400', '09', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '980',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '840',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '840',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '840',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '978',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '978',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '978',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '980',
    '2400', '10', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '980',
    '2400', '09', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '980',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '0',
    '2400', '41', '7702', '65', '7702',
    '67', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '840',
    '2400', '19', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '840',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '50', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '840',
    '2400', '37', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '51', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '978',
    '2400', '19', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '51', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '978',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '978',
    '2400', '37', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '980',
    '2400', '20', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '980',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '980',
    '2400', '38', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '840',
    '2400', '19', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '840',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '840',
    '2400', '37', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '978',
    '2400', '19', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '978',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '978',
    '2400', '37', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '980',
    '2400', '20', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '980',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '980',
    '2400', '38', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2600', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2600', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2605', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 2, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2605', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 2, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2625', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2625', '0', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2625', '0', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2400', '41', '7702', '65', '7702',
    '67', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '01', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '01', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '02', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '02', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '03', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '03', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '04', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '04', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '07', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '07', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '08', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '08', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '09', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '09', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '10', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '10', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '11', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '11', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '12', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '12', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '13', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '13', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '14', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '14', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '15', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '15', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '16', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '16', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '17', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '17', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '18', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '18', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '19', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '19', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '20', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '20', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '21', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '21', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2657', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2800', '0', '0', '0', '0',
    '2890', '03', '7705', '11', '7705',
    '13', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2801', '0', '0', '0', '0',
    '2890', '03', '7705', '11', '7705',
    '13', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '09', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '13', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '14', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '15', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '16', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '17', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '18', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '19', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '20', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '23', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '24', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '25', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '27', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '28', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '29', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '30', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '31', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '32', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '33', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '34', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '35', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '36', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3102', '01', '0', '0', '0',
    '3190', '05', '7703', '07', '7703',
    '08', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3102', '02', '0', '0', '0',
    '3190', '03', '7703', '03', '7703',
    '16', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3103', '0', '0', '0', '0',
    '3190', '03', '7703', '03', '7703',
    '16', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3105', '0', '0', '0', '0',
    '3190', '03', '7703', '03', '7703',
    '16', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3110', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 1, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3111', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 1, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3112', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 1, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3113', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 1, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '52', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '52', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3212', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3213', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3213', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3214', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3214', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3218', '01', '0', '0', '0',
    '3290', '04', '7704', '05', '7704',
    '07', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3218', '02', '0', '0', '0',
    '3290', '03', '7704', '05', '7704',
    '07', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3218', '03', '0', '0', '0',
    '3290', '04', '7704', '05', '7704',
    '07', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3219', '0', '0', '0', '0',
    '3290', '03', '7704', '05', '7704',
    '07', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3510', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3519', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3540', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3541', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3548', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3550', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3551', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3552', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3559', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '01', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '01', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '02', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '02', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '03', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '03', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '04', '0', '0', '0',
    '3599', '32', '7720', '32', '7720',
    '37', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '04', '0', '0', '0',
    '3599', '14', '7720', '32', '7720',
    '37', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '09', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '09', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '11', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '11', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '13', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '13', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '14', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '14', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '15', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '15', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '16', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '16', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '17', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '17', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '18', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '18', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '19', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '19', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '20', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '20', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '21', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '21', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '22', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '22', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '23', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '23', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '24', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '24', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '25', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '25', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '26', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '26', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '27', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '27', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '28', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '28', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '29', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '29', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '30', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '30', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '31', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '31', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '32', '0', '0', '0',
    '3599', '33', '7720', '30', '7720',
    '35', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '32', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '33', '0', '0', '0',
    '3599', '32', '7720', '31', '7720',
    '36', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '33', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '01', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '01', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '05', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '05', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '09', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '09', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '15', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '15', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '17', '0', '0', '0',
    '3599', '31', '7720', '44', '7720',
    '45', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '17', '0', '0', '0',
    '3599', '18', '7720', '44', '7720',
    '45', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '19', '0', '2', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '19', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '21', '0', '3', '0',
    '3599', '28', '7720', '42', '7720',
    '43', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '21', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '24', '0', '2', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '24', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '26', '0', '2', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '26', '0', '2', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '28', '0', '3', '0',
    '3599', '28', '7720', '42', '7720',
    '43', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '28', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '30', '0', '2', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '30', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '32', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '32', '0', '3', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '33', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '33', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '34', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 9, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '34', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '35', '0', '0', '0',
    '3599', '36', '7720', '48', '7720',
    '49', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '35', '0', '0', '0',
    '3599', '35', '7720', '48', '7720',
    '49', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '36', '0', '0', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '36', '0', '0', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '07', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '08', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '09', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '19', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '23', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '24', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '31', '0', '3', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '33', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '35', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '37', '0', '0', '0',
    '3599', '14', '7720', '32', '7720',
    '37', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '39', '0', '0', '0',
    '3599', '18', '7720', '44', '7720',
    '45', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '47', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '50', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '54', '0', '0', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '57', '0', '2', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '60', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '63', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '66', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '67', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '68', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '69', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '70', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '71', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '72', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '73', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '74', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '75', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '76', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '77', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3114', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 1, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3114', '0', '0', '0', '0',
    '3190', '02', '7703', '02', '7703',
    '05', 1, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3117', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 1, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3118', '0', '0', '0', '0',
    '3190', '06', '7703', '09', '7703',
    '13', 1, '0', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3118', '0', '0', '0', '0',
    '3190', '07', '7703', '09', '7703',
    '13', 1, '7', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3119', '0', '0', '0', '0',
    '3190', '07', '7703', '09', '7703',
    '13', 1, '7', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3210', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3210', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3211', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3211', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 1, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3212', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '01', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '01', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '22', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '22', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '27', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '27', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '33', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '33', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '34', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '34', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '53', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '53', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '56', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '56', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '57', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '57', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '58', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '58', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '59', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '59', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '60', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '60', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '0', '0', '3', '0',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '11', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '11', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '15', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '15', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '16', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '16', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '29', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '29', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '32', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '32', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '36', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '36', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '37', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '37', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '38', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '38', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '39', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '39', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '40', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '40', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '41', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '41', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '42', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '42', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '43', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '43', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '44', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '44', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '46', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '46', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '47', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '47', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '48', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '48', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '49', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '49', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '50', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '50', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '0', '0', '3', '0',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '01', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '01', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '20', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '20', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '23', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '23', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '26', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '26', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '32', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '32', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'A1', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'A1', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'A6', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'A6', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'A7', '0', '3', '0',
    '2401', '06', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'A7', '0', '3', '0',
    '2401', '07', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B4', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B4', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B6', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B6', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B7', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B7', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B8', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B8', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B9', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'B9', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C1', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C1', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C2', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C2', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C3', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C3', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C4', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C4', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C5', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C5', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C6', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C6', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C7', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C7', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C8', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C8', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C9', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'C9', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D0', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D0', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D1', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D1', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D2', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D2', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D3', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D3', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D9', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'D9', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E0', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E0', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E1', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E1', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E2', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E2', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E3', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E3', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E4', '0', '3', '0',
    '2401', '10', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E4', '0', '3', '0',
    '2401', '11', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E5', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E5', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E6', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E6', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E7', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E7', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E8', '0', '3', '0',
    '2401', '08', '7702', '75', '7702',
    '77', 3, '8', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', 'E8', '0', '3', '0',
    '2401', '09', '7702', '76', '7702',
    '78', 3, '9', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2400', '41', '7702', '65', '7702',
    '67', 9, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'C2', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'C2', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'C4', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'C4', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D1', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D1', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D3', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D3', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D4', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D4', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D5', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D5', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D6', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D6', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D7', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D7', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D8', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D8', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D9', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'D9', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E0', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E0', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E1', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E1', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E2', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E2', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E3', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E3', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E4', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E4', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E5', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E5', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E6', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E6', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E7', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E7', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E8', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E8', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E9', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'E9', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F3', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F3', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F4', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F4', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F5', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F5', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F6', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F6', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F7', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F7', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F8', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F8', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F9', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'F9', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'G0', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'G0', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'G1', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'G1', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'G2', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'G2', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 9, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '0', '0', '0', '0',
    '2400', '40', '7702', '73', '7702',
    '74', 9, '2', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '06', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '06', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '42', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '42', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '52', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '52', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '64', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '64', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '66', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '66', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'C4', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'C4', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'D5', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'D5', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'D7', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'D7', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E5', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E5', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E7', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E7', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E8', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E8', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E9', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'E9', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F0', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F0', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F1', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F1', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F2', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F2', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F3', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F3', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F4', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F4', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F5', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F5', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F6', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F6', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F7', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F7', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F8', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F8', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F9', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'F9', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G0', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G0', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G1', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G1', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G2', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G2', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G3', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G3', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G9', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'G9', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H0', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H0', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H1', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H1', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H2', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H2', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H3', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H3', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H4', '0', '0', '0',
    '2401', '16', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H4', '0', '0', '0',
    '2401', '17', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H5', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H5', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H6', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H6', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H7', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H7', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H8', '0', '0', '0',
    '2401', '14', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', 'H8', '0', '0', '0',
    '2401', '15', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2211', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2211', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2211', '0', '0', '3', '0',
    '2400', '39', '7702', '71', '7702',
    '72', 3, '2', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2232', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 3, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2232', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 3, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'B1', '0', '0', '0',
    '2401', '12', '7702', '79', '7702',
    '81', 9, '8', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', 'B1', '0', '0', '0',
    '2401', '13', '7702', '80', '7702',
    '82', 9, '9', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '78', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '79', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '80', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '81', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '82', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '83', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '84', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '85', '0', '0', '0',
    '3599', '12', '7720', '34', '7720',
    '39', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '86', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '87', '0', '0', '0',
    '3599', '15', '7720', '30', '7720',
    '35', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '88', '0', '0', '0',
    '3599', '11', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '89', '0', '0', '0',
    '3599', '35', '7720', '48', '7720',
    '49', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '90', '0', '0', '0',
    '3599', '37', '7720', '31', '7720',
    '36', 9, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '91', '0', '0', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 9, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3710', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9001', '0', '0', '1', '0',
    '3690', '15', '7706', '19', '7706',
    '20', 1, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9020', '0', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 2, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9023', '01', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 2, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9122', '0', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 2, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9129', '0', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 2, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9129', '0', '0', '3', '0',
    '3690', '06', '7706', '11', '7706',
    '12', 3, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9999', '0', '0', '0', '0',
    '3599', '08', '7720', '23', '7720',
    '24', 9, '0', 4);
COMMIT;

 RETURN ;
--------------------------------------
<<NEW_>> null;
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2625', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2625', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2625', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2625', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2400', '41', '7702', '65', '7702',
    '67', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2401', '23', '7702', '80', '7702',
    '82', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2401', '24', '7702', '79', '7702',
    '81', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2627', '0', '0', '0', '0',
    '2401', '22', '7702', '79', '7702',
    '81', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2657', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2657', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2657', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2800', '0', '0', '0', '0',
    '2890', '03', '7705', '11', '7705',
    '13', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2801', '0', '0', '0', '0',
    '2890', '03', '7705', '11', '7705',
    '13', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '09', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '13', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '14', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '15', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '16', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '17', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '18', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '19', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '20', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '23', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '24', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '25', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '27', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '28', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '29', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '30', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '31', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '32', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '33', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '34', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '35', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2809', '36', '0', '0', '0',
    '2890', '01', '7705', '01', '7705',
    '05', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3102', '01', '0', '0', '0',
    '3190', '05', '7703', '07', '7703',
    '08', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3102', '02', '0', '0', '0',
    '3190', '03', '7703', '03', '7703',
    '16', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3103', '0', '0', '0', '0',
    '3190', '03', '7703', '03', '7703',
    '16', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3105', '0', '0', '0', '0',
    '3190', '03', '7703', '03', '7703',
    '16', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3110', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3111', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3112', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3113', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3114', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3114', '0', '0', '0', '0',
    '3190', '02', '7703', '02', '7703',
    '05', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3115', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3117', '0', '0', '0', '0',
    '3190', '01', '7703', '01', '7703',
    '06', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3118', '0', '0', '0', '0',
    '3190', '06', '7703', '09', '7703',
    '13', 0, '0', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3118', '0', '0', '0', '0',
    '3190', '07', '7703', '09', '7703',
    '13', 0, '7', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3119', '0', '0', '0', '0',
    '3190', '07', '7703', '09', '7703',
    '13', 0, '7', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3210', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3210', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3211', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3211', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3212', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3212', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3213', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3213', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3214', '0', '0', '0', '0',
    '3290', '01', '7704', '01', '7704',
    '04', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3214', '0', '0', '0', '0',
    '3290', '02', '7704', '02', '7704',
    '03', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3218', '01', '0', '0', '0',
    '3290', '04', '7704', '05', '7704',
    '07', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3218', '02', '0', '0', '0',
    '3290', '03', '7704', '05', '7704',
    '07', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3218', '03', '0', '0', '0',
    '3290', '04', '7704', '05', '7704',
    '07', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3219', '0', '0', '0', '0',
    '3290', '03', '7704', '05', '7704',
    '07', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3510', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3519', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3540', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3541', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3548', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3550', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3551', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3552', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3559', '0', '0', '0', '0',
    '3590', '01', '7705', '02', '7705',
    '06', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '01', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '01', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '02', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '02', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '03', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '03', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '04', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '04', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '09', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '09', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '11', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '11', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '13', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '13', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '14', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '14', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '15', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '15', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '16', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '16', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '17', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '17', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '18', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '18', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '19', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '19', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '20', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '20', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '21', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '21', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '22', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '22', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '23', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '23', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '24', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '24', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '25', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '25', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '26', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '26', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '27', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '27', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '28', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '28', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '29', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '29', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '30', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '30', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '31', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '31', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '32', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '32', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '33', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3570', '33', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '01', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '01', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '05', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '05', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '09', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '09', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '15', '0', '0', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '15', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '17', '0', '0', '0',
    '3599', '31', '7720', '44', '7720',
    '45', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '17', '0', '0', '0',
    '3599', '18', '7720', '44', '7720',
    '45', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '19', '0', '2', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '19', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '21', '0', '3', '0',
    '3599', '28', '7720', '42', '7720',
    '43', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '21', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '24', '0', '2', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '24', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '26', '0', '2', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '26', '0', '2', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '28', '0', '3', '0',
    '3599', '28', '7720', '42', '7720',
    '43', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '28', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '30', '0', '2', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '30', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '32', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '32', '0', '3', '0',
    '3599', '30', '7720', '33', '7720',
    '38', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '33', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '33', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '34', '0', '0', '0',
    '3599', '29', '7720', '34', '7720',
    '39', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '34', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '35', '0', '0', '0',
    '3599', '31', '7720', '44', '7720',
    '45', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '35', '0', '0', '0',
    '3599', '35', '7720', '48', '7720',
    '49', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '36', '0', '0', '0',
    '3599', '27', '7720', '40', '7720',
    '41', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3578', '36', '0', '0', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '07', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '08', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '09', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '19', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '23', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '24', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '31', '0', '3', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '33', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '35', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '37', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '39', '0', '0', '0',
    '3599', '18', '7720', '44', '7720',
    '45', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '47', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '50', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '54', '0', '0', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '57', '0', '2', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '60', '0', '3', '0',
    '3599', '17', '7720', '42', '7720',
    '43', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '63', '0', '2', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '66', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '67', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '68', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '69', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '70', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '71', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '72', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '73', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '74', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '75', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '76', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '77', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '78', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '79', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '80', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '81', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '82', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '83', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '84', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '85', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '86', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '87', '0', '0', '0',
    '3599', '13', '7720', '33', '7720',
    '38', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '88', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '89', '0', '0', '0',
    '3599', '35', '7720', '48', '7720',
    '49', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '90', '0', '0', '0',
    '3599', '11', '7720', '34', '7720',
    '39', 0, '6', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3579', '91', '0', '0', '0',
    '3599', '16', '7720', '40', '7720',
    '41', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('3710', '0', '0', '0', '0',
    '3590', '03', '7705', '15', '7705',
    '17', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9001', '0', '0', '1', '0',
    '3690', '15', '7706', '19', '7706',
    '20', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9020', '0', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9023', '01', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9122', '0', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9129', '0', '0', '2', '0',
    '3690', '07', '7706', '07', '7706',
    '08', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9129', '0', '0', '3', '0',
    '3690', '06', '7706', '11', '7706',
    '12', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('9999', '0', '0', '0', '0',
    '3599', '08', '7720', '23', '7720',
    '24', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1410', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 0, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1410', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 0, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1411', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 0, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1411', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 0, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1412', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 0, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1412', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 0, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1413', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 0, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1413', '0', '0', '0', '0',
    '1490', '02', '7703', '19', '7703',
    '20', 0, '1', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1414', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 0, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1415', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 0, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1417', '0', '0', '0', '0',
    '1490', '01', '7703', '17', '7703',
    '18', 0, '0', 3);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1418', '0', '0', '0', '0',
    '1490', '03', '7703', '21', '7703',
    '22', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1418', '0', '0', '0', '0',
    '1490', '04', '7703', '21', '7703',
    '22', 0, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1419', '0', '0', '0', '0',
    '1490', '04', '7703', '21', '7703',
    '22', 0, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1420', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1420', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1421', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1421', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1422', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1422', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1423', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1423', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1424', '0', '0', '0', '0',
    '1491', '01', '7704', '08', '7704',
    '09', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1424', '0', '0', '0', '0',
    '1491', '02', '7704', '10', '7704',
    '11', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1428', '0', '0', '0', '0',
    '1491', '03', '7704', '13', '7704',
    '14', 0, '0', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1428', '0', '0', '0', '0',
    '1491', '04', '7704', '13', '7704',
    '14', 0, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1429', '0', '0', '0', '0',
    '1491', '04', '7704', '13', '7704',
    '14', 0, '7', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1500', '0', '0', '0', '0',
    '1592', '02', '7701', '10', '7701',
    '12', 0, '0', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1500', '0', '0', '0', '0',
    '1592', '01', '7701', '09', '7701',
    '11', 0, '1', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1502', '0', '0', '0', '0',
    '1592', '01', '7701', '09', '7701',
    '11', 0, '1', 2);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1508', '0', '0', '1', '0',
    '1592', '04', '7701', '24', '7701',
    '27', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1509', '01', '0', '1', '0',
    '1592', '05', '7701', '24', '7701',
    '27', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1517', '0', '0', '0', '0',
    '1590', '02', '7701', '05', '7701',
    '06', 0, '0', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1517', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 0, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1521', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 0, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1522', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 0, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1523', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 0, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1524', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 0, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1527', '0', '0', '0', '0',
    '1590', '02', '7701', '05', '7701',
    '06', 0, '0', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1527', '0', '0', '0', '0',
    '1590', '01', '7701', '02', '7701',
    '04', 0, '1', 1);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1528', '0', '0', '1', '0',
    '1590', '06', '7701', '23', '7701',
    '26', 0, '1', 6);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1528', '0', '0', '1', '0',
    '1590', '08', '7701', '23', '7701',
    '26', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1529', '0', '0', '1', '0',
    '1590', '08', '7701', '23', '7701',
    '26', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1811', '0', '0', '0', '0',
    '1890', '02', '7700', '02', '7700',
    '04', 0, '1', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('1819', '0', '0', '0', '0',
    '1890', '03', '7700', '07', '7700',
    '09', 0, '0', NULL);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2020', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2020', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2020', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2020', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2027', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2027', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2027', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2027', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2028', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2029', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2029', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2029', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2029', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2030', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2030', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2030', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2030', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2037', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2037', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2037', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2037', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2038', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2039', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2039', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2039', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2039', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2062', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2062', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2062', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2062', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2063', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2063', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2063', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2063', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2067', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2067', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2067', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2067', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2068', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2069', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2069', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2069', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2069', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2071', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2071', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2071', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2071', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2077', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2077', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2077', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2077', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2078', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2079', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2079', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2079', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2079', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2082', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2082', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2082', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2082', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2083', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2083', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2083', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2083', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2087', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2087', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2087', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2087', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2088', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2089', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2089', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2089', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2089', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2102', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2102', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2102', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2102', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2103', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2103', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2103', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2103', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2107', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2107', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2107', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2107', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2108', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2109', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2109', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2109', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2109', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2112', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2112', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2112', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2112', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2113', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2113', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2113', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2113', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2117', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2117', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2117', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2117', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2118', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2119', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2119', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2119', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2119', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2122', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2122', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2122', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2122', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2123', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2123', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2123', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2123', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2127', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2127', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2127', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2127', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2128', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2129', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2129', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2129', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2129', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2132', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2132', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2132', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2132', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2133', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2133', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2133', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2133', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2137', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2137', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2137', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2137', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2138', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2139', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2139', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2139', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2139', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2202', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2203', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2207', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2400', '41', '7702', '65', '7702',
    '67', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2401', '23', '7702', '80', '7702',
    '82', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2401', '24', '7702', '79', '7702',
    '81', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2208', '0', '0', '0', '0',
    '2401', '22', '7702', '79', '7702',
    '81', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '0', '0', '0', '0',
    '2401', '23', '7702', '80', '7702',
    '82', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2209', '0', '0', '0', '0',
    '2401', '22', '7702', '79', '7702',
    '81', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2211', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2211', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2211', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2211', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2232', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2232', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2232', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2232', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2233', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '0',
    '2400', '06', '7702', '20', '7702',
    '64', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '0',
    '2400', '03', '7702', '11', '7702',
    '14', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '0',
    '2401', '19', '7702', '76', '7702',
    '78', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2237', '0', '0', '3', '0',
    '2401', '18', '7702', '75', '7702',
    '77', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '0',
    '2400', '41', '7702', '65', '7702',
    '67', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '0',
    '2401', '23', '7702', '80', '7702',
    '82', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '0',
    '2401', '24', '7702', '79', '7702',
    '81', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2238', '0', '0', '0', '0',
    '2401', '22', '7702', '79', '7702',
    '81', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '0',
    '2400', '19', '7702', '49', '7702',
    '60', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '0',
    '2400', '37', '7702', '65', '7702',
    '67', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '0',
    '2401', '23', '7702', '80', '7702',
    '82', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2239', '0', '0', '0', '0',
    '2401', '22', '7702', '79', '7702',
    '81', 8, 'C', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2600', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2600', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2600', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2600', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2605', '0', '0', '2', '0',
    '2400', '07', '7702', '21', '7702',
    '61', 0, '0', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2605', '0', '0', '2', '0',
    '2400', '04', '7702', '12', '7702',
    '15', 0, '1', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2605', '0', '0', '2', '0',
    '2401', '21', '7702', '87', '7702',
    '88', 8, 'A', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2605', '0', '0', '2', '0',
    '2401', '20', '7702', '83', '7702',
    '84', 8, 'B', 7);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2400', '16', '7702', '50', '7702',
    '57', 0, '0', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2400', '42', '7702', '66', '7702',
    '68', 0, '1', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2400', '36', '7702', '66', '7702',
    '68', 0, '5', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2401', '27', '7702', '89', '7702',
    '90', 8, 'A', 5);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2401', '28', '7702', '85', '7702',
    '86', 8, 'B', 4);
Insert into SREZERV_OB22
   (NBS, OB22, S080, CUSTTYPE, KV,
    NBS_REZ, OB22_REZ, NBS_7F, OB22_7F, NBS_7R,
    OB22_7R, PR, NAL, R013)
 Values
   ('2607', '0', '0', '0', '0',
    '2401', '26', '7702', '85', '7702',
    '86', 8, 'C', 5);
COMMIT;

 RETURN ;
--------------------------------------
end SREZERV_OB22_INSERT;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SREZERV_OB22_INSERT.sql =========*
PROMPT ===================================================================================== 
