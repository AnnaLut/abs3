begin
update META_NSIFUNCTION t
set t.custom_options = ' [{  "Value":"KF" , "Name":"���" }, 
                        {  "Value":"NUMB" , "Name":"��/�" }, 
                        {  "Value":"BRANCH" , "Name":"������� ���������, ����" }, 
                        {  "Value":"NMK" , "Name":"ϲ� �볺���" }, 
                        {  "Value":"OKPO" , "Name":"��� �볺���" }, 
                        {  "Value":"TYPEZP" , "Name":"��� �������� (��������, �������, ��������)" }, 
                        {  "Value":"ZALLAST" , "Name":"������� �� ������� ���� ������ � ���. ���." }, 
                        {  "Value":"ZABDAY" , "Name":"������������� �������� ������������� �� ������ �����, ���." }, 
                        {  "Value":"RATE" , "Name":"г��� ��������� ������,%" }, 
                        {  "Value":"SUM" , "Name":"�������� ����, ���." }, 
                        {  "Value":"TAR" , "Name":"��������� ��������� �����, %" }, 
                        {  "Value":"STRSUM" , "Name":"��������� ����� �� ������ �����, ���.          (�.7 � �.8)" }, 
                        {  "Value":"RANGE" , "Name":"� ������� 930,75-6167" }, 
                        {  "Value":"NLS" , "Name":"�������� ������� �볺��� �� ���� ����������� ��" }, 
                        {  "Value":"KV" , "Name":"������ �������" }, 
                        {  "Value":"RNK" , "Name":"���" }, 
                        {  "Value":"ND" , "Name":"�������� ��������" }, 
                        {  "Value":"NLS" , "Name":"�������� ������� �볺��� �� ���� ����������� ��" }, 
                        {  "Value":"NLS" , "Name":"�������� ������� �볺��� �� ���� ����������� ��" }
]
'
where proc_name like 'BARS.P_NBU_CREDIT_INS(:p_file_name,:p_ddate,:p_clob,:p_message)';
end;
/
commit;
/
