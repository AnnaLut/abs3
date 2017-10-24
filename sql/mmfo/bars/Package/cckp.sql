
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cckp.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCKP IS

/**
 * CCKP - ����� ��� ��������������� ��������

...14.08.2006 MARY + ������� nazn_insurance, nazn_zalog, nazn_por_fiz
                   + ��������� LK_Close

   10.05.2006 SERG ��������� ������� header_version, body_version

   26.01.2006 SERG ��������� cc_open() ������ �� ��������� ������
				������ ��� ������ � ����
   31.07.2006 TVSUKHOV ��������������� ������ ��������� �� CCKP � CCWebPK
 */


G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 2.0 10/05/2006';

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2;



END CCkP;
 
/

 show err;
 
PROMPT *** Create  grants  CCKP ***
grant EXECUTE                                                                on CCKP            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cckp.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 