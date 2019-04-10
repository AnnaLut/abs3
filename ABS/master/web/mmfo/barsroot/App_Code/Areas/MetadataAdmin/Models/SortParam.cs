namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    /// <summary>
    /// ��������� ���������� ������ � ����� �����������
    /// </summary>
    public class SortParam
    {
        public string Property { get; set; }
        public string Direction { get; set; }
        public string Order
        {
            get { return Property + " " + Direction; }
        }
    }
}