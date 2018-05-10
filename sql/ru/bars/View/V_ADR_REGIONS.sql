create or replace view v_adr_regions as
select  case region_id
          when 1  then '302076'   /*�i�������*/
          when 2  then '303398'   /*���������*/
          when 3  then '305482'   /*��i�������������*/
          when 4  then '335106'   /*��������*/
          when 5  then '311647'   /*�����������*/
          when 6  then '312356'   /*������������*/
          when 7  then '313957'   /*�����i����*/
          when 8  then '336503'   /*I����-�����i�����*/
          when 9  then '300465'   /*��� */
          when 10 then '322669'   /*��� �������*/
          when 11 then '323475'   /*�i������������*/
          when 12 then '324805'   /*�������� ������.*/
          when 13 then '304665'   /*���������*/
          when 14 then '325796'   /*���i�����*/
          when 15 then '326461'   /*�����������*/
          when 16 then '328845'   /*�������*/
          when 17 then '331467'   /*����������*/
          when 18 then '333368'   /*�i��������*/
          when 19 then ''
          when 20 then '337568'   /*�������*/
          when 21 then '338545'   /*������i������*/
          when 22 then '351823'   /*����i����� */
          when 23 then '315784'   /*����������*/
          when 24 then '352457'   /*�����������*/
          when 25 then '354507'   /*���������*/
          when 26 then '356334'   /*����i������*/
          when 27 then '353553'   /*����i�i�����*/
        end MFO,
        r.region_id,
        r.region_name region_nm,
        r.region_name_ru,
        r.country_id,
        r.koatuu,
        r.iso3166_2
from ADR_REGIONS r;


GRANT SELECT ON v_adr_regions TO BARS_ACCESS_DEFROLE;
