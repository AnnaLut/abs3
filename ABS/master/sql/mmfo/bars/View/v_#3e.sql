PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_#3E.sql =========*** Run *** ========
PROMPT ===================================================================================== 

PROMPT *** Create  view V_#3E ***


CREATE OR REPLACE FORCE VIEW "BARS"."V_#3E"  AS 
  select v.REPORT_DATE
     , v.KF
     , v.VERSION_ID
     , extractValue( COLUMN_VALUE, 'DATA/EKP'    ) as EKP
     , extractValue( COLUMN_VALUE, 'DATA/NN'     ) as NN
     , extractValue( COLUMN_VALUE, 'DATA/Q003_1' ) as Q003_1
     , extractValue( COLUMN_VALUE, 'DATA/Q003_2' ) as Q003_2
     , extractValue( COLUMN_VALUE, 'DATA/Q007_1' ) as Q007_1
     , extractValue( COLUMN_VALUE, 'DATA/S031'   ) as S031
     , extractValue( COLUMN_VALUE, 'DATA/Q003_3' ) as Q003_3
     , extractValue( COLUMN_VALUE, 'DATA/Q007_2' ) as Q007_2
     , extractValue( COLUMN_VALUE, 'DATA/Q003_5' ) as Q003_5
     , extractValue( COLUMN_VALUE, 'DATA/Q007_5' ) as Q007_5
     , extractValue( COLUMN_VALUE, 'DATA/Q007_6' ) as Q007_6
     , extractValue( COLUMN_VALUE, 'DATA/R030'   ) as R030
     , extractValue( COLUMN_VALUE, 'DATA/T070_10') as T070_10
     , extractValue( COLUMN_VALUE, 'DATA/T071'   ) as T071
     , extractValue( COLUMN_VALUE, 'DATA/T070_18') as T070_18
     , extractValue( COLUMN_VALUE, 'DATA/T070_19') as T070_19
     , extractValue( COLUMN_VALUE, 'DATA/K014'   ) as K014
     , extractValue( COLUMN_VALUE, 'DATA/Q001_4' ) as Q001_4
     , extractValue( COLUMN_VALUE, 'DATA/K020_2' ) as K020_2
     , extractValue( COLUMN_VALUE, 'DATA/S080_1' ) as S080_1
     , extractValue( COLUMN_VALUE, 'DATA/S080_2' ) as S080_2
     , extractValue( COLUMN_VALUE, 'DATA/T080'   ) as T080
     , extractValue( COLUMN_VALUE, 'DATA/F093'   ) as F093
     , extractValue( COLUMN_VALUE, 'DATA/F094'   ) as F094
     , extractValue( COLUMN_VALUE, 'DATA/Q001_5' ) as Q001_5
     , extractValue( COLUMN_VALUE, 'DATA/Q015_3' ) as Q015_3
     , extractValue( COLUMN_VALUE, 'DATA/Q015_4' ) as Q015_4
     , extractValue( COLUMN_VALUE, 'DATA/Q001_6' ) as Q001_6
     , extractValue( COLUMN_VALUE, 'DATA/K020_3' ) as K020_3
     , extractValue( COLUMN_VALUE, 'DATA/T070_11') as T070_11
     , extractValue( COLUMN_VALUE, 'DATA/T070_20') as T070_20
     , extractValue( COLUMN_VALUE, 'DATA/F095'   ) as F095
     , extractValue( COLUMN_VALUE, 'DATA/KU_2'   ) as KU_2
     , extractValue( COLUMN_VALUE, 'DATA/Q002_4' ) as Q002_4
     , extractValue( COLUMN_VALUE, 'DATA/Q002_5' ) as Q002_5
     , extractValue( COLUMN_VALUE, 'DATA/Q002_6' ) as Q002_6
     , extractValue( COLUMN_VALUE, 'DATA/F017_2' ) as F017_2
     , extractValue( COLUMN_VALUE, 'DATA/Q007_7' ) as Q007_7
     , extractValue( COLUMN_VALUE, 'DATA/F018_2' ) as F018_2
     , extractValue( COLUMN_VALUE, 'DATA/Q007_8' ) as Q007_8
     , extractValue( COLUMN_VALUE, 'DATA/F096'   ) as F096
     , extractValue( COLUMN_VALUE, 'DATA/T070_12') as T070_12
     , extractValue( COLUMN_VALUE, 'DATA/T070_13') as T070_13
     , extractValue( COLUMN_VALUE, 'DATA/T070_14') as T070_14
  from NBUR_REF_FILES f
     , NBUR_LST_FILES v
     , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
 where f.ID        = v.FILE_ID
   and f.FILE_CODE = '#3E'
   and f.FILE_FMT  = 'XML'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

   COMMENT ON TABLE "BARS"."V_#3E"  IS '���� 3EX - ������� �� ��������� �� ��� (��������� �������� �����)';

   COMMENT ON COLUMN "BARS"."V_#3E"."EKP" IS '��� ���������';
   COMMENT ON COLUMN "BARS"."V_#3E"."NN" IS '�������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q003_1" IS '������� ���������� ����� ���������� ��������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q003_2" IS '����� ���������� ��������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q007_1" IS '���� ���������� ��������';
   COMMENT ON COLUMN "BARS"."V_#3E"."S031" IS '��� ������������ �������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q003_3" IS '����� �������� �������/�������, �� � ������������� �� ��������� ���������.';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q007_2" IS '���� �������� �������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q003_5" IS '����� ���������� �������� �� ������ �� �������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q007_5" IS '���� ��������� ���������� �������� �� ������ �� �������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q007_6" IS 'ʳ����� ���� 䳿 ���������� �������� �� ������ � �������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."R030" IS '�������� ��� ������, � ��� ���� ������ ������';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_10" IS '���� ������� �� ���� ���������� �������� �������';
   COMMENT ON COLUMN "BARS"."V_#3E"."T071" IS '����  ������� �� ����� ���� � ����� ������';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_18" IS '����������� ��������� ������� ������� �� ����� ����';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_19" IS '��������� ������� ������� �� ����� ����';
   COMMENT ON COLUMN "BARS"."V_#3E"."K014" IS '������ ������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q001_4" IS '������������ ������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."K020_2" IS '��� ������������ �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."S080_1" IS '���� ������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."S080_2" IS '���� ������������ �� ����� ����';
   COMMENT ON COLUMN "BARS"."V_#3E"."T080" IS 'ʳ������ ��� ����������';
   COMMENT ON COLUMN "BARS"."V_#3E"."F093" IS '��� ������ ���� ����������� ����������� �� ������ ������ �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."F094" IS '��� ������ ���� ��������� ������� �� �������������� �������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q001_5" IS '����� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q015_3" IS '������� ������� ��������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q015_4" IS 'ʳ������ ��������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q001_6" IS '������������ ������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."K020_3" IS '��� ������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_11" IS '�������� ������� ����� �� ��������� �������';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_20" IS '������� ������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."F095" IS '��� ������ ���� ������� ������������� ���������� �� ��������� ��������� �� ������ �� �������������';
   COMMENT ON COLUMN "BARS"."V_#3E"."KU_2" IS '��� ��������������-������������ ������� ������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q002_4" IS '����� ��������������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q002_5" IS '���������� ����� ��������������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q002_6" IS '̳�������������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."F017_2" IS '���� ����� �� ��������� �����������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q007_7" IS '���� �������� ��������  ����� ����� ������';
   COMMENT ON COLUMN "BARS"."V_#3E"."F018_2" IS '���� ����� �� ���� �������� ��������';
   COMMENT ON COLUMN "BARS"."V_#3E"."Q007_8" IS '���� ��������� �������� ����������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."F096" IS '��� �������� ���������';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_12" IS '���� ��������� �����, �� �������� ������������� ����� �� ��������� ��������� �������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_13" IS '���� �� ���������, �� �������� ������������� ����� �� ��������� ��������� �������� �����';
   COMMENT ON COLUMN "BARS"."V_#3E"."T070_14" IS '���� ���, , �� �������� ������������� ����� �� ��������� ��������� �������� �����';

  GRANT SELECT ON "BARS"."V_#3E" TO "UPLD";
  GRANT SELECT ON "BARS"."V_#3E" TO "BARSREADER_ROLE";
  GRANT SELECT ON "BARS"."V_#3E" TO "BARS_ACCESS_DEFROLE";


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_#3E.sql =========*** End *** ========
PROMPT ===================================================================================== 
